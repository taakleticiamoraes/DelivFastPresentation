public abstract class EstadoPedido {
    // ================================================================
    // MÉTODOS ABSTRATOS
    // ================================================================

    public abstract void adicionarProduto(Pedido pedido, Produto produto, Integer quantidade);

    public abstract void removerProduto(Pedido pedido, Produto produto);

    public abstract void confirmar(Pedido pedido);

    public abstract void cancelar(Pedido pedido);

    public abstract void marcarComoEntregue(Pedido pedido);

    public abstract void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade);

    public abstract void recalcularTotal(Pedido pedido);
}