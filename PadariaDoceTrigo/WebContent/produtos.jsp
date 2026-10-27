<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.List, classes.Produto, persistencia.ProdutoDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    String titulo = "Produtos";
    List<Produto> lista = new ProdutoDAO(pasta).listar();
    String msg = Util.mensagem(request.getParameter("msg"));
%>
<%@ include file="includes/cabecalho.jsp" %>

<div class="topo-pagina">
    <h1>Produtos</h1>
    <a class="btn btn-primario" href="produto-form.jsp">+ Novo</a>
</div>

<% if (msg != null) { %><p class="alerta alerta-sucesso"><%= msg %></p><% } %>

<% if (lista.isEmpty()) { %>
<p class="vazio">Nenhum produto cadastrado ainda. Clique em "Novo" para começar.</p>
<% } else { %>
<div class="tabela-wrap">
<table>
    <thead>
        <tr><th>ID</th><th>Nome</th><th>Categoria</th><th class="num">Preço</th><th class="num">Quantidade</th><th>Ações</th></tr>
    </thead>
    <tbody>
    <% for (Produto p : lista) { %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= Util.esc(p.getNome()) %></td>
            <td><%= Util.esc(p.getCategoria()) %></td>
            <td class="num"><%= Util.moeda(p.getPreco()) %></td>
            <td class="num"><%= p.getQuantidade() %></td>
            <td class="acoes">
                <a href="produto-form.jsp?id=<%= p.getId() %>">Editar</a>
                <a class="excluir" href="produto-excluir.jsp?id=<%= p.getId() %>" onclick="return confirm('Excluir este produto?');">Excluir</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
</div>
<% } %>

<%@ include file="includes/rodape.jsp" %>
