# IFPR-POO-Periodo-3.Aplicacao-bulario

A aplicação OfflineApp foi feita em mente para que o usuário possa acessar a lista de remédios sem conexão à internet. Foi usado Java como linguagem de programação, JavaFX para fazer a interface e os seus elementos, o padrão MVC para organizar o sistema, JPA com Hibernate para fazer a conexão com banco de dados e um banco de dados local MySQL.

Para que a aplicação seja iniciada no Eclipse IDE, se deve clicar com o botão direito no projeto e clicar em ***Run As***, depois em ***Maven build***, criar uma configuração de execução com “***clean javafx:run***” no campo ***Goals***. E então clicar em ***Run***.

A aplicação se inicia pela classe **App.java**, que estende a classe *Application* e possui as funções de ***start(), setRoot(), loadFXML() e main()***, no qual se inicia a aplicação, definindo qual arquivo FXML carregar e pegando arquivo *css*.

O arquivo FXML carregado é o **PaginaPrincipal.fxml** uma das *views*, que possui **PaginaPrincipalController.java** como controller para a *view*. O arquivo possui os como conteúdo:

* “RemedioDAO rdao \= new RemedioDAO();”: Objeto singleton que possui uma função para pegar todos os registros da tabela Remedios com nome específico no banco de dados.

* procurarNome(): Uma função para procurar remédios com o mesmo nome que o usuário digita em um campo *TextField*.

* initialize(): Função que muda as características das *TableColumn* de uma *TableView*, como aparência, tamanho da fonte, adicionando links ou botões, adicionando funções para que os links ou botões mudem para outras views, adicionando quebra linha para textos dentro deles.

* colocarRemediosNaTabela(): Função que preenche a *TableView* com os remédios encontrados pelo RemedioDAO.FindByName().

* switchToVisualizacaoPrescricao() e switchToVisualizacaoPDFdaBula(): Funções que são chamados pelos botões ou links, mudando dessa view para a view respectiva, transferindo também o objeto Remedio para saber de qual remédio a prescrição ou bula se refere.

Quando a função switchToVisualizacaoPrescricao() ocorre, a aplicação muda para a view **VisualizacaoPrescricao.fxml**, com **VisualizacaoPrescricaoController.java** como controller:

* “PublicoAlvoDAO paDAO \= new PublicoAlvoDAO()”: classe DAO que possui a função de procurar e pegar os registros da tabela PublicoAlvo que possuem relação com o remédio referido.

* setRemedioSelecionado(): Usado para que quando acontece switchToVisualizacaoPrescricao(), se coloque o remédio referido nesse controller e então saber qual remédio procurar relação com a tabela PublicoAlvo, e então preencher os elementos FXML com as informações dos públicos alvos. A função preenche também as informações da prescrição do remédio nos elementos FXML.

* switchToPaginaPrincipal(): Função para voltar para a view da página principal, chamado por um botão.

Quando a função switchToVisualizacaoPDFdaBula() ocorre, a aplicação muda para a view **VisualizacaoPDFdaBula.fxml**, com **VisualizacaoPDFdaBulaController.java** como controller:

* setRemedioSelecionado(): Quando se chama switchToVisualizacaoPDFdaBula(), se coloca o remédio referido no controller para saber de qual remédio pegar a bula.

* carregarPDF(): Pega o link com o caminho para o documento PDF com a bula do remédio e a partir do caminho do documento o pega e o renderiza em um elemento *VBox*.

* aproximar() e afastar(): Aumenta e diminui o zoom do documento PDF renderizado, aumentando e diminuindo a largura da imagem renderizada respectivamente.

* switchToPaginaPrincipal(): Função para voltar para a view da página principal, a partir do clique de um elemento botão.
