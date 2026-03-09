public class Produto extends EntidadeBase {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String nome {get; private set;}
    public Dinheiro precoBase {get; private set;}
    public PoliticaDePreco politicaDePreco {get; private set;}

    public Produto(String nome, Dinheiro precoBase, PoliticaDePreco politicaDePreco) {
        super();
        
        if (String.isBlank(nome)) {
            throw new IllegalArgumentException('O nome do produto não pode ser vazio.');
        }
        if (precoBase == null) {
            throw new IllegalArgumentException('O preço base do produto não pode ser nulo.');
        }
        if (politicaDePreco == null) {
            throw new IllegalArgumentException('A política de preço do produto não pode ser nula.');
        }

        this.nome = nome;
        this.precoBase = precoBase;
        this.politicaDePreco = politicaDePreco;
    }

    public Dinheiro preco = politicaDePreco.calcularPreco(this);
}