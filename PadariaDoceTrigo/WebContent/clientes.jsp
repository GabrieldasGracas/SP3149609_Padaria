<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.List, classes.Cliente, persistencia.ClienteDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    String titulo = "Clientes";
    List<Cliente> lista = new ClienteDAO(pasta).listar();
    String msg = Util.mensagem(request.getParameter("msg"));
%>
<%@ include file="includes/cabecalho.jsp" %>

<div class="topo-pagina">
    <h1>Clientes</h1>
    <a class="btn btn-primario" href="cliente-form.jsp">+ Novo</a>
</div>

<% if (msg != null) { %><p class="alerta alerta-sucesso"><%= msg %></p><% } %>

<% if (lista.isEmpty()) { %>
<p class="vazio">Nenhum cliente cadastrado ainda. Clique em "Novo" para começar.</p>
<% } else { %>
<div class="tabela-wrap">
<table>
    <thead>
        <tr><th>ID</th><th>Nome</th><th>Telefone</th><th>E-mail</th><th>Endereço</th><th>Ações</th></tr>
    </thead>
    <tbody>
    <% for (Cliente c : lista) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= Util.esc(c.getNome()) %></td>
            <td><%= Util.esc(c.getTelefone()) %></td>
            <td><%= Util.esc(c.getEmail()) %></td>
            <td><%= Util.esc(c.getEndereco()) %></td>
            <td class="acoes">
                <a href="cliente-form.jsp?id=<%= c.getId() %>">Editar</a>
                <a class="excluir" href="cliente-excluir.jsp?id=<%= c.getId() %>" onclick="return confirm('Excluir este cliente?');">Excluir</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
</div>
<% } %>

<%@ include file="includes/rodape.jsp" %>
