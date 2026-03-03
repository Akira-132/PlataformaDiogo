<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Turma" %>
<%@ page import="com.example.models.Disciplina" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    List<Turma> listaTurmas = (List<Turma>) request.getAttribute("listaTurmas");
    List<Disciplina> listaDisciplinas = (List<Disciplina>) request.getAttribute("listaDisciplinas");
    String erro = (String) request.getAttribute("erro");
%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="../../assets/imgs/Logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="../../assets/styles/turmasProfessor.css" />
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
            <strong><%= (usuarioLogado != null) ? usuarioLogado.getNome() + " "
                    + usuarioLogado.getSobrenome() : "Professor" %></strong>
            Minha Disciplina
        </span>
    </div>
</aside>

<main>
    <header>Minha disciplina</header>
    <div id="conteudo">

        <% if (erro != null) { %>
        <div style="color: #ff4d4d; margin-bottom: 15px; text-align: center;"><%= erro %></div>
        <% } %>

        <div id="filtro-disciplina">
            <form action="<%= request.getContextPath() %>/turma-read" method="get" style="display: flex; gap: 10px; align-items: center;">
                <label for="disciplina-select">Selecione a disciplina</label>

                <select id="disciplina-select" name="idDisciplina" style="padding: 8px; border-radius: 5px;">
                    <option value="">Todas as Disciplinas</option>
                    <%
                        String idSelecionado = request.getParameter("idDisciplina");
                        if (listaDisciplinas != null) {
                            for (Disciplina d : listaDisciplinas) {
                                boolean selecionado = (idSelecionado != null
                                        && idSelecionado.equals(String.valueOf(d.getId())));
                    %>
                    <option value="<%= d.getId() %>" <%= selecionado ? "selected" : "" %>>
                        <%= d.getNome() %>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <button type="submit">Filtrar</button>
            </form>
        </div>

        <div id="turmas-lista">
            <%
                if (listaTurmas != null && !listaTurmas.isEmpty()) {
                    int contador = 0;
                    for (Turma t : listaTurmas) {
                        String corBarra = (contador % 2 == 0) ? "verde" : "roxo";
                        contador++;
            %>
            <a href="<%= request.getContextPath() %>/turma-aluno-read?id=<%= t.getId() %>" class="turma-card">
                <span>Turma <%= t.getSala() %></span>
                <div class="barra <%= corBarra %>"></div>
            </a>
            <%
                }
            } else {
            %>
            <p>Nenhuma turma vinculada a você no momento.</p>
            <%  } %>
        </div>
    </div>
</main>
</body>

</html>