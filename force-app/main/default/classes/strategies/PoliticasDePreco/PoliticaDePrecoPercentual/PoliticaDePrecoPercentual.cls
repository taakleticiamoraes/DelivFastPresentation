public class PoliticaDePrecoPercentual implements PoliticaDePreco {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    private Decimal percentualDesconto;

    public PoliticaDePrecoPercentual(Decimal percentualDesconto) {
        if (percentualDesconto == null || percentualDesconto < 0 || percentualDesconto > 100) {
            throw new DomainException('O percentual de desconto não pode ser nulo e deve estar entre 0 e 100.');
        }

        this.percentualDesconto = percentualDesconto;
    }

    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================

    public Dinheiro calcularPreco(Produto produto) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto para cálculo de preço não pode ser nulo.');
        }
        
        Dinheiro precoBase = produto.precoBase;
        Decimal desconto = precoBase.valor * (percentualDesconto / 100);
        return new Dinheiro(precoBase.valor - desconto);
    }
}