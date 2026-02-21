package com.example.models;

public class Boletim {
    private String nomeAluno;
    private String sobrenomeAluno;
    private String nomeDisciplina;
    private double media1;
    private double media2;
    private double mediaFinal;
    private String situacao;

    public Boletim(String nomeAluno, String sobrenomeAluno, String nomeDisciplina,
                   double media1, double media2, double mediaFinal, String situacao) {
        this.nomeAluno = nomeAluno;
        this.sobrenomeAluno = sobrenomeAluno;
        this.nomeDisciplina = nomeDisciplina;
        this.media1 = media1;
        this.media2 = media2;
        this.mediaFinal = mediaFinal;
        this.situacao = situacao;
    }

    public String getNomeAluno() { return nomeAluno; }
    public String getSobrenomeAluno() { return sobrenomeAluno; }
    public String getNomeDisciplina() { return nomeDisciplina; }
    public double getMedia1() { return media1; }
    public double getMedia2() { return media2; }
    public double getMediaFinal() { return mediaFinal; }
    public String getSituacao() { return situacao; }
}