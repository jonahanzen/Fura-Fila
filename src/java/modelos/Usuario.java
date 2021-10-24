/** *****************************************************************************
 * ENTRA21 - TURMA 2021 - EQUIPE INFINITY
 * DEFINIÇÃO: CADASTRO DO USUARIO
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
 * Esta classe é responsavel por representar o objeto Usuario e seus metodos de crud.
 * 
 */
public class Usuario {

    private String usuario;
    private String senhausuario;
    private String idCpf;
    private boolean situacao;

    /**
     * Este método realiza a inclusão das informações do usuário no BD.
     * @return 
     */
    public boolean incluirUsuario() {
        // declarando comando de execucao do banco de dados
        String sql = "insert into usuario (usuario,senhausuario,idcpf,situacao) VALUES (?,?,?,?)";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.usuario);
            stm.setString(2, this.senhausuario);
            stm.setString(3, this.idCpf);
            stm.setBoolean(4, this.situacao);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    /**
     * Este método realiza a alteração das informações do usuário.
     * @return 
     */
    public boolean alterarUsuario() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE usuario ";
        sql += " set senhausuario=?, ";
        sql += " situacao= ? ";
        sql += " where usuario= ? ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.senhausuario);
            stm.setBoolean(2, this.situacao);
            stm.setString(3, this.usuario);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * @deprecated 
     * @return 
     */    
    public boolean alterarSenha() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE usuario ";
        sql += " set senhausuario=?, ";
        sql += " where usuario= ? ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.senhausuario);
            stm.setString(2, this.usuario);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    /**
     * @deprecated 
     * @param pIdCpf
     * @return 
     */
    public Usuario consultarUsuario(String pIdCpf) {
        this.idCpf = pIdCpf;
        String sql = "select * from usuario where idcpf = ?";
        Connection con = Conexao.conectar();
        Usuario us = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.idCpf);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                us = new Usuario();
                us.setUsuario(rs.getString("usuario"));
                us.setSenhausuario(rs.getString("senhausuario"));
                us.setSituacao(rs.getBoolean("situacao"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return us;
    }
    
    /**
     * Este método consulta a situação do usuário.
     * @param pUsario Nome do usuário.
     * @return Retorna um objeto usuário com as informações solicitadas no método.
     */
    public Usuario consultarSituacaoUsuario(String pUsario) {
        String sql = "select * from usuario where usuario = ?";
        Connection con = Conexao.conectar();
        Usuario us = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pUsario);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                us = new Usuario();
                us.setUsuario(rs.getString("usuario"));
                us.setSenhausuario(rs.getString("senhausuario"));
                us.setSituacao(rs.getBoolean("situacao"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return us;
    }
   

    /**
     * Este método consulta usuário pelo CPF.
     * @param pIdCpf CPF do usuário.
     * @return Retorna uma Lista com as informações do usuário.
     */
    public List<Usuario> consultarUsuarioLista(String pIdCpf) {
        this.idCpf = pIdCpf;
        List<Usuario> lista = new ArrayList<>();
        String sql = "select * from usuario where idcpf=?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.idCpf);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setSenhausuario(rs.getString("senhausuario"));
                usuario.setSituacao(rs.getBoolean("situacao"));
                lista.add(usuario);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
    
    /**
     * Este método consulta o usuário.
     * @param pUsuario Nome do usuário.
     * @return Retorna uma Lista com as informações do usuário.
     */
    public List<Usuario> consultarUsuarioLista2 (String pUsuario) {
        List<Usuario> lista = new ArrayList<>();
        String sql = "select * from usuario where usuario=?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pUsuario);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setSenhausuario(rs.getString("senhausuario"));
                usuario.setSituacao(rs.getBoolean("situacao"));
                lista.add(usuario);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
    

    /**
     * Este método realiza consulta de todos os usuários cadastrados no sistema.
     * @return Retorna uma Lista com os usuários cadastrados no sistema.
     */
    public List<Usuario> consultarGeral() {
        List<Usuario> lista = new ArrayList<>();
        Connection con = Conexao.conectar();
        String sql = "select * from usuario";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setidCpf(rs.getString("idcpf"));
                lista.add(usuario);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }
    //

    /**
     * Este método realiza consulta para validar usuario e senha pelo BD para iniciar uma sessão.
     * @param pUser Nome do usuário.
     * @param pSenha Senha do Usuário.
     * @return 
     */
    public boolean podeLogar(String pUser, String pSenha) {
        Connection con = Conexao.conectar();
        String sql = "select * from usuario where usuario = ? and senhausuario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pUser);
            stm.setString(2, pSenha);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return true;
    }
    
    /**
     * Este método verifica se o usuário existe no BD.
     * @param pUser Nome do usuário.
     * @return 
     */ 
    public boolean usuarioExiste(String pUser) {
        Connection con = Conexao.conectar();
        String sql = "select usuario from usuario where usuario = ?";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pUser);
            ResultSet rs = stm.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
        return true;
    }
    
     /**
     * Este método verifica se o usuário existe no BD.
     * @param pUser Nome do usuário.
     * @return 
     */ 
    public boolean usuarioExisteComEsteCPF(String pCpf) {
        Connection con = Conexao.conectar();
        String sql = "select usuario from usuario where idcpf = ?";
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

    @Override
    public String toString() {
        return "Usuario{" + "usuario=" + usuario + ", senhausuario=" + senhausuario + ", idCpf=" + idCpf + ", situacao=" + situacao + '}';
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenhausuario() {
        return senhausuario;
    }

    public void setSenhausuario(String senhausuario) {
        this.senhausuario = senhausuario;
    }

    public String getidCpf() {
        return idCpf;
    }

    public void setidCpf(String idCpf) {
        this.idCpf = idCpf;
    }

    public boolean isSituacao() {
        return situacao;
    }

    public void setSituacao(boolean situacao) {
        this.situacao = situacao;
    }

}
