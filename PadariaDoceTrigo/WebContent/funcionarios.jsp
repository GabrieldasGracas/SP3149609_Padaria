<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.List, classes.Funcionario, persistencia.FuncionarioDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    String titulo = "Funcionários";
    List<Funcionario> lista = new FuncionarioDAO(pasta).listar();
    String msg = Util.mensagem(request.getParameter("msg"));
%>
<%@ include file="includes/cabecalho.jsp" %>

<div class="topo-pagina">
    <h1>Funcionários</h1>
    <a class="btn btn-primario" href="funcionario-form.jsp">+ Novo</a>
</div>

<% if (msg != null) { %><p class="alerta alerta-sucesso"><%= msg %></p><% } %>

<% if (lista.isEmpty()) { %>
<p class="vazio">Nenhum funcionário cadastrado ainda. Clique em "Novo" para começar.</p>
<% } else { %>
<div class="tabela-wrap">
<table>
    <thead>
        <tr><th>ID</th><th>Nome</th><th>Cargo</th><th>Telefone</th><th class="num">Salário</th><th>Ações</th></tr>
    </thead>
    <tbody>
    <% for (Funcionario f : lista) { %>
        <tr>
            <td><%= f.getId() %></td>
            <td><%= Util.esc(f.getNome()) %></td>
            <td><%= Util.esc(f.getCargo()) %></td>
            <td><%= Util.esc(f.getTelefone()) %></td>
            <td class="num"><%= Util.moeda(f.getSalario()) %></td>
            <td class="acoes">
                <a href="funcionario-form.jsp?id=<%= f.getId() %>">Editar</a>
                <a class="excluir" href="funcionario-excluir.jsp?id=<%= f.getId() %>" onclick="return confirm('Excluir este funcionário?');">Excluir</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>
</div>
<% } %>

<%@ include file="includes/rodape.jsp" %>
