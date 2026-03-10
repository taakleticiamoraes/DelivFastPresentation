public class PoliticaDeFreteFixo implements PoliticaDeFrete {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    private Decimal frete;

    public PoliticaDeFreteFixo(Decimal frete) {
        if (frete == null || frete < 0) {
            throw new DomainException('O valor do frete não pode ser nulo ou negativo.');
        }

        this.frete = frete;
    }

    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================

    public Dinheiro calcularFrete(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido para cálculo de frete não pode ser nulo.');
        }

        return new Dinheiro(frete);
    }
}