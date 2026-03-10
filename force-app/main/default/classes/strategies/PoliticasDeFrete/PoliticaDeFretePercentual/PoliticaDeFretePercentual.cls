public class PoliticaDeFretePercentual implements PoliticaDeFrete {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    private Decimal percentualFrete;

    public PoliticaDeFretePercentual(Decimal percentualFrete) {
        if (percentualFrete == null || percentualFrete < 0 || percentualFrete > 100) {
            throw new DomainException('O percentual de frete não pode ser nulo e deve estar entre 0 e 100.');
        }

        this.percentualFrete = percentualFrete;
    }

    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================

    public Dinheiro calcularFrete(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido para cálculo de frete não pode ser nulo.');
        }

        Dinheiro totalPedido = pedido.total;
        Decimal valorFrete = totalPedido.valor * (percentualFrete / 100);
        return new Dinheiro(valorFrete);
    }
}