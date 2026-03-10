public class RelatorioVendas {

    public static Map<Produto, Integer> gerarRelatorioProdutosMaisVendidos(List<Pedido> pedidos) {
        Map<Produto, Integer> totalPorProduto = new Map<Produto, Integer>();

        for (Pedido p : pedidos) {
            if(!(p.estado instanceof EstadoPedidoEntregue)) continue;
                
            for (ItemWrapper item : p.getItensWrapper()) {
                if(!totalPorProduto.containsKey(item.getProduto())) {totalPorProduto.put(item.getProduto(),item.getQuantidade());}
                
                else {totalPorProduto.put(item.getProduto(),totalPorProduto.get(item.getProduto()) + item.getQuantidade());}
                    
            }
            
        }
        
        List<ItemWrapper> mais_vendidos = gerarRankingDeProdutos(totalPorProduto);
        for (Integer i = 0; i < Math.min(3, mais_vendidos.size()); i++) {
            System.debug((i + 1) + '. ' + mais_vendidos[i].getProduto().nome + ' - ' 
                          + mais_vendidos[i].getQuantidade() + ' unidades');
        }

        

        return totalPorProduto;
    }

    

      
    public static List<ItemWrapper> gerarRankingDeProdutos(Map<Produto,Integer> totalPorProduto) {
        List<ItemWrapper> ranking = new List<ItemWrapper>();
        for (Produto p : totalPorProduto.keySet()) {
            ranking.add(new ItemWrapper(p, totalPorProduto.get(p)));

        } 
        ranking.sort();
        return ranking;
        
    }
   

    


}