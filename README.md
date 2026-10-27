# SP3149609_Padaria

Projeto para a disciplina de Laboratório de Programação 2 (SPOLBP2), do curso Técnico em Desenvolvimento de Sistemas do IFSP São Paulo.

**Padaria Doce Trigo** é uma aplicação web em Java e JSP para organizar os clientes, os funcionários e os produtos de uma padaria.

Autor: Gabriel das Graças

## Entidades

No sistema da padaria serão criadas as entidades Cliente, Funcionário e Produto.

### Cliente

* id: int
* nome: String
* telefone: String
* email: String
* endereco: String

<br>

* incluir(): void
* alterar(): void
* excluir(): void
* listar(): List

### Produto

* id: int
* nome: String
* categoria: String
* preco: double
* quantidade: int

<br>

* incluir(): void
* alterar(): void
* excluir(): void
* listar(): List

### Funcionário

* id: int
* nome: String
* cargo: String
* telefone: String
* salario: double

<br>

* incluir(): void
* alterar(): void
* excluir(): void
* listar(): List

Na implementação, as operações incluir, alterar, excluir e listar ficam na classe `RepositorioJson<T>`, herdada por `ClienteDAO`, `ProdutoDAO` e `FuncionarioDAO`. As classes `Cliente`, `Produto` e `Funcionario` guardam os dados.

## Tecnologias

JSP, Gson, JSON e o servidor usado (Tomcat).

* **JSP e HTML:** páginas e formulários
* **Java:** classes de entidade e persistência
* **Gson:** conversão entre objetos Java e JSON (`toJson()` e `fromJson()`)
* **JSON:** armazenamento dos dados em arquivos, sem banco de dados
* **CSS:** estilo compartilhado em `css/estilo.css`
* **Apache Tomcat:** servidor, executado pelo Eclipse

## Diagrama de Classes

Diagrama de classes do sistema da Padaria, incluindo os atributos e métodos das classes Cliente, Funcionário e Produto.

![Diagrama de classes](docs/diagrama-classes.svg)

## Como rodar

Passo a passo resumido para abrir o projeto no Eclipse e executar.

1. No Eclipse, crie um **Dynamic Web Project** chamado `PadariaDoceTrigo`, com o runtime **Apache Tomcat**. Na última tela do assistente, defina o *Content directory* como `WebContent`.
2. Copie a pasta `src/` do repositório para `src/` do projeto e a pasta `WebContent/` para `WebContent/` do projeto, substituindo o que o Eclipse criou.
3. Baixe o `gson-2.x.jar` em [mvnrepository.com/artifact/com.google.code.gson/gson](https://mvnrepository.com/artifact/com.google.code.gson/gson) e coloque em `WebContent/WEB-INF/lib/`.
4. Clique com o botão direito no projeto e abra **Properties > Java Build Path > Libraries**. Confirme que a Gson aparece; se não aparecer, use *Add JARs...*.
5. Clique com o botão direito em `index.jsp` e escolha **Run As > Run on Server**.
6. Abra `http://localhost:8080/PadariaDoceTrigo/` no navegador. O console do Eclipse não deve mostrar erros.

Por padrão, o Eclipse grava os arquivos JSON na cópia do projeto publicada no Tomcat, e não na pasta do projeto. Para gravar em `WebContent/dados`, descomente o parâmetro `pastaDados` em `WEB-INF/web.xml` e informe o caminho da pasta.
