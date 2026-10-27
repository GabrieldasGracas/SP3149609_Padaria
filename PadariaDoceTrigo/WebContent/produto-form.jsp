<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, classes.Produto, persistencia.ProdutoDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    ProdutoDAO dao = new ProdutoDAO(pasta);
    List<String> erros = new ArrayList<String>();
    String[] categorias = {"Pão", "Bolo", "Salgado", "Doce", "Bebida", "Outro"};

    int id = 0;
    String nome = "", categoria = "", precoTxt = "", qtdTxt = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Integer idForm = Util.paraInt(request.getParameter("id"));
        id = (idForm == null) ? 0 : idForm;
        nome = Util.texto(request.getParameter("nome"));
        categoria = Util.texto(request.getParameter("categoria"));
        precoTxt = Util.texto(request.getParameter("preco"));
        qtdTxt = Util.texto(request.getParameter("quantidade"));

        if (nome.isEmpty()) {
            erros.add("Informe o nome do produto.");
        } else if (nome.length() > 60) {
            erros.add("O nome pode ter no máximo 60 caracteres.");
        }
        if (!Arrays.asList(categorias).contains(categoria)) {
            erros.add("Escolha uma categoria válida.");
        }
        Double preco = Util.paraDouble(precoTxt);
        if (preco == null) {
            erros.add("O preço deve ser um número (ex.: 4,50).");
        } else if (preco < 0) {
            erros.add("O preço não pode ser negativo.");
        }
        Integer quantidade = Util.paraInt(qtdTxt);
        if (quantidade == null) {
            erros.add("A quantidade deve ser um número inteiro (ex.: 30).");
        } else if (quantidade < 0) {
            erros.add("A quantidade não pode ser negativa.");
        }

        if (erros.isEmpty()) {
            Produto p = new Produto(id, nome, categoria, preco, quantidade);
            if (id > 0) {
                if (!dao.alterar(p)) {
                    throw new IllegalArgumentException("Produto não encontrado para alteração.");
                }
            } else {
                dao.incluir(p);
            }
            response.sendRedirect("produtos.jsp?msg=salvo");
            return;
        }
    } else if (request.getParameter("id") != null) {
        Integer idParam = Util.paraInt(request.getParameter("id"));
        if (idParam == null) {
            throw new IllegalArgumentException("Identificador de produto inválido.");
        }
        Produto p = dao.buscarPorId(idParam);
        if (p == null) {
            throw new IllegalArgumentException("Produto não encontrado.");
        }
        id = p.getId();
        nome = p.getNome();
        categoria = p.getCategoria();
        precoTxt = Util.decimalParaCampo(p.getPreco());
        qtdTxt = String.valueOf(p.getQuantidade());
    }

    boolean edicao = id > 0;
    String titulo = edicao ? "Editar produto" : "Novo produto";
%>
<%@ include file="includes/cabecalho.jsp" %>

<h1><%= titulo %></h1>

<% if (!erros.isEmpty()) { %>
<div class="alerta alerta-erro">
    <strong>Corrija os campos abaixo:</strong>
    <ul><% for (String e : erros) { %><li><%= Util.esc(e) %></li><% } %></ul>
</div>
<% } %>

<form class="formulario" method="post" action="produto-form.jsp">
    <input type="hidden" name="id" value="<%= id %>">

    <label for="nome">Nome *</label>
    <input type="text" id="nome" name="nome" maxlength="60" required value="<%= Util.esc(nome) %>">

    <label for="categoria">Categoria *</label>
    <select id="categoria" name="categoria" required>
        <option value="">Selecione...</option>
        <% for (String c : categorias) { %>
        <option value="<%= Util.esc(c) %>" <%= c.equals(categoria) ? "selected" : "" %>><%= Util.esc(c) %></option>
        <% } %>
    </select>

    <label for="preco">Preço (R$) *</label>
    <input type="text" id="preco" name="preco" inputmode="decimal" placeholder="0,00" required value="<%= Util.esc(precoTxt) %>">

    <label for="quantidade">Quantidade em estoque *</label>
    <input type="number" id="quantidade" name="quantidade" min="0" step="1" required value="<%= Util.esc(qtdTxt) %>">

    <div class="botoes">
        <button type="submit" class="btn btn-primario">Salvar</button>
        <a class="btn btn-secundario" href="produtos.jsp">Cancelar</a>
    </div>
</form>

<%@ include file="includes/rodape.jsp" %>
