public class ItemWrapper implements Comparable {
    private Produto produto;
    private Integer quantidade;


    public ItemWrapper(Produto produto, Integer quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }


    public Integer compareTo(Object obj) {
            ItemWrapper outroItem = (ItemWrapper) obj;
            
            if(this.quantidade == outroItem.quantidade) {
                return this.produto.nome.toLowerCase().compareTo(outroItem.produto.nome.toLowerCase());
                
            }else if(this.quantidade < outroItem.quantidade) {
                return 1; 

            }else{
                return -1; 
            }
        }
    


    public Produto getProduto() {return this.produto;}
    public Integer getQuantidade() {return this.quantidade;}

}