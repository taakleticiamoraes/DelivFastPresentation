public class Documento {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public String valor {get; private set;}

    public Documento(String valor) {
        if (String.isBlank(valor)) {
            throw new IllegalArgumentException('O valor do documento não pode ser nulo.');
        }

        this.valor = valor;
    }

    // ================================================================
    // MÉTODOS AUXILIARES
    // ================================================================

    public Boolean equals(Object obj) {
        if (obj == null || !(obj instanceof Documento)) return false;
        if (this === obj) return true;

        Documento outro = (Documento) obj;

        return this.valor == outro.valor;
    }

    public Integer hashCode() {return this.valor.hashCode();}
}