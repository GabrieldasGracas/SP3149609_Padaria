<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="persistencia.ProdutoDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    Integer id = Util.paraInt(request.getParameter("id"));
    if (id == null) {
        throw new IllegalArgumentException("Identificador de produto inválido.");
    }
    boolean removido = new ProdutoDAO(pasta).excluir(id);
    if (!removido) {
        throw new IllegalArgumentException("Registro não encontrado: talvez ele já tenha sido excluído.");
    }
    response.sendRedirect("produtos.jsp?msg=excluido");
%>
