<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="util.Util" %>
<%
    String titulo = "Algo deu errado";
    String mensagemAmigavel;
    if (exception == null) {
        mensagemAmigavel = "A página que você tentou abrir não foi encontrada.";
    } else {
        application.log("Erro na aplicação Padaria Doce Trigo", exception);
        if (exception instanceof IllegalArgumentException) {
            mensagemAmigavel = exception.getMessage();
        } else {
            mensagemAmigavel = "Não foi possível concluir a operação. Tente novamente em instantes.";
        }
    }
%>
<%@ include file="includes/cabecalho.jsp" %>

<section class="erro-box">
    <span class="card-icone">🥐</span>
    <h1>Ops, queimamos a fornada!</h1>
    <p class="erro-msg"><%= Util.esc(mensagemAmigavel) %></p>

    <% if (exception != null) { %>
    <details>
        <summary>Detalhes técnicos</summary>
        <p><strong>Tipo:</strong> <%= Util.esc(exception.getClass().getSimpleName()) %></p>
        <p><strong>Mensagem:</strong> <%= Util.esc(exception.getMessage()) %></p>
        <% if (exception.getCause() != null) { %>
        <p><strong>Causa:</strong> <%= Util.esc(exception.getCause().getMessage()) %></p>
        <% } %>
    </details>
    <% } %>

    <p><a class="btn btn-primario" href="index.jsp">Voltar ao início</a></p>
</section>

<%@ include file="includes/rodape.jsp" %>
