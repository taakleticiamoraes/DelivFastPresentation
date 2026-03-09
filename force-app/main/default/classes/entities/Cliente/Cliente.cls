public class Cliente extends Pessoa {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public Endereco endereco {get; private set;}
    public String telefone {get; private set;}

    public Cliente(String nome, Documento documento, Endereco endereco, String telefone) {
        super(nome, documento);

        if (endereco == null) {
            throw new IllegalArgumentException('O endereço do cliente não pode ser nulo.');
        }
        if (String.isBlank(telefone)) {
            throw new IllegalArgumentException('O telefone do cliente não pode ser vazio.');
        }

        this.endereco = endereco;
        this.telefone = telefone;
    }

    public override String getTipoPessoa() {
        return 'Cliente';
    }
}