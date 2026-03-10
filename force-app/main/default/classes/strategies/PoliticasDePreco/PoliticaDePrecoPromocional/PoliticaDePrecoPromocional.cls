public class PoliticaDePrecoPromocional implements PoliticaDePreco {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    private Integer horaInicioPromocao;
    private Integer horaFimPromocao;
    private Decimal percentualDesconto;

    public PoliticaDePrecoPromocional(Integer horaInicioPromocao, Integer horaFimPromocao, Decimal percentualDesconto) {
        if (horaInicioPromocao == null || horaFimPromocao == null ||
            horaInicioPromocao < 0 || horaInicioPromocao > 23 ||
            horaFimPromocao < 0 || horaFimPromocao > 23) {
            throw new DomainException('As horas de início e fim da promoção não podem ser nulas e devem estar entre 0 e 23.');
        }
        if (percentualDesconto == null || percentualDesconto < 0 || percentualDesconto > 100) {
            throw new DomainException('O percentual de desconto não pode ser nulo e deve estar entre 0 e 100');
        }

        this.horaInicioPromocao = horaInicioPromocao;
        this.horaFimPromocao = horaFimPromocao;
        this.percentualDesconto = percentualDesconto;
    }

    // ================================================================
    // OVERRIDE DA INTERFACE
    // ================================================================
    
    public Dinheiro calcularPreco(Produto produto) {
        if (produto == null) {
            throw new IllegalArgumentException('O produto para cálculo de preço não pode ser nulo.');
        }

        Integer horaAtual = DateTime.now().hour();
        Dinheiro precoBase = produto.precoBase;
        Boolean emPromocao;

        if (horaInicioPromocao < horaFimPromocao) {
            emPromocao = horaAtual >= horaInicioPromocao && horaAtual < horaFimPromocao;
        } else if (horaInicioPromocao > horaFimPromocao) {
            emPromocao = horaAtual >= horaInicioPromocao || horaAtual < horaFimPromocao;
        } else {
            emPromocao = false;
        }

        if (emPromocao) {
            Decimal desconto = 1 - (percentualDesconto / 100);
            return precoBase.multiplicar(desconto);
        }

        return precoBase;
    }
}