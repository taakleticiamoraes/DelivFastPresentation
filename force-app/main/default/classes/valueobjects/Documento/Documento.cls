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
}