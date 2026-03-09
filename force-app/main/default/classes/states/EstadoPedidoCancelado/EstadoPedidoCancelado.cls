public class EstadoPedidoCancelado extends EstadoPedido {
    // ================================================================
    // OVERRIDES DA CLASSE ABSTRATA
    // ================================================================
    
    public override void adicionarProduto(Pedido pedido, Produto produto, Integer quantidade) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void removerProduto(Pedido pedido, Produto produto) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void confirmar(Pedido pedido) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void cancelar(Pedido pedido) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void marcarComoEntregue(Pedido pedido) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }

    public override void recalcularTotal(Pedido pedido) {
        throw new IllegalArgumentException('Não é permitido alterar o estado de um pedido cancelado.');
    }
}