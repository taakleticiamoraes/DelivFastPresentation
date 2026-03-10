public class RelatorioClientes {
    // ================================================================
    // RELATÓRIO
    // ================================================================

    public static Map<String, List<Pedido>> gerarRelatorioPedidosPorCliente(List<Pedido> pedidos, List<Documento> cpfs) {
        Map<String, List<Pedido>> relatorio = new Map<String, List<Pedido>>();

        for (Pedido p : pedidos) {
            if (!(p.estado instanceof EstadoPedidoEntregue)) continue;
            for (Documento cpf : cpfs) {
                if (p.cliente.documento.valor == cpf.valor) {
                    List<Pedido> pedidosCliente = relatorio.containsKey(cpf.valor) ? relatorio.get(cpf.valor) : new List<Pedido>();
                    pedidosCliente.add(p);
                    relatorio.put(cpf.valor, pedidosCliente);
                }
            }
        }

        System.debug('Relatório de pedidos por cliente:');  
        for(String cpf : relatorio.keySet()) {
            List<Pedido> pedidosCliente = relatorio.get(cpf);
            System.debug('CPF: ' + cpf + ' - Total de pedidos: ' + pedidosCliente.size());
        }
        
        return relatorio;
    }
}