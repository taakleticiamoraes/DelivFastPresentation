public class Dinheiro {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public Decimal valor {get; private set;}

    public Dinheiro(Decimal valor) {
        if (valor == null || valor < 0) {
            throw new IllegalArgumentException('O valor do dinheiro não pode ser nulo ou negativo');
        }

        this.valor = valor.setScale(2, RoundingMode.HALF_UP);
    }

    // ================================================================
    // MÉTODOS UTILITÁRIOS
    // ================================================================

    public Dinheiro somar(Dinheiro soma) {
        if (soma == null) {
            throw new IllegalArgumentException('O valor a ser somado não pode ser nulo.');
        }

        return new Dinheiro(this.valor + soma.valor);
    }

    // ----------------------------------------------------------------

    public Dinheiro subtrair(Dinheiro subtracao) {
        if (subtracao == null) {
            throw new IllegalArgumentException('O valor a ser subtraído não pode ser nulo.');
        }

        Decimal resultado = this.valor - subtracao.valor;

        if (resultado < 0) {
            throw new IllegalArgumentException('O resultado da subtração não pode ser negativo.');
        }

        return new Dinheiro(resultado);
    }

    // ----------------------------------------------------------------

    public Dinheiro multiplicar(Decimal multiplicador) {
        if (multiplicador == null || multiplicador < 0) {
            throw new IllegalArgumentException('O multiplicador não pode ser nulo ou negativo.');
        }

        return new Dinheiro(this.valor * multiplicador);
    }

    // ================================================================
    // MÉTODOS AUXILIARES
    // ================================================================

    public Boolean equals(Object obj) {
        if (obj == null || !(obj instanceof Dinheiro)) return false;
        if (this === obj) return true;

        Dinheiro outro = (Dinheiro) obj;

        return this.valor == outro.valor;
    }

    public Integer hashCode() {return this.valor.hashCode();}
}