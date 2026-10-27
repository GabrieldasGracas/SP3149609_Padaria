<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="erro.jsp" %>
<%@ page import="persistencia.ProdutoDAO, persistencia.ClienteDAO, persistencia.FuncionarioDAO" %>
<%@ include file="includes/config.jspf" %>
<%
    String titulo = "Início";
    int totalProdutos = new ProdutoDAO(pasta).listar().size();
    int totalClientes = new ClienteDAO(pasta).listar().size();
    int totalFuncionarios = new FuncionarioDAO(pasta).listar().size();
%>
<%@ include file="includes/cabecalho.jsp" %>

<section class="hero">
    <h1>Bem-vindo à Padaria Doce Trigo</h1>
    <p>Sistema simples para organizar os produtos, os clientes e a equipe da padaria.</p>
</section>

<section class="cards">
    <a class="card" href="produtos.jsp">
        <span class="card-icone">🥖</span>
        <h2>Produtos</h2>
        <p>Pães, bolos, salgados, doces e bebidas à venda.</p>
        <span class="card-total"><%= totalProdutos %> cadastrado(s)</span>
    </a>
    <a class="card" href="clientes.jsp">
        <span class="card-icone">🧑‍🤝‍🧑</span>
        <h2>Clientes</h2>
        <p>Contato e endereço de quem compra na padaria.</p>
        <span class="card-total"><%= totalClientes %> cadastrado(s)</span>
    </a>
    <a class="card" href="funcionarios.jsp">
        <span class="card-icone">👩‍🍳</span>
        <h2>Funcionários</h2>
        <p>Equipe: cargo, telefone e salário.</p>
        <span class="card-total"><%= totalFuncionarios %> cadastrado(s)</span>
    </a>
</section>

<%@ include file="includes/rodape.jsp" %>
