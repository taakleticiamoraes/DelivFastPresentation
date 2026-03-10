public class Endereco {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String logradouro {get; private set;}
    public String numero {get; private set;}
    public String complemento {get; private set;}
    public String cidade {get; private set;}

    public Endereco(String logradouro, String numero, String cidade) {
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
        this.complemento = '';
        this.cidade = cidade;
    }

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
        this.complemento = (complemento != null)? complemento : '';
        this.cidade = cidade;
    }

    // ================================================================
    // MÉTODOS AUXILIARES
    // ================================================================

    public Boolean equals(Object obj) {
        if (obj == null || !(obj instanceof Endereco)) return false;
        Endereco other = (Endereco)obj;

        return (this.logradouro == other.logradouro 
                && this.numero == other.numero
                && this.complemento == other.complemento
                && this.cidade == other.cidade
        );
    }

    public override Integer hashCode(){
        String enderecoCompleto = this.logradouro + '|'
            + this.numero + '|'
            + this.complemento + '|'
            + this.cidade;
        
        return enderecoCompleto.hashCode();
    }
}