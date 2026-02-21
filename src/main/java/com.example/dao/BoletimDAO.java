package com.example.dao;

import com.example.controllers.Conexao;
import com.example.models.Boletim;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

public class BoletimDAO {

    public List<Boletim> read() throws SQLException {
        String sql = "SELECT nome_aluno, sobrenome_aluno, disciplina, media1, media2, media_final, situacao FROM ";

        Conexao conexao = new Conexao();
        List<Boletim> lista = new LinkedList<>();

        try (Connection conn = conexao.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rset = pstmt.executeQuery()) {

            while (rset.next()) {
                lista.add(new Boletim(
                        rset.getString("nome_aluno"),
                        rset.getString("sobrenome_aluno"),
                        rset.getString("disciplina"),
                        rset.getDouble("media1"),
                        rset.getDouble("media2"),
                        rset.getDouble("media_final"),
                        rset.getString("situacao")
                ));
            }
        }
        return lista;
    }
}