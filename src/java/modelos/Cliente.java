/*******************************************************************************
* ENTRA21 - TURMA 2021 - EQUIPE INFINITY
* DEFINIÇÃO: CADASTRO DO CLIENTE
* AUTOR: FERNANDO D B DA CUNHA
********************************************************************************
*/
package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

/**
 * Esta classe é responsavel por representar o objeto Cliente e seus metodos de crud.
 * 
 */
public class Cliente {

    private String cpf;
    private String nome;

    @Override
    public String toString() {
        return cpf + " " + nome + " " + "\n";
    }

    /**
     * Este método realiza a inclusão das informações do cliente no BD.
     * @return 
     */
    public boolean incluirCliente() {
        // declarando comando de execucao do banco de dados
        String sql = "INSERT INTO cliente ";
        sql += "(cpf,nome)";
        sql += "VALUES(?,?)";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.cpf);
            stm.setString(2, this.nome);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    /**
     * @deprecated 
     * Este metodo realiza alteração nas informações do cliente
     * @return 
     */
    public boolean alterarCliente() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE cliente ";
        sql += "set nome     = ? ";
        sql += "where cpf = ? ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.nome);
            stm.setString(2, this.cpf);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    /**
     * @deprecated 
     * Este metodo realiza a exclusao do cliente
     * @return 
     */
    public boolean excluirCliente() {
        String sql = "DELETE FROM cliente ";
        sql += "WHERE cpf = ? ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.cpf);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a consulta no BD para verificar se o cliente ja possui cadastro.
     * @param pCpf CPF do cliente.
     * @return 
     */
    public boolean clienteExiste(String pCpf) {
        Connection con = Conexao.conectar();
        String sql = "select cpf from cliente where cpf = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pCpf);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return true;
    }
    
    /**
     * Este método realiza consulta do cliente pelo CPF.
     * @param pCpf identificação do CPF do cliente.
     * @return Retorna um objeto Cliente com as informações solicitadas no método.
     */
    public Cliente consultarCliente(String pCpf) {
        this.cpf = pCpf;
        String sql = "select cpf, nome ";
        sql += "from cliente ";
        sql += "where cpf = ?";
        Connection con = Conexao.conectar();
        Cliente cliente = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.cpf);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cliente = new Cliente();
                cliente.setCpf(rs.getString("cpf"));
                cliente.setNome(rs.getString("nome"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return cliente;
    }
    
    /**
     * Este método realiza a consulta do cliente pelo CPF.
     * @param pCpf CPF do cliente.
     * @return Retorna uma Lista com informações do usuário solicitada.
     */
    public List<Cliente> consultarClientesCpf(String pCpf) {
        this.cpf = pCpf;
        List<Cliente> lista = new ArrayList<>();
        String sql = "select * from cliente where cpf= ?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.cpf);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setCpf(rs.getString("cpf"));
                c.setNome(rs.getString("nome"));
                lista.add(c);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
    
    /**
     * Este método reliza a consulta de todos os clientes cadastrados.
     * @return Retorna uma Lista com todos os clientes cadastrados no sistema.
     */
    public List<Cliente> consultarGeral() {
        List<Cliente> lista = new ArrayList<>();
        Connection con = Conexao.conectar();
        String sql = "select * from cliente order by cpf";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setCpf(rs.getString("cpf"));
                cliente.setNome(rs.getString("nome"));
                lista.add(cliente);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }

// secao de getters e setters
    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
