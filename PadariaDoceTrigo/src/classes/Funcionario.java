package classes;

import persistencia.Identificavel;

public class Funcionario implements Identificavel {

    private int id;
    private String nome;
    private String cargo;
    private String telefone;
    private double salario;

    public Funcionario() { }

    public Funcionario(int id, String nome, String cargo, String telefone, double salario) {
        this.id = id;
        this.nome = nome;
        this.cargo = cargo;
        this.telefone = telefone;
        this.salario = salario;
    }

    @Override public int getId() { return id; }
    @Override public void setId(int id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }
    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }
    public double getSalario() { return salario; }
    public void setSalario(double salario) { this.salario = salario; }
}
