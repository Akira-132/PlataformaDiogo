package com.example.servlet.ServletTurma;

import java.io.IOException;
import java.util.List;
import com.example.models.Turma;
import com.example.models.Usuario;
import com.example.dao.TurmaDAO;
import com.example.dao.DisciplinaDAO;
import com.example.dao.ProfessorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/turma-read")
public class ReadTurma extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

        if (usuarioLogado == null) {
            response.sendRedirect("login");
            return;
        }

        TurmaDAO turmaDAO = new TurmaDAO();
        DisciplinaDAO disciplinaDAO = new DisciplinaDAO();

        String acao = request.getParameter("acao");
        String idStr = request.getParameter("id");
        String idDisciplinaStr = request.getParameter("idDisciplina");

        try {
            List<Turma> lista;

            if (idDisciplinaStr != null && !idDisciplinaStr.trim().isEmpty()) {
                int idDisciplina = Integer.parseInt(idDisciplinaStr);
                lista = turmaDAO.readByDisciplinaId(idDisciplina);
            } else {
                lista = turmaDAO.read();
            }

            request.setAttribute("listaTurmas", lista);
            request.setAttribute("listaDisciplinas", disciplinaDAO.read());

            if ("prepararCreate".equals(acao)) request.setAttribute("modalAtivo", "create");
            else if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Turma turma = turmaDAO.readById(id);
                if (turma != null) {
                    request.setAttribute("turmaModal", turma);
                    if ("prepararUpdate".equals(acao)) request.setAttribute("modalAtivo", "update");
                    else if ("prepararDelete".equals(acao)) request.setAttribute("modalAtivo", "delete");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dados.");
        }

        ProfessorDAO professorDAO = new ProfessorDAO();
        boolean isProfessor = false;
        try {
            if (professorDAO.readByUsuarioId(usuarioLogado.getId()) != null) {
                isProfessor = true;
            }
        } catch (Exception e) { e.printStackTrace(); }

        if (isProfessor) {
            request.getRequestDispatcher("/WEB-INF/pages/turmas-professor.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/pages/turmas-adm.jsp").forward(request, response);
        }
    }
}