// ================================================================
// CRIAÇÃO DE OBJETOS
// ================================================================

Documento documentoRoberto = new Documento('123.456.789-00');
Endereco enderecoRoberto = new Endereco('Rua Teste', '123', 'Apt 12', 'São Paulo');
Cliente clienteRoberto = new Cliente('Roberto', documentoRoberto, enderecoRoberto, '(11) 99999-9999');

// ----------------------------------------------------------------

Endereco enderecoBurger = new Endereco('Avenida Teste', '456', 'Apt 34', 'São Bernardo do Campo');
Restaurante restauranteBurger = new Restaurante('Burger', enderecoBurger, CategoriaRestaurante.HAMBURGUERIA);

// ----------------------------------------------------------------

PoliticaDePreco precoPadrao = new PoliticaDePrecoPadrao();
PoliticaDePreco precoPercentual = new PoliticaDePrecoPercentual(10);
PoliticaDePreco precoPromocional = new PoliticaDePrecoPromocional(12, 13, 5);

Produto cheeseBurger = new Produto ('Cheese Burger', 25, precoPadrao);
Produto cheeseSalada = new Produto('Cheese Salada', 30, precoPromocional);
Produto cheeseBacon = new Produto('Cheese Bacon', 35, precoPercentual);

Produto cocacola = new Produto('Coca-Cola', 5, precoPadrao);
Produto guarana = new Produto('Guarana', 5, precoPromocional);
Produto sprite = new Produto('Sprite', 5, precoPercentual);

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

// ================================================================
// CHAMADO DOS MÉTODOS
// ================================================================

pedidoRoberto1.adicionarProduto(cheeseBurger, 1);
pedidoRoberto1.adicionarProduto(cheeseSalada, 1);
pedidoRoberto1.adicionarProduto(cocacola, 2);

pedidoRoberto1.removerProduto(cheeseBurger);
pedidoRoberto1.adicionarProduto(cheeseSalada, 1);

System.debug(pedidoRoberto1.itens);

// ----------------------------------------------------------------

