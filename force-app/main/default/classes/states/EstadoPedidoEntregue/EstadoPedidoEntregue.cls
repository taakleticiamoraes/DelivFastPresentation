public class EstadoPedidoEntregue extends EstadoPedido {
    // ================================================================
    // OVERRIDES DA CLASSE ABSTRATA
    // ================================================================
    
    public override void adicionarProduto(Pedido pedido, Produto produto, Integer quantidade) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void removerProduto(Pedido pedido, Produto produto) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void confirmar(Pedido pedido) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void cancelar(Pedido pedido) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void marcarComoEntregue(Pedido pedido) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }

    public override void recalcularTotal(Pedido pedido) {
        throw new StateException('Não é permitido alterar o estado de um pedido entregue.');
    }
}