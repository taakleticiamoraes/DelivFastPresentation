public abstract class Pessoa extends EntidadeBase {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String nome {get; private set;}
    public Documento documento {get; private set;}

    public Pessoa(String nome, Documento documento) {
        super();
        
        if (String.isBlank(nome)) {
            throw new IllegalArgumentException('O nome da pessoa não pode ser nulo.');
        }
        if (documento == null) {
            throw new IllegalArgumentException('O documento da pessoa não pode ser nulo.');
        }

        this.nome = nome;
        this.documento = documento;
    }

    // ================================================================
    // MÉTODOS ABSTRATOS
    // ================================================================

    public abstract String getTipoPessoa();
}