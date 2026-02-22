<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Turma" %>
<%@ page import="com.example.models.TurmaAluno" %>
<%@ page import="com.example.models.Aluno" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Turma turmaAtual = (Turma) request.getAttribute("turmaAtual");
    List<TurmaAluno> listaAlunos = (List<TurmaAluno>) request.getAttribute("listaAlunos");
    List<Aluno> listaTodosAlunos = (List<Aluno>) request.getAttribute("listaTodosAlunos");
%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="../../assets/imgs/Logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="../../assets/styles/turmaAdm.css" />
    <link rel="stylesheet" href="../../assets/styles/globalApp.css" />
    <link rel="stylesheet" href="../../assets/styles/notasProfessor.css" />
    <title>Monsters University</title>
</head>

<body>
<input type="checkbox" id="modal-input" hidden />

<aside>
    <div id="logo">
        <img src="../../assets/imgs/Logo.png" alt="" />
    </div>
    <nav>
        <a href="<%= request.getContextPath() %>/turma-read" class="ativo">
            <img src="../../assets/imgs/icone-diciplinas.png" alt="" />
            Disciplina
        </a>
        <label for="modal-input" style="cursor: pointer; display: flex; align-items: center; gap: 10px; color: white; padding: 10px; text-decoration: none;">
            <img src="../../assets/imgs/icone-adicionar.png" alt="" />
            Adicionar
        </label>
        <a href="#">
            <img src="../../assets/imgs/icone-professores.png" alt=""/>
            Professores
        </a>
    </nav>

    <div id="info-usuario">
        <div id="avatar">
            <img src="../../assets/imgs/icone-usuario.png" alt="" />
        </div>
        <span>
                <strong><%= (usuarioLogado != null) ? usuarioLogado.getNome() + " " + usuarioLogado.getSobrenome() : "Admin" %></strong>
                Administração
            </span>
    </div>
</aside>

<main>
    <header>Minha disciplina</header>
    <div id="conteudo">

        <h1>TURMA <%= (turmaAtual != null) ? turmaAtual.getSala() : "" %></h1>

        <a href="notasAdm.jsp"><button>NOTAS</button></a>

        <div id="alunos-lista">
            <%
                if (listaAlunos != null && !listaAlunos.isEmpty()) {
                    for (TurmaAluno ta : listaAlunos) {
            %>
            <div class="aluno-card" style="display: flex; justify-content: space-between; align-items: center;">

                <a href="<%= request.getContextPath() %>/aluno-read?id=<%= ta.getAluno().getId() %>" style="color: inherit; text-decoration: none; flex-grow: 1;">
                    <%= ta.getAluno().getUsuario().getNome() %> <%= ta.getAluno().getUsuario().getSobrenome() %>
                </a>

                <form action="<%= request.getContextPath() %>/turma-aluno-delete" method="post" style="margin: 0;">
                    <input type="hidden" name="idTurmaAluno" value="<%= ta.getId() %>" />
                    <input type="hidden" name="idTurma" value="<%= turmaAtual.getId() %>" />
                    <input type="image" src="../../assets/imgs/icone-lixeira.png" alt="Remover" class="icone-lixeira" onclick="return confirm('Deseja realmente remover o aluno desta turma?');" />
                </form>

            </div>
            <%
                }
            } else {
            %>
            <p style="text-align: center; color: white; margin-top: 20px;">Nenhum aluno matriculado nesta turma.</p>
            <% } %>
        </div>

    </div>
</main>

<div id="modal-overlay">
    <div class="modal">
        <p class="modal-titulo">Adicionar Aluno</p>
        <hr>

        <form action="<%= request.getContextPath() %>/turma-aluno-create" method="post">
            <input type="hidden" name="fkTurmaId" value="<%= (turmaAtual != null) ? turmaAtual.getId() : "" %>" />

            <div class="modal-campos">
                <div class="modal-campo full">
                    <label for="fkAlunoId">Selecione o Aluno</label>
                    <div class="input-content" style="border: none;">
                        <select name="fkAlunoId" id="fkAlunoId" required style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ccc;">
                            <option value="">-- Escolha um aluno --</option>
                            <%
                                if (listaTodosAlunos != null) {
                                    for (Aluno a : listaTodosAlunos) {
                            %>
                            <option value="<%= a.getId() %>"><%= a.getUsuario().getNome() %> <%= a.getUsuario().getSobrenome() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>

            <div class="modal-botoes" style="margin-top: 20px;">
                <label for="modal-input" id="btn-cancelar" style="cursor: pointer;">Cancelar</label>
                <button type="submit" id="btn-adicionar">Matricular</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>