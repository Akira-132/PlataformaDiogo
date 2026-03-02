<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Nota" %>
<%@ page import="com.example.models.Aluno" %>
<%@ page import="com.example.models.Disciplina" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    List<Nota> listaNotas = (List<Nota>) request.getAttribute("listaNotas");
    List<Aluno> listaAlunos = (List<Aluno>) request.getAttribute("listaAlunos");
    List<Disciplina> listaDisciplinas = (List<Disciplina>) request.getAttribute("listaDisciplinas");

    String modalAtivo = (String) request.getAttribute("modalAtivo");
    Nota notaModal = (Nota) request.getAttribute("notaModal");
    String erro = (String) request.getAttribute("erro");
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="../../assets/imgs/Logo.png" type="image/x-icon">
    <link rel="stylesheet" href="../../assets/styles/notasProfessor.css">
    <link rel="stylesheet" href="../../assets/styles/globalApp.css">
    <title>Monsters University</title>
</head>
<body>
    <input type="checkbox" id="modal-input" <%= (modalAtivo != null ) ? "checked" : "" %> hidden />

    <aside>
        <div id="logo">
            <img src="../../assets/imgs/Logo.png" alt="Logo" />
        </div>
        <nav>
            <a href="turmas-adm.jsp" class="ativo">
                <img src="../../assets/imgs/icone-diciplinas.png" alt="" />
                Disciplina
            </a>
            <a href="turmas-adm.jsp">
                <img src="../../assets/imgs/icone-adicionar.png" alt="" />
                Adicionar
            </a>
            <a href="turmas-adm.jsp">
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
                Camuflagem
            </span>
        </div>
    </aside>

    <main>
        <header>Lançamento de Notas</header>

        <div id="conteudo">
            <% if (erro != null) { %>
                <div style="color: #ff4d4d; margin-bottom: 15px; text-align: center"><%= erro %></div>
            <% } %>
            <div class="view-notas">
                <table>
                    <thead>
                        <tr>
                            <th>Aluno</th>
                            <th>Disciplina</th>
                            <th>Avaliação</th>
                            <th>Período</th>
                            <th>Nota</th>
                            <th>Ações</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaNotas != null && !listaNotas.isEmpty()) {
                                for (Nota n : listaNotas) {
                        %>
                        <tr>
                            <td><%= n.getAluno().getUsuario().getNome() %> <%= n.getAluno().getUsuario().getSobrenome() %></td>
                            <td><%= n.getDisciplina().getNome() %></td>
                            <td><%= n.getTipo() %></td>
                            <td><%= n.getSemestre() %>º Sem / <%= n.getAno() %></td>
                            <td><span class="Nota"><%= String.format("%.1f", n.getNota()) %></span></td>
                            <td style="display: flex; gap: 10px; justify-content: center;">
                                <a href="<%= request.getContextPath() %>/nota-read?acao=prepararUpdate&id=<%= n.getId() %>">
                                    <img src="../../assets/imgs/icone-editar.png" alt="Editar" class="icone-editar" />
                                </a>
                                <form action="<%= request.getContextPath() %>/nota-delete" method="post">
                                    <input type="hidden" name="id" value="<%= n.getId() %>" />
                                    <input type="image" src="../../assets/imgs/icone-lixeira.png" alt="Excluir" class="icone-lixeira" onclick="return confirm('Apagar esta nota?');" />
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center;">Nenhuma nota lançada.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <% if ("update".equals(modalAtivo) || "create".equals(modalAtivo)) { %>
    <div id="modal-overlay">
        <div class="modal">
            <p class="modal-titulo"><%= "update".equals(modalAtivo) ? "Editar Nota" : "Lançar Nota" %></p>
            <hr>

            <form action="<%= request.getContextPath() %>/nota-<%= "update".equals(modalAtivo) ? "update" : "create" %>" method="post">
                <% if ("update".equals(modalAtivo) && notaModal != null) { %>
                <input type="hidden" name="id" value="<%= notaModal.getId() %>" />
                <% } %>

                <div class="modal-campos">
                    <div class="modal-campo">
                        <label for="fkAlunoId">Aluno</label>
                        <div class="input-content">
                            <select name="fkAlunoId" id="fkAlunoId" required>
                                <option value="">Selecione um aluno...</option>
                                <%
                                    if (listaAlunos != null) {
                                        for (Aluno a : listaAlunos) {
                                            boolean selecionado = (notaModal != null && notaModal.getFkAlunoId() == a.getId());
                                %>
                                <option value="<%= a.getId() %>" <%= selecionado ? "selected" : "" %>>
                                    <%= a.getUsuario().getNome() %> <%= a.getUsuario().getSobrenome() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="modal-campo">
                        <label for="fkDisciplinaId">Disciplina</label>
                        <div class="input-content">
                            <select name="fkDisciplinaId" id="fkDisciplinaId" required>
                                <option value="">Selecione uma disciplina...</option>
                                <%
                                    if (listaDisciplinas != null) {
                                        for (Disciplina d : listaDisciplinas) {
                                            boolean selecionado = (notaModal != null && notaModal.getFkDisciplinaId() == d.getId());
                                %>
                                <option value="<%= d.getId() %>" <%= selecionado ? "selected" : "" %>>
                                    <%= d.getNome() %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="modal-campo">
                        <label for="tipo">Tipo (Ex: P1, P2)</label>
                        <div class="input-content">
                            <input type="text" name="tipo" id="tipo" value="<%= (notaModal != null) ? notaModal.getTipo() : "" %>" required />
                        </div>
                    </div>

                    <div class="modal-campo">
                        <label for="semestre">Semestre</label>
                        <div class="input-content">
                            <input type="number" name="semestre" id="semestre" value="<%= (notaModal != null) ? notaModal.getSemestre() : "" %>" required />
                        </div>
                    </div>

                    <div class="modal-campo">
                        <label for="ano">Ano</label>
                        <div class="input-content">
                            <input type="number" name="ano" id="ano" value="<%= (notaModal != null) ? notaModal.getAno() : "" %>" required />
                        </div>
                    </div>

                    <div class="modal-campo">
                        <label for="nota">Valor da Nota</label>
                        <div class="input-content">
                            <input type="text" name="nota" id="nota" value="<%= (notaModal != null) ? notaModal.getNota() : "" %>" required />
                        </div>
                    </div>
                </div>

                <div class="modal-botoes">
                    <a href="<%= request.getContextPath() %>/nota-read" id="btn-cancelar" style="text-decoration: none; color: white;">Cancelar</a>
                    <button type="submit" id="btn-adicionar">Salvar</button>
                </div>
            </form>
        </div>
    </div>
    <% } %>
</body>
</html>