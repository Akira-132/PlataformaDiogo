<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Turma" %>
<%@ page import="com.example.models.TurmaAluno" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Turma turmaAtual = (Turma) request.getAttribute("turmaAtual");
    List<TurmaAluno> listaAlunos = (List<TurmaAluno>) request.getAttribute("listaAlunos");
%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="../../assets/imgs/Logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="../../assets/styles/turmaA.css" />
    <link rel="stylesheet" href="../../assets/styles/globalApp.css" />
    <title>Monsters University</title>
</head>

<body>
<aside>
    <div id="logo">
        <img src="../../assets/imgs/Logo.png" alt="" />
    </div>
    <nav>
        <a href="<%= request.getContextPath() %>/turma-read" class="ativo">
            <img src="../../assets/imgs/icone-diciplinas.png" alt="" />
            Disciplina
        </a>
    </nav>

    <div id="info-usuario">
        <div id="avatar">
            <img src="../../assets/imgs/icone-usuario.png" alt="" />
        </div>
        <span>
            <strong><%= (usuarioLogado != null) ? usuarioLogado.getNome() + " " + usuarioLogado.getSobrenome() : "Professor" %></strong>
            Minha Disciplina
        </span>
    </div>
</aside>

<main>
    <header>Minha disciplina</header>
    <div id="conteudo">

        <h1>TURMA <%= (turmaAtual != null) ? turmaAtual.getSala() : "" %></h1>

        <a href="<%= request.getContextPath() %>/nota-read"><button style="cursor: pointer;">NOTAS</button></a>

        <div id="alunos-lista">
            <%
                if (listaAlunos != null && !listaAlunos.isEmpty()) {
                    for (TurmaAluno ta : listaAlunos) {
            %>
            <a href="<%= request.getContextPath() %>/aluno-read?id=<%= ta.getAluno().getId() %>" class="aluno-card">
                <%= ta.getAluno().getUsuario().getNome() %> <%= ta.getAluno().getUsuario().getSobrenome() %>
            </a>
            <%
                }
            } else {
            %>
            <p>Nenhum aluno matriculado nesta turma.</p>
            <%  } %>
        </div>

    </div>
</main>
</body>
</html>