public class EstadoPedidoCarrinho extends EstadoPedido {
    // ================================================================
    // OVERRIDES DA CLASSE ABSTRATA
    // ================================================================
    
    public override void adicionarProduto(Pedido pedido, Produto produto, Integer quantidade) {
        pedido.adicionarProdutoInterno(produto, quantidade);
    }

    public override void removerProduto(Pedido pedido, Produto produto) {
        pedido.removerProdutoInterno(produto);
    }

    public override void confirmar(Pedido pedido) {
        if (pedido.getQuantidadeItens() == 0) {
            throw new DomainException('Não é possível confirmar um pedido sem produtos.');
        }
        if (pedido.total == null || pedido.total.valor <= 0) {
            throw new DomainException('O total do pedido deve ser maior que zero para confirmar.');
        }
        if (!pedido.todosItensValidos()) {
            throw new DomainException('Todos os itens do pedido devem ser válidos para confirmar.');
        }

        pedido.setEstado(new EstadoPedidoEmProcessamento());
        System.debug('Pedido confirmado e enviado para processamento.');
    }

    public override void cancelar(Pedido pedido) {
        pedido.setEstado(new EstadoPedidoCancelado());
        System.debug('Pedido cancelado com sucesso.');
    }

    public override void marcarComoEntregue(Pedido pedido) {
        throw new StateException('Marcar o pedido como entregue não é possível em seu estado atual.');
    }

    public override void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade) {
        pedido.alterarQuantidadeInterno(produto, novaQuantidade);
    }

    public override void recalcularTotal(Pedido pedido) {
        pedido.recalcularTotalInterno();
    }
}