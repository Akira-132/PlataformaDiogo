package com.example.servlet.ServletNota;

import java.io.IOException;
import java.util.List;
import com.example.models.Nota;
import com.example.models.Professor;
import com.example.models.Usuario;
import com.example.dao.NotaDAO;
import com.example.dao.ProfessorDAO;
import com.example.dao.AlunoDAO;
import com.example.dao.DisciplinaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/nota-read")
public class ReadNota extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NotaDAO notaDAO = new NotaDAO();
        AlunoDAO alunoDAO = new AlunoDAO();
        DisciplinaDAO disciplinaDAO = new DisciplinaDAO();

        Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");

        String acao = request.getParameter("acao");
        String idStr = request.getParameter("id");
        String idTurmaStr = request.getParameter("idTurma");

        try {
            List<Nota> lista = notaDAO.read();
            request.setAttribute("listaNotas", lista);

            if ("prepararCreate".equals(acao) || "prepararUpdate".equals(acao)) {
                request.setAttribute("listaAlunos", alunoDAO.read());
                request.setAttribute("listaDisciplinas", disciplinaDAO.read());
            }

            if ("prepararCreate".equals(acao)) {
                request.setAttribute("modalAtivo", "create");
            }
            else if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Nota nota = notaDAO.readById(id);

                if (nota != null) {
                    request.setAttribute("notaModal", nota);

                    if ("prepararUpdate".equals(acao)) {
                        request.setAttribute("modalAtivo", "update");
                    } else if ("prepararDelete".equals(acao)) {
                        request.setAttribute("modalAtivo", "delete");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro inesperado ao carregar dados.");
        }

        try {
            ProfessorDAO professorDAO = new ProfessorDAO();
            if (usuarioLogado != null && professorDAO.readByUsuarioId(usuarioLogado.getId()) != null) {
                request.getRequestDispatcher("/notas-professor.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/notas-adm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("/notas-adm.jsp").forward(request, response);
        }
    }
}