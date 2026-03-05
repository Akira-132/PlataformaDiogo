package com.example.servlet.ServletObservacao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.example.models.Observacao;
import com.example.models.Aluno;
import com.example.models.Usuario;
import com.example.dao.ObservacaoDAO;
import com.example.dao.AlunoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/observacao-read")
public class ReadObservacao extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        ObservacaoDAO observacaoDAO = new ObservacaoDAO();
        AlunoDAO alunoDAO = new AlunoDAO();

        String idAlunoStr = request.getParameter("idAluno");
        String idObsStr = request.getParameter("id");

        try {
            if (idObsStr != null) {
                int idObs = Integer.parseInt(idObsStr);
                Observacao obs = observacaoDAO.readById(idObs);

                if (obs != null) {
                    request.setAttribute("observacao", obs);
                    request.setAttribute("alunoAtual", alunoDAO.readById(obs.getFkAlunoId()));
                }

                if (usuarioLogado != null && "admin".equalsIgnoreCase(usuarioLogado.getCargo())) {
                    request.getRequestDispatcher("/observacao-detalhe-adm.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/observacao-detalhe-prof.jsp").forward(request, response);
                }
                return;

            } else if (idAlunoStr != null) {
                int idAluno = Integer.parseInt(idAlunoStr);
                Aluno aluno = alunoDAO.readById(idAluno);

                List<Observacao> todas = observacaoDAO.read();
                List<Observacao> doAluno = new ArrayList<>();
                if (todas != null) {
                    for (Observacao o : todas) {
                        if (o.getFkAlunoId() == idAluno) {
                            doAluno.add(o);
                        }
                    }
                }

                request.setAttribute("alunoAtual", aluno);
                request.setAttribute("listaObservacoes", doAluno);

                if (usuarioLogado != null && "admin".equalsIgnoreCase(usuarioLogado.get())) {
                    request.getRequestDispatcher("/historico-adm.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/historico-professor.jsp").forward(request, response);
                }
                return;
            }

            response.sendRedirect(request.getContextPath() + "/turma-read");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dados.");
            response.sendRedirect(request.getContextPath() + "/turma-read");
        }
    }
}