public class Pedido extends EntidadeBase {
    // ================================================================
    // CLASSE INTERNA
    // ================================================================

    private class ItemPedido {
        // ------------------------------------------------------------
        // ATRIBUTOS ESTRUTURAIS DA CLASSE INTERNA
        // ------------------------------------------------------------

        public Produto produto {get; private set;}
        public Integer quantidade {get; private set;}
        public Dinheiro subTotal {get; private set;}

        private ItemPedido(Produto produto, Integer quantidade) {
            if (produto == null) {
                throw new IllegalArgumentException('O produto do item de pedido não pode ser nulo.');
            }
            if (quantidade == null || quantidade <= 0) {
                throw new IllegalArgumentException('A quantidade do item de pedido deve ser maior que zero.');
            }

            this.produto = produto;
            this.quantidade = quantidade;
            this.subTotal = calcularSubTotal();
        }

        // ------------------------------------------------------------
        // MÉTODOS UTILITÁRIOS DA CLASSE INTERNA
        // ------------------------------------------------------------

        private Dinheiro calcularSubTotal() {
            if (this.produto != null && this.produto.preco != null) {
                return this.produto.preco.multiplicar(this.quantidade);
            }

            return new Dinheiro(0);
        }
    }

    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public Cliente cliente {get; private set;}
    public Restaurante restaurante {get; private set;}
    public List<ItemPedido> itens {get; private set;}
    public EstadoPedido estado {get; private set;}
    public Dinheiro total {get; private set;}

    public Pedido(Cliente cliente, Restaurante restaurante) {
        if (cliente == null) {
            throw new IllegalArgumentException('O cliente do pedido não pode ser nulo.');
        }
        if (restaurante == null) {
            throw new IllegalArgumentException('O restaurante do pedido não pode ser nulo.');
        }

        this.cliente = cliente;
        this.restaurante = restaurante;
        this.itens = new List<ItemPedido>();
        this.estado = new EstadoPedidoCarrinho();
        this.total = new Dinheiro(0);
    }

    public Integer getQuantidadeItens() {
        return this.itens.size();
    }

    // ================================================================
    // MÉTODOS DE ESTADO
    // ================================================================

    public void setEstado(EstadoPedido novoEstado) {
        if (novoEstado == null) {
            throw new IllegalArgumentException('O novo estado do pedido não pode ser nulo.');
        }
        this.estado = novoEstado;
    }

    // ----------------------------------------------------------------

    public void adicionarProduto(Produto produto, Integer quantidade) {
        this.estado.adicionarProduto(this, produto, quantidade);
    }

    public void removerProduto(Produto produto) {
        this.estado.removerProduto(this, produto);
    }

    public void confirmar() {
        this.estado.confirmar(this);
    }

    public void cancelar() {
        this.estado.cancelar(this);
    }

    public void marcarComoEntregue() {
        this.estado.marcarComoEntregue(this);
    }

    public void alterarQuantidade(Produto produto, Integer novaQuantidade) {
        this.estado.alterarQuantidade(this, produto, novaQuantidade);
    }

    public void recalcularTotal() {
        this.estado.recalcularTotal(this);
    }

    // ================================================================
    // MÉTODOS INTERNOS
    // ================================================================

    public void adicionarProdutoInterno(Produto produto, Integer quantidade) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto a ser adicionado não pode ser nulo.');
        }
        if (quantidade == null || quantidade <= 0) {
            throw new IllegalArgumentException('A quantidade do produto a ser adicionada deve ser maior que zero.');
        }

        Boolean produtoExisteNoCardapio = false;

        if (this.restaurante.cardapio != null) {
            for (Produto p : this.restaurante.cardapio) {
                if (p.nome != null && produto.nome != null && p.nome.equalsIgnoreCase(produto.nome)) {
                    produtoExisteNoCardapio = true;
                    break;
                }
            }
        }

        if (!produtoExisteNoCardapio) {
            throw new IllegalArgumentException('O produto a ser adicionado não está disponível no cardápio do restaurante.');
        }

        Integer indiceItemExistente = -1;

        for (Integer i = 0; i < this.itens.size(); i++) {
            Pedido.ItemPedido item = this.itens[i];
            if (item.produto.nome != null && produto.nome != null && item.produto.nome.equalsIgnoreCase(produto.nome)) {
                indiceItemExistente = i;
                break;
            }
        }

        if (indiceItemExistente >= 0) {
            Pedido.ItemPedido itemExistente = this.itens[indiceItemExistente];
            this.itens.remove(indiceItemExistente);
            Pedido.ItemPedido novoItem = new Pedido.ItemPedido(produto, itemExistente.quantidade + quantidade);
            this.itens.add(novoItem);
        } else {
            this.itens.add(new Pedido.ItemPedido(produto, quantidade));
        }

        System.debug('O seguinte produto foi adicionado: ' + produto.nome + ' (Qtd.: ' + quantidade + ').');
        this.recalcularTotalInterno();
    }

    // ----------------------------------------------------------------

    public void removerProdutoInterno(Produto produto) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto a ser removido não pode ser nulo.');
        }

        Integer indiceItemExistente = -1;

        for (Integer i = 0; i < this.itens.size(); i++) {
            ItemPedido item = this.itens[i];
            if (item.produto.nome != null && produto.nome != null && item.produto.nome.equalsIgnoreCase(produto.nome)) {
                indiceItemExistente = i;
                break;
            }
        }

        if (indiceItemExistente >= 0) {
            this.itens.remove(indiceItemExistente);
            System.debug('O seguinte produto foi removido: ' + produto.nome + '.');
            this.recalcularTotalInterno();
        } else {
            throw new IllegalArgumentException('O produto a ser removido não foi encontrado no pedido.');
        }
    }

    // ----------------------------------------------------------------

    public void alterarQuantidadeInterno(Produto produto, Integer novaQuantidade) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto cuja quantidade será alterada não pode ser nulo.');
        }
        if (novaQuantidade == null) {
            throw new IllegalArgumentException('A nova quantidade do produto deve ser maior que zero.');
        }

        Integer indiceItemExistente = -1;

        for (Integer i = 0; i < this.itens.size(); i++) {
            ItemPedido item = this.itens[i];
            if (item.produto.nome != null && produto.nome != null && item.produto.nome.equalsIgnoreCase(produto.nome)) {
                indiceItemExistente = i;
                break;
            }
        }

        if (indiceItemExistente < 0) {
            throw new IllegalArgumentException('O produto cuja quantidade será alterada não foi encontrado no pedido.');
        }

        if (novaQuantidade <= 0) {
            this.itens.remove(indiceItemExistente);
            System.debug('O seguinte produto foi removido devido à alteração de quantidade para zero ou negativo: ' + produto.nome + '.');
        } else {
            this.itens.remove(indiceItemExistente);
            this.itens.add(new ItemPedido(produto, novaQuantidade));
            System.debug('A quantidade do produto ' + produto.nome + ' foi alterada para ' + novaQuantidade + '.');
        }

        this.recalcularTotalInterno();
    }

    // ----------------------------------------------------------------

    public void recalcularTotalInterno() {
        this.total = new Dinheiro(0);

        if (this.itens != null) {
            for (ItemPedido item : this.itens) {
                Dinheiro subTotal = item.subTotal;
                this.total = this.total.somar(subTotal);
            }
        }
    }

    // ================================================================
    // MÉTODOS AUXILIARES
    // ================================================================

    public Boolean todosItensValidos() {
        if (this.itens == null || this.itens.isEmpty()) {
            return false;
        }

        for (ItemPedido item : this.itens) {
            if (item == null || item.produto == null || item.quantidade == null || item.quantidade <= 0) {
                return false;
            }
        }

        return true;
    }

    // ================================================================
    // RELATÓRIOS ESTATÍSTICOS
    // ================================================================

    public void exibirResumo() {
        System.debug('============ RESUMO DO PEDIDO ============');
        System.debug('Cliente: ' + this.cliente.nome);
        System.debug('Restaurante: ' + this.restaurante.nome);
        System.debug('Status: ' + this.estado);
        System.debug('----------------- ITENS -----------------');

        if (this.itens == null || this.itens.isEmpty()) {
            System.debug('Nenhum item adicionado ao pedido.');
        } else {
            for (ItemPedido item : this.itens) {
                String subtotalFormatado = item.subTotal != null ? item.subTotal.toString() : 'R$ 0,00';
                System.debug('Produto: ' + item.produto.nome + ' | Quantidade: ' + item.quantidade + ' | Subtotal: ' + subtotalFormatado);
            }
        }

        String totalFormatado = this.total != null ? this.total.toString() : 'R$ 0,00';
        System.debug('----------------- TOTAL -----------------');
        System.debug('Total do Pedido: ' + totalFormatado);
        System.debug('=========================================');
    }
}