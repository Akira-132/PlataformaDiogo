<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Usuario" %>
<%@ page import="com.example.models.Disciplina" %>
<%@ page import="java.util.List" %>

<%
  Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
  List<Disciplina> listaDisciplinas = (List<Disciplina>) request.getAttribute("listaDisciplinas");
  Disciplina disciplina = (Disciplina) request.getAttribute("disciplina");
  String erro = (String) request.getAttribute("erro");
%>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="shortcut icon" href="../../assets/imgs/Logo.png" type="image/x-icon" />
  <link rel="stylesheet" href="../../assets/styles/sustoCriancas.css" />
  <link rel="stylesheet" href="../../assets/styles/globalApp.css" />
  <title>Monsters University</title>
</head>

<body>
  <aside>
    <div id="logo">
      <img src="../../assets/imgs/Logo.png" alt="" />
    </div>
    <nav>
      <a href="disciplinas.jsp" class="ativo">
        <img src="../../assets/imgs/icone-diciplinas.png" alt="" />
        Disciplinas
      </a>
      <a href="boletim.jsp">
        <img src="../../assets/imgs/icone-boletim.png" alt="" />
        Boletim
      </a>
    </nav>

    <div id="info-usuario">
      <div id="avatar">
        <img src="../../assets/imgs/icone-usuario.png" alt="" />
      </div>
      <span>
        <strong>Rafael Lopes</strong>
        Turma A
      </span>
    </div>
  </aside>

  <main>
    <header>Minhas disciplinas</header>
    <div id="conteudo">
      <h1 id="disciplina-titulo">Susto em crianças</h1>



      <div>
        <div id="card-situacao">
          <p id="descricao">Texto sobre mim</p>
        </div>
      </div>
    </div>
  </main>
</body>

</html>