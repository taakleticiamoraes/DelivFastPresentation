public class Restaurante extends EntidadeBase {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String nome {get; private set;}
    public Endereco endereco {get; private set;}
    public CategoriaRestaurante categoria {get; private set;}
    public List<Produto> cardapio {get; private set;}

    public Restaurante(String nome, Endereco endereco, CategoriaRestaurante categoria, List<Produto> cardapio) {
        super();

        if (String.isBlank(nome)) {
            throw new IllegalArgumentException('O nome do restaurante não pode ser vazio.');
        }
        if (endereco == null) {
            throw new IllegalArgumentException('O endereço do restaurante não pode ser nulo.');
        }
        if (categoria == null) {
            throw new IllegalArgumentException('A categoria do restaurante não pode ser nula');
        }

        this.nome = nome;
        this.endereco = endereco;
        this.categoria = categoria;
        this.cardapio = cardapio;
    }

    // ================================================================
    // MÉTODOS UTILITÁRIOS
    // ================================================================

    public void adicionarProduto(Produto produto) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto a ser adicionado não pode ser nulo.');
        }
        if (this.cardapio == null) {
            this.cardapio = new List<Produto>();
        }

        for (Produto p : this.cardapio) {
            if (p.nome != null && produto.nome != null && p.nome.equalsIgnoreCase(produto.nome)) {
                throw new IllegalArgumentException('Já existe um produto com o mesmo nome no cardápio.');
            }
        }

        this.cardapio.add(produto);
        String precoFormatado = 'R$ '+ produto.preco;
        System.debug('O produto ' + produto.nome + ' foi adicionado ao cardápio do restaurante ' + this.nome + ' com preço ' + precoFormatado + '.');
    }

    // ----------------------------------------------------------------

    public void exibirCardapio() {
        if (this.cardapio == null || this.cardapio.isEmpty()) {
            System.debug('O cardápio do restaurante ' + this.nome + ' está vazio.');
            return;
        }

        Integer indice = 1;
        System.debug('Cardápio do Restaurante ' + this.nome + ':');
        for (Produto produto : this.cardapio) {
            String precoFormatado = 'R$ '+ produto.preco;
            System.debug(indice + '. ' + produto.nome + ' - ' + precoFormatado);
            indice++;
        }
    }

    // ----------------------------------------------------------------

    public List<Produto> buscarProdutos(String termoBusca) {
        List<Produto> resultados = new List<Produto>();

        if (this.cardapio != null && this.cardapio.isEmpty()) {
            System.debug('O cardápio do restaurante ' + this.nome + ' está vazio. Nenhum produto foi encontrado para a busca.');
            return resultados;
        }

        if (String.isBlank(termoBusca)) {
            System.debug('Nenhum termo de busca foi fornecido.');
            return resultados;
        }

        for (Produto produto : this.cardapio) {
            if (produto.nome != null && produto.nome.toLowerCase().contains(termoBusca.toLowerCase())) {
                resultados.add(produto);
            }
        }

        Integer indice = 1;
        if (resultados.isEmpty()) {
            System.debug('Nenhum produto foi encontrado para o termo de busca "' + termoBusca + '".');
        } else {
            System.debug('Produtos encontrados para o termo de busca "' + termoBusca + '":');
            for (Produto produto : resultados) {
                String precoFormatado = 'R$ '+ produto.preco;
                System.debug(indice + '. ' + produto.nome + ' - ' + precoFormatado);
                indice++;
            }
        }

        return resultados;
    }
}