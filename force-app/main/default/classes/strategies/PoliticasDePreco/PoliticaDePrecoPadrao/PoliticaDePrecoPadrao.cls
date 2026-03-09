public class PoliticaDePrecoPadrao implements PoliticaDePreco {
    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================
    
    public Dinheiro calcularPreco(Produto produto) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto para cálculo de preço não pode ser nulo.');
        }

        return produto.precoBase;
    }
}