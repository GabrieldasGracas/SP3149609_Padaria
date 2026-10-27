<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Padaria Doce Trigo · <%= titulo %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/estilo.css">
</head>
<body>
<header class="cabecalho">
    <div class="container barra">
        <a class="marca" href="index.jsp"><span class="marca-icone">🌾</span> Padaria Doce Trigo</a>
        <nav class="menu">
            <a href="index.jsp">Início</a>
            <a href="produtos.jsp">Produtos</a>
            <a href="clientes.jsp">Clientes</a>
            <a href="funcionarios.jsp">Funcionários</a>
        </nav>
    </div>
</header>
<main class="container">
