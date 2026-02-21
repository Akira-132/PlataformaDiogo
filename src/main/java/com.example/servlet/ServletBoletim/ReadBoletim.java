package com.example.servlet.ServletBoletim;

import com.example.dao.BoletimDAO;
import com.example.models.Boletim;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/boletim-read")
public class ReadBoletim extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BoletimDAO boletimDAO = new BoletimDAO();

        try {
            List<Boletim> listaBoletim = boletimDAO.read();
            request.setAttribute("listaBoletim", listaBoletim);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar o boletim.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/boletim.jsp").forward(request, response);
    }
}