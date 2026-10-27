<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, classes.Cliente, persistencia.ClienteDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    ClienteDAO dao = new ClienteDAO(pasta);
    List<String> erros = new ArrayList<String>();

    int id = 0;
    String nome = "", telefone = "", email = "", endereco = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Integer idForm = Util.paraInt(request.getParameter("id"));
        id = (idForm == null) ? 0 : idForm;
        nome = Util.texto(request.getParameter("nome"));
        telefone = Util.texto(request.getParameter("telefone"));
        email = Util.texto(request.getParameter("email"));
        endereco = Util.texto(request.getParameter("endereco"));

        if (nome.isEmpty()) {
            erros.add("Informe o nome do cliente.");
        } else if (nome.length() > 80) {
            erros.add("O nome pode ter no máximo 80 caracteres.");
        }
        int digitos = Util.soDigitos(telefone).length();
        if (telefone.isEmpty()) {
            erros.add("Informe o telefone.");
        } else if (digitos != 10 && digitos != 11) {
            erros.add("O telefone deve ter 10 ou 11 dígitos, com DDD (ex.: 11 91234-5678).");
        }
        if (!email.isEmpty() && !Util.emailValido(email)) {
            erros.add("O e-mail informado não é válido (ex.: nome@exemplo.com).");
        }
        if (endereco.isEmpty()) {
            erros.add("Informe o endereço.");
        } else if (endereco.length() > 120) {
            erros.add("O endereço pode ter no máximo 120 caracteres.");
        }

        if (erros.isEmpty()) {
            Cliente c = new Cliente(id, nome, telefone, email, endereco);
            if (id > 0) {
                if (!dao.alterar(c)) {
                    throw new IllegalArgumentException("Cliente não encontrado para alteração.");
                }
            } else {
                dao.incluir(c);
            }
            response.sendRedirect("clientes.jsp?msg=salvo");
            return;
        }
    } else if (request.getParameter("id") != null) {
        Integer idParam = Util.paraInt(request.getParameter("id"));
        if (idParam == null) {
            throw new IllegalArgumentException("Identificador de cliente inválido.");
        }
        Cliente c = dao.buscarPorId(idParam);
        if (c == null) {
            throw new IllegalArgumentException("Cliente não encontrado.");
        }
        id = c.getId();
        nome = c.getNome();
        telefone = c.getTelefone();
        email = c.getEmail() == null ? "" : c.getEmail();
        endereco = c.getEndereco();
    }

    boolean edicao = id > 0;
    String titulo = edicao ? "Editar cliente" : "Novo cliente";
%>
<%@ include file="includes/cabecalho.jsp" %>

<h1><%= titulo %></h1>

<% if (!erros.isEmpty()) { %>
<div class="alerta alerta-erro">
    <strong>Corrija os campos abaixo:</strong>
    <ul><% for (String e : erros) { %><li><%= Util.esc(e) %></li><% } %></ul>
</div>
<% } %>

<form class="formulario" method="post" action="cliente-form.jsp">
    <input type="hidden" name="id" value="<%= id %>">

    <label for="nome">Nome completo *</label>
    <input type="text" id="nome" name="nome" maxlength="80" required value="<%= Util.esc(nome) %>">

    <label for="telefone">Telefone *</label>
    <input type="tel" id="telefone" name="telefone" placeholder="11 91234-5678" required value="<%= Util.esc(telefone) %>">

    <label for="email">E-mail</label>
    <input type="email" id="email" name="email" placeholder="nome@exemplo.com" value="<%= Util.esc(email) %>">

    <label for="endereco">Endereço *</label>
    <input type="text" id="endereco" name="endereco" maxlength="120" required value="<%= Util.esc(endereco) %>">

    <div class="botoes">
        <button type="submit" class="btn btn-primario">Salvar</button>
        <a class="btn btn-secundario" href="clientes.jsp">Cancelar</a>
    </div>
</form>

<%@ include file="includes/rodape.jsp" %>
