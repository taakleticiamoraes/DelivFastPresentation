public class Endereco {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String logradouro {get; private set;}
    public String numero {get; private set;}
    public String complemento {get; private set;}
    public String cidade {get; private set;}

    public Endereco(String logradouro, String numero, String complemento, String cidade) {
        if (String.isBlank(logradouro)) {
            throw new IllegalArgumentException('O logradouro do endereço não pode ser nulo');
        }
        if (String.isBlank(numero)) {
            throw new IllegalArgumentException('O número do endereço não pode ser nulo');
        }
        if (String.isBlank(cidade)) {
            throw new IllegalArgumentException('A cidade do endereço não pode ser nula');
        }

        this.logradouro = logradouro;
        this.numero = numero;
        this.complemento = complemento;
        this.cidade = cidade;
    }
}