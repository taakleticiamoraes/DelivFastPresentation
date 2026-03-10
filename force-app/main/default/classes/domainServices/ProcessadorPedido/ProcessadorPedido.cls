public class ProcessadorPedido {
    // ================================================================
    // ATRIBUTOS ESTRUTURAIS
    // ================================================================

    public PoliticaDeFrete politicaDeFrete {get; private set;}

    public ProcessadorPedido(PoliticaDeFrete politicaDeFrete) {
        if (politicaDeFrete == null) {
            throw new IllegalArgumentException('A política de frete não pode ser nula.');
        }

        this.politicaDeFrete = politicaDeFrete;
    }

    // ================================================================
    // MÉTODOS UTILITÁRIOS
    // ================================================================

    public void alterarPolitica(PoliticaDeFrete politicaDeFrete) {
        this.politicaDeFrete = politicaDeFrete;
    }

    // ----------------------------------------------------------------

    public Dinheiro calcularTotalComFrete (Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido para cálculo do total com frete não pode ser nulo.');
        }
        if (pedido.total == null || pedido.total.valor < 0) {
            throw new IllegalArgumentException('O total do pedido deve ter um valor válido para calcular o total com frete.');
        }

        Dinheiro totalBase = pedido.total;
        if (totalBase == null) {
            totalBase = new Dinheiro(0);
        }

        Dinheiro frete = politicaDeFrete.calcularFrete(pedido);

        pedido.aplicarFrete(frete);

        Dinheiro totalComFrete = totalBase.somar(frete);
        System.debug('Total do Pedido: ' + totalBase.valor + '; Frete: ' + frete.valor + '; Total com Frete: ' + totalComFrete.valor + '.');

        return totalComFrete;
    }

    // ----------------------------------------------------------------

    public void confirmarPedido(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido a ser confirmado não pode ser nulo.');
        }

        pedido.validarRestauranteAtivo();

        pedido.confirmar();
    }

    // ----------------------------------------------------------------

    public void cancelarPedido(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido a ser cancelado não pode ser nulo.');
        }

        pedido.cancelar();
    }

    // ----------------------------------------------------------------

    public void marcarEntrega(Pedido pedido) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido a ser marcado como entregue não pode ser nulo.');
        }

        pedido.marcarComoEntregue();
    }

    // ----------------------------------------------------------------

    public void alterarQuantidade(Pedido pedido, Produto produto, Integer novaQuantidade) {
        if (pedido == null) {
            throw new IllegalArgumentException('O pedido cujo produto a ser modificado não pode ser nulo.');
        }

        pedido.alterarQuantidade(produto, novaQuantidade);
    }
}