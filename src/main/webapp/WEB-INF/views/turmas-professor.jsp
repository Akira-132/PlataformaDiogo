<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Turma" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    List<Turma> listaTurmas = (List<Turma>) request.getAttribute("listaTurmas");
    String erro = (String) request.getAttribute("erro");
%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/imgs/Logo.png" type="image/x-icon" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles/turmasAdm.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/styles/globalApp.css" />

    <title>Monsters University - Minhas Turmas</title>

    <style>
        .turma-card { cursor: pointer; }
        .turma-link { text-decoration: none; color: inherit; flex-grow: 1; height: 100%; display: flex; align-items: center;}
    </style>
</head>

<body>
<aside>
    <div id="logo">
        <img src="${pageContext.request.contextPath}/assets/imgs/Logo.png" alt="" />
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/turma-read" class="ativo">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-diciplinas.png" alt="" />
            Disciplina
        </a>
    </nav>

    <div id="info-usuario">
        <div id="avatar">
            <img src="${pageContext.request.contextPath}/assets/imgs/icone-usuario.png" alt="" />
        </div>
        <span>
            <strong><%= (usuarioLogado != null) ? usuarioLogado.getNome() : "Professor" %></strong>
            Docente
        </span>
    </div>
</aside>

<main>
    <header>Minhas Turmas</header>
    <div id="conteudo">

        <% if (erro != null) { %>
        <div style="color: #ff4d4d; text-align: center; margin-bottom: 10px;"><%= erro %></div>
        <% } %>

        <h1>TURMAS</h1>

        <div id="turmas-lista">
            <%
                if (listaTurmas != null && !listaTurmas.isEmpty()) {
                    int contador = 0;
                    for (Turma t : listaTurmas) {
                        String corBarra = (contador % 2 == 0) ? "verde" : "roxo";
                        contador++;
            %>

            <div class="turma-card">
                <a href="${pageContext.request.contextPath}/turma-aluno-read?id=<%= t.getId() %>" class="turma-link">
                    <span style="padding-left: 20px; font-weight: bold;"><%= t.getSala() %></span>
                </a>

                <div class="barra <%= corBarra %>"></div>
            </div>

            <%
                }
            } else {
            %>
            <p style="text-align: center; margin-top: 30px;">Você não possui turmas cadastradas.</p>
            <%  } %>
        </div>
    </div>
</main>
</body>
</html>