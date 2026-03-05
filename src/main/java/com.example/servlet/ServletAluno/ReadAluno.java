package com.example.servlet.ServletAluno;

import java.io.IOException;
import com.example.models.Aluno;
import com.example.dao.AlunoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/aluno-read")
public class ReadAluno extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AlunoDAO alunoDAO = new AlunoDAO();
        String idStr = request.getParameter("id");

        try {
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                Aluno alunoSelecionado = alunoDAO.readById(id);

                if (alunoSelecionado != null) {
                    request.setAttribute("alunoAtual", alunoSelecionado);
                    request.getRequestDispatcher("/aluno-perfil.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("erro", "Aluno não encontrado.");
                }
            }

            response.sendRedirect(request.getContextPath() + "/turma-read");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro inesperado ao carregar dados do aluno.");
            response.sendRedirect(request.getContextPath() + "/turma-read");
        }
    }
}