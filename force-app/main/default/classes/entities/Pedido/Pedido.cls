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
            if (this.produto != null) {
                return this.produto.calcularPrecoFinal().multiplicar(quantidade);
            }

            return new Dinheiro(0);
        }
    }

    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public Cliente cliente {get; private set;}
    public Restaurante restaurante {get; private set;}
    public Map<String, ItemPedido> itens {get; private set;}
    public EstadoPedido estado {get; private set;}
    public Dinheiro total {get; private set;}
    public Dinheiro frete {get; private set;}

    public Pedido(Cliente cliente, Restaurante restaurante) {
        if (cliente == null) {
            throw new IllegalArgumentException('O cliente do pedido não pode ser nulo.');
        }
        if (restaurante == null) {
            throw new IllegalArgumentException('O restaurante do pedido não pode ser nulo.');
        }

        this.cliente = cliente;
        this.restaurante = restaurante;
        this.itens = new Map<String, ItemPedido>();
        this.estado = new EstadoPedidoCarrinho();
        this.total = new Dinheiro(0);
        this.frete = new Dinheiro(0);
    }

    public Integer getQuantidadeItens() {
        return this.itens.size();
    }

    public Dinheiro getTotalCompra() {
        return this.total.somar(this.frete);
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
        validarQuantidade(quantidade);
        validarProdutoRestaurante(produto);

        if (this.itens.containsKey(produto.id)) {
            this.itens.put(produto.id, new ItemPedido(produto, this.itens.get(produto.id).quantidade + quantidade));
            System.debug('Quantidade atualizada.');
        } else {
            this.itens.put(produto.id, new ItemPedido(produto, quantidade));
        }

        System.debug('O seguinte produto foi adicionado: ' + produto.nome + ' (Qtd.: ' + quantidade + ').');
        this.recalcularTotalInterno();
    }

    // ----------------------------------------------------------------

    public void removerProdutoInterno(Produto produto) {
        if (this.itens.containsKey(produto.id)) {
            this.itens.remove(produto.id);
            System.debug('O seguinte produto foi removido: ' + produto.nome + '.');
            this.recalcularTotalInterno();
        } else {
            throw new IllegalArgumentException('O produto não pode ser removido pois não está no pedido.');
        }
    }

    // ----------------------------------------------------------------

    public void alterarQuantidadeInterno(Produto produto, Integer novaQuantidade) {
        if (novaQuantidade <= 0) {removerProduto(produto);}

        if (this.itens.containsKey(produto.id)) {
            this.itens.put(produto.id, new ItemPedido(produto, novaQuantidade));
            System.debug('A quantidade do produto ' + produto.nome + ' foi alterada para ' + novaQuantidade + '.');
            this.recalcularTotalInterno();
        } else {
            throw new IllegalArgumentException('O produto não pode ser alterado pois não está no pedido');
        }
    }

    // ----------------------------------------------------------------

    public void recalcularTotalInterno() {
        this.total = new Dinheiro(0);

        if (this.itens != null) {
            for (ItemPedido item : this.itens.values()) {
                this.total = this.total.somar(item.subTotal);
            }
        }
    }

    // ----------------------------------------------------------------

    public void aplicarFrete(Dinheiro frete) {
        this.frete = frete;
    }

    // ----------------------------------------------------------------

     public List<ItemWrapper> getItensWrapper(){
        List<ItemWrapper> itensWrapper = new List<ItemWrapper>();
        for (ItemPedido item : this.itens.values()) {
            itensWrapper.add(new ItemWrapper(item.produto, item.quantidade));
        }
        return itensWrapper;
    }


    


   

    // ================================================================
    // MÉTODOS DE VALIDAÇÃO
    // ================================================================

    public Boolean todosItensValidos() {
        if (this.itens == null || this.itens.isEmpty()) {
            return false;
        }

        for (ItemPedido item : this.itens.values()) {
            if (item == null || item.produto == null || item.quantidade == null || item.quantidade <= 0) {
                return false;
            }
        }

        return true;
    }

    // ----------------------------------------------------------------

    public void validarQuantidade(Integer quantidade) {
        if (quantidade <= 0) throw new IllegalArgumentException('A quantidade passada é inválida');
    }

    // ----------------------------------------------------------------

    public void validarRestauranteAtivo() {
        if (this.restaurante.restauranteAtivo == false) throw new IllegalArgumentException('O restaurante está inativo');
    }

    // ----------------------------------------------------------------

    public void validarProdutoRestaurante(Produto produto) {
        if (this.restaurante.buscarProdutos(produto.nome).isEmpty()) {
            throw new IllegalArgumentException('Produto não encontrado.');
        }
    }
    
    // ----------------------------------------------------------------

    public void validarTotalBase() {
        if (this.total.valor < 0) throw new IllegalArgumentException('O total é inválido');
    }

    // ----------------------------------------------------------------

    public List<ItemPedido> getItens() {
        return this.itens.values();
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
            for (ItemPedido item : this.itens.values()) {
                String subtotalFormatado = item.subTotal != null ? item.subTotal.valor.toString() : 'R$ 0,00';
                System.debug('Produto: ' + item.produto.nome + ' - Quantidade: ' + item.quantidade + ' - Subtotal: ' + subtotalFormatado);
            }
        }

        String totalFormatado = this.total.valor != null ? this.total.valor.toString() : 'R$ 0,00';
        System.debug('----------------- TOTAL -----------------');
        System.debug('Total do Pedido: ' + totalFormatado);
        System.debug('Frete: ' + this.frete.valor);
        System.debug('Total Final: ' + this.total.somar(this.frete).valor);
        System.debug('=========================================');
    }
}