public class EstadoPedidoEmProcessamento extends EstadoPedido {
    // ================================================================
    // OVERRIDES DA CLASSE ABSTRATA
    // ================================================================
    
    public override void adicionarProduto(Pedido pedido, Produto produto, Integer quantidade) {
        throw new StateException('Não é possível adicionar um produto ao pedido em seu estado atual.');
    }

    public override void removerProduto(Pedido pedido, Produto produto) {
        throw new StateException('Não é possível remover um produto ao pedido em seu estado atual.');
    }

    public override void confirmar(Pedido pedido) {
        throw new StateException('Não é possível confirmar o pedido em seu estado atual.');
    }

    public override void cancelar(Pedido pedido) {
        pedido.setEstado(new EstadoPedidoCancelado());
        System.debug('Pedido cancelado com sucesso.');
    }

    public override void marcarComoEntregue(Pedido pedido) {
        pedido.setEstado(new EstadoPedidoEntregue());
        System.debug('Pedido marcado como entregue com sucesso.');
    }

    public override void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade) {
        throw new StateException('Não é possível alterar a quantidade de algum produto do pedido em seu estado atual.');
    }

    public override void recalcularTotal(Pedido pedido) {
        throw new StateException('Não é possível recalcular o total do pedido em seu estado atual.');
    }
}