// ================================================================
// TESTE
// ================================================================

System.debug('');
System.debug('======== TESTE TESTE TESTE ========');
System.debug('');

// ----------------------------------------------------------------

Documento documentoRoberto = new Documento('123.456.789-00');
Endereco enderecoRoberto = new Endereco('Rua Teste', '123', 'Apt 12', 'São Paulo');
Endereco enderecoA = new Endereco('Rua Teste', '123', 'São Paulo');
Cliente clienteRoberto = new Cliente('Roberto', documentoRoberto, enderecoRoberto, '(11) 99999-9999');

System.debug(clienteRoberto.documento.valor);
System.debug(clienteRoberto.getTipoPessoa());

// ----------------------------------------------------------------

PoliticaDePreco precoPadrao = new PoliticaDePrecoPadrao();
PoliticaDePreco precoPromocional = new PoliticaDePrecoPromocional(8, 16, 5);
PoliticaDePreco precoPercentual = new PoliticaDePrecoPercentual(10);

Produto cheeseBurger = new Produto('Cheese Burger', new Dinheiro(25), precoPadrao);
Produto cheeseSalada = new Produto('Cheese Salada', new Dinheiro(30), precoPromocional);
Produto cheeseBacon = new Produto('Cheese Bacon', new Dinheiro(35), precoPercentual);

System.debug(cheeseSalada.precoBase);
System.debug(cheeseSalada.calcularPrecoFinal());
System.debug(cheeseBacon.precoBase);
System.debug(cheeseBacon.calcularPrecoFinal());

Produto cocacola = new Produto('Coca-Cola', new Dinheiro(5), precoPadrao);
Produto guarana = new Produto('Guarana', new Dinheiro(5), precoPromocional);
Produto sprite = new Produto('Sprite', new Dinheiro(5), precoPercentual);

Produto pudim = new Produto('Pudim', new Dinheiro(10), precoPadrao);

// ----------------------------------------------------------------

Endereco enderecoBurger = new Endereco('Avenida Teste', '456', 'Apt 34', 'São Bernardo do Campo');
List<Produto> cardapioBurger = new List<Produto>{cheeseBurger, cheeseSalada, cheeseBacon, cocacola, guarana, sprite};
Restaurante restauranteBurger = new Restaurante('Burger', enderecoBurger, CategoriaRestaurante.HAMBURGUERIA, cardapioBurger, true);

restauranteBurger.exibirCardapio();
restauranteBurger.buscarProdutos('cheese');

restauranteBurger.adicionarProduto(pudim);
restauranteBurger.exibirCardapio();

// ----------------------------------------------------------------

Pedido pedidoRoberto1 = new Pedido(clienteRoberto, restauranteBurger);
Pedido pedidoRoberto2 = new Pedido(clienteRoberto, restauranteBurger);
Pedido pedidoRoberto3 = new Pedido(clienteRoberto, restauranteBurger);

// ----------------------------------------------------------------

PoliticaDeFrete freteGratis = new PoliticaDeFreteGratis();
PoliticaDeFrete freteFixo = new PoliticaDeFreteFixo(15);
PoliticaDeFrete fretePercentual = new PoliticaDeFretePercentual(10);

ProcessadorPedido processadorGratis = new ProcessadorPedido(freteGratis);
ProcessadorPedido processadorFixo = new ProcessadorPedido(freteFixo);
ProcessadorPedido processadorPercentual = new ProcessadorPedido(fretePercentual);

// ----------------------------------------------------------------

pedidoRoberto1.adicionarProduto(cheeseBurger, 1);
pedidoRoberto1.adicionarProduto(cheeseSalada, 1);
pedidoRoberto1.adicionarProduto(cocacola, 2);


System.debug(pedidoRoberto1.itens);
processadorFixo.calcularTotalComFrete(pedidoRoberto1);
pedidoRoberto1.exibirResumo();

pedidoRoberto1.removerProduto(cheeseBurger);
pedidoRoberto1.adicionarProduto(cheeseSalada, 1);

System.debug(pedidoRoberto1.itens);
processadorPercentual.calcularTotalComFrete(pedidoRoberto1);
pedidoRoberto1.exibirResumo();

// ----------------------------------------------------------------

processadorPercentual.alterarPolitica(freteGratis);
System.debug(processadorPercentual.politicaDeFrete);

processadorPercentual.calcularTotalComFrete(pedidoRoberto1);
pedidoRoberto1.exibirResumo();
processadorPercentual.alterarQuantidade(pedidoRoberto1, cheeseSalada, 3);
pedidoRoberto1.exibirResumo();

// ----------------------------------------------------------------

processadorPercentual.confirmarPedido(pedidoRoberto1);
// processadorPercentual.cancelarPedido(pedidoRoberto1);
processadorPercentual.marcarEntrega(pedidoRoberto1);
// pedidoRoberto1.adicionarProduto(cheeseBurger, 1);

// ----------------------------------------------------------------

List<Pedido> pedidosList = new List<Pedido>{pedidoRoberto1};
List<Documento> cpfs = new List<Documento>{documentoRoberto};

RelatorioVendas.gerarRelatorioProdutosMaisVendidos(pedidosList);
RelatorioClientes.gerarRelatorioPedidosPorCliente(pedidosList, cpfs);

System.debug('');
System.debug('======== TESTE TESTE TESTE ========');
System.debug('');