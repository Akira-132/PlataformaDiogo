package com.example.servlet.ServletObservacao;

import com.example.dao.ObservacaoDAO;
import com.example.models.Observacao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/observacao-create")
public class CreateObservacao extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String texto = request.getParameter("texto");
        String idProfessorStr = request.getParameter("fkProfessorId");
        String idAlunoStr = request.getParameter("fkAlunoId");

        ObservacaoDAO observacaoDAO = new ObservacaoDAO();
        String erro = null;

        try {
            int fkProfessorId = Integer.parseInt(idProfessorStr);
            int fkAlunoId = Integer.parseInt(idAlunoStr);
            Observacao novaObservacao = new Observacao(texto, fkProfessorId, fkAlunoId);

            if (observacaoDAO.create(novaObservacao)) {
                response.sendRedirect(request.getContextPath() + "/observacao-read?idAluno=" + fkAlunoId);
                return;
            } else {
                erro = "Erro ao registrar observação no banco de dados.";
            }

        } catch (NumberFormatException e) {
            erro = "Erro de identificação do aluno ou professor.";
        } catch (IllegalArgumentException e) {
            erro = "Validação: " + e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            erro = "Erro inesperado ao registrar observação.";
        }

        request.setAttribute("erro", erro);
        request.getRequestDispatcher("/aluno-read?id=" + idAlunoStr).forward(request, response);
    }
}