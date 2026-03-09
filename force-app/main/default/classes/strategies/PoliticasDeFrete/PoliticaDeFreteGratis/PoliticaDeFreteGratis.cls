public class PoliticaDeFreteGratis implements PoliticaDeFrete {
    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================

    public Dinheiro calcularFrete(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido para cálculo de frete não pode ser nulo.');
        }

        return new Dinheiro(0);
    }
}