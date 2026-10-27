<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="java.util.*, classes.Funcionario, persistencia.FuncionarioDAO, util.Util" %>
<%@ include file="includes/config.jspf" %>
<%
    FuncionarioDAO dao = new FuncionarioDAO(pasta);
    List<String> erros = new ArrayList<String>();
    String[] cargos = {"Atendente", "Padeiro", "Confeiteiro", "Caixa", "Gerente"};

    int id = 0;
    String nome = "", cargo = "", telefone = "", salarioTxt = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Integer idForm = Util.paraInt(request.getParameter("id"));
        id = (idForm == null) ? 0 : idForm;
        nome = Util.texto(request.getParameter("nome"));
        cargo = Util.texto(request.getParameter("cargo"));
        telefone = Util.texto(request.getParameter("telefone"));
        salarioTxt = Util.texto(request.getParameter("salario"));

        if (nome.isEmpty()) {
            erros.add("Informe o nome do funcionário.");
        } else if (nome.length() > 80) {
            erros.add("O nome pode ter no máximo 80 caracteres.");
        }
        if (!Arrays.asList(cargos).contains(cargo)) {
            erros.add("Escolha um cargo válido.");
        }
        int digitos = Util.soDigitos(telefone).length();
        if (telefone.isEmpty()) {
            erros.add("Informe o telefone.");
        } else if (digitos != 10 && digitos != 11) {
            erros.add("O telefone deve ter 10 ou 11 dígitos, com DDD (ex.: 11 91234-5678).");
        }
        Double salario = Util.paraDouble(salarioTxt);
        if (salario == null) {
            erros.add("O salário deve ser um número (ex.: 1850,00).");
        } else if (salario < 0) {
            erros.add("O salário não pode ser negativo.");
        }

        if (erros.isEmpty()) {
            Funcionario f = new Funcionario(id, nome, cargo, telefone, salario);
            if (id > 0) {
                if (!dao.alterar(f)) {
                    throw new IllegalArgumentException("Funcionário não encontrado para alteração.");
                }
            } else {
                dao.incluir(f);
            }
            response.sendRedirect("funcionarios.jsp?msg=salvo");
            return;
        }
    } else if (request.getParameter("id") != null) {
        Integer idParam = Util.paraInt(request.getParameter("id"));
        if (idParam == null) {
            throw new IllegalArgumentException("Identificador de funcionário inválido.");
        }
        Funcionario f = dao.buscarPorId(idParam);
        if (f == null) {
            throw new IllegalArgumentException("Funcionário não encontrado.");
        }
        id = f.getId();
        nome = f.getNome();
        cargo = f.getCargo();
        telefone = f.getTelefone();
        salarioTxt = Util.decimalParaCampo(f.getSalario());
    }

    boolean edicao = id > 0;
    String titulo = edicao ? "Editar funcionário" : "Novo funcionário";
%>
<%@ include file="includes/cabecalho.jsp" %>

<h1><%= titulo %></h1>

<% if (!erros.isEmpty()) { %>
<div class="alerta alerta-erro">
    <strong>Corrija os campos abaixo:</strong>
    <ul><% for (String e : erros) { %><li><%= Util.esc(e) %></li><% } %></ul>
</div>
<% } %>

<form class="formulario" method="post" action="funcionario-form.jsp">
    <input type="hidden" name="id" value="<%= id %>">

    <label for="nome">Nome completo *</label>
    <input type="text" id="nome" name="nome" maxlength="80" required value="<%= Util.esc(nome) %>">

    <label for="cargo">Cargo *</label>
    <select id="cargo" name="cargo" required>
        <option value="">Selecione...</option>
        <% for (String c : cargos) { %>
        <option value="<%= Util.esc(c) %>" <%= c.equals(cargo) ? "selected" : "" %>><%= Util.esc(c) %></option>
        <% } %>
    </select>

    <label for="telefone">Telefone *</label>
    <input type="tel" id="telefone" name="telefone" placeholder="11 91234-5678" required value="<%= Util.esc(telefone) %>">

    <label for="salario">Salário (R$) *</label>
    <input type="text" id="salario" name="salario" inputmode="decimal" placeholder="0,00" required value="<%= Util.esc(salarioTxt) %>">

    <div class="botoes">
        <button type="submit" class="btn btn-primario">Salvar</button>
        <a class="btn btn-secundario" href="funcionarios.jsp">Cancelar</a>
    </div>
</form>

<%@ include file="includes/rodape.jsp" %>
