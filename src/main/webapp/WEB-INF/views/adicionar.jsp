<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    String erro = (String) request.getAttribute("erro");
    String sucesso = (String) request.getAttribute("sucesso");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/imgs/Logo.png" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles/globalApp.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles/adicionar.css">

    <title>Monsters University - Adicionar Usuário</title>
</head>
<body>
<aside>
    <div id="logo">
        <img src="${pageContext.request.contextPath}/assets/imgs/Logo.png" alt="Logo" />
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/turma-read">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-diciplinas.png" alt="" />
            Disciplina
        </a>
        <a href="#" class="ativo">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-adicionar.png" alt="" />
            Adicionar
        </a>
        <a href="${pageContext.request.contextPath}/professor-read">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-professores.png" alt=""/>
            Professores
        </a>
    </nav>

    <div id="info-usuario">
        <div id="avatar">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-usuario.png" alt="" />
        </div>
        <span>
                <strong><%= (usuarioLogado != null) ? usuarioLogado.getNome() : "Admin" %></strong>
                Administração
            </span>
    </div>
</aside>

<main>
    <header>Adicionar Usuário</header>

    <input type="checkbox" id="toggle-tipo">

    <div id="conteudo">
        <h2>Criar usuário</h2>

        <% if (erro != null) { %>
        <div style="color: #ff4d4d; margin-bottom: 10px; text-align: center;"><%= erro %></div>
        <% } %>
        <% if (sucesso != null) { %>
        <div style="color: #4CAF50; margin-bottom: 10px; text-align: center;"><%= sucesso %></div>
        <% } %>

        <div id="toggle">
            <label id="label-aluno" style="cursor: pointer;" onclick="setTipo('aluno')">Aluno</label>
            <label id="label-professor" style="cursor: pointer;" onclick="setTipo('professor')">Professor</label>
        </div>

        <form action="${pageContext.request.contextPath}/usuario-create" method="post">

            <input type="hidden" name="tipoUsuario" id="input-tipo-usuario" value="aluno">

            <div id="campos">
                <input type="text" name="nome" placeholder="nome" required>
                <input type="text" name="cpf" placeholder="cpf" required maxlength="11">
                <input type="text" name="sobrenome" placeholder="sobrenome" required>
                <input type="email" name="email" placeholder="email" required>
                <input type="password" name="senha" placeholder="senha" required>
            </div>

            <button type="submit" id="btn-adicionar">Adicionar</button>
        </form>
    </div>
</main>

<script>
    const checkbox = document.getElementById('toggle-tipo');
    const inputHidden = document.getElementById('input-tipo-usuario');

    function setTipo(tipo) {
        if (tipo === 'professor') {
            checkbox.checked = true;
            inputHidden.value = 'professor';
        } else {
            checkbox.checked = false;
            inputHidden.value = 'aluno';
        }
    }

    checkbox.addEventListener('change', function() {
        inputHidden.value = this.checked ? 'professor' : 'aluno';
    });
</script>
</body>
</html>