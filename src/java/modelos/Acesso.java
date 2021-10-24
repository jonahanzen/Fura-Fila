
package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.Conexao;

/**
 * Essa classe é responsável por definir os tipos de usuário e seus acessos
 * as páginas Web.
 * 
 */
public class Acesso {

    private String idUsuario;
    private String usuario;
    private String tipoUsuario;

    private boolean acessoincluircliente;
    private boolean acessoalterarcliente;
    private boolean acessoconsultarcliente;
    private boolean acessoexcluircliente;

    private boolean acessoincluirusuario;
    private boolean acessoalterarusuario;
    private boolean acessoconsultarusuario;
    private boolean acessoconsultargrid;

    private boolean acessoincluirproduto;
    private boolean acessoalterarproduto;
    private boolean acessoconsultarproduto;

    private boolean acessorealizarvenda;
    private boolean acessocancelarvenda;
    private boolean acessoalterarvenda;
    private boolean acessoalterarsenha;
    
    private boolean acessomenuprincipal;
    private boolean acessoconsultarvenda;

    @Override
    public String toString() {
        return "Acesso{" + "idUsuario=" + idUsuario + ", usuario=" + usuario + ", tipoUsuario=" + tipoUsuario + ", acessoincluircliente=" + acessoincluircliente + ", acessoalterarcliente=" + acessoalterarcliente + ", acessoconsultarcliente=" + acessoconsultarcliente + ", acessoexcluircliente=" + acessoexcluircliente + ", acessoincluirusuario=" + acessoincluirusuario + ", acessoalterarusuario=" + acessoalterarusuario + ", acessoconsultarusuario=" + acessoconsultarusuario + ", acessoconsultargrid=" + acessoconsultargrid + ", acessoincluirproduto=" + acessoincluirproduto + ", acessoalterarproduto=" + acessoalterarproduto + ", acessoconsultarproduto=" + acessoconsultarproduto + ", acessorealizarvenda=" + acessorealizarvenda + ", acessocancelarvenda=" + acessocancelarvenda + ", acessoalterarvenda=" + acessoalterarvenda + ", acessoalterarsenha=" + acessoalterarsenha + ", acessomenuprincipal=" + acessomenuprincipal + ", acessoconsultarvenda=" + acessoconsultarvenda + '}';
    }

  
   

   
    

    /**
     * Este método realiza a inclusão das permissões que o usuário possui.
     * @return 
     */
    public boolean incluirAcesso() {
        // declarando comando de execucao do banco de dados
        String sql = "INSERT INTO acesso ";
        sql += "(usuario,"
                + "acessoincluircliente,"
                + "acessoalterarcliente,"
                + "acessoconsultarcliente,"
                + "acessoexcluircliente,"
                + "acessoincluirusuario,"
                + "acessoalterarusuario,"
                + "acessoconsultarusuario,"
                + "acessoincluirproduto,"
                + "acessoalterarproduto,"
                + "acessoconsultarproduto,"
                + "acessoconsultargrid,"
                + "acessorealizarvenda,"
                + "acessocancelarvenda,"
                + "acessoalterarvenda,"
                + "acessoalterarsenha,"
                + "acessomenuprincipal,"
                + "acessoconsultarvenda,"
                + "tipoUsuario)";
        sql += "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.usuario);
            stm.setBoolean(2, this.acessoincluircliente);
            stm.setBoolean(3, this.acessoalterarcliente);
            stm.setBoolean(4, this.acessoconsultarcliente);
            stm.setBoolean(5, this.acessoexcluircliente);
            stm.setBoolean(6, this.acessoincluirusuario);
            stm.setBoolean(7, this.acessoalterarusuario);
            stm.setBoolean(8, this.acessoconsultarusuario);
            stm.setBoolean(9, this.acessoincluirproduto);
            stm.setBoolean(10, this.acessoalterarproduto);
            stm.setBoolean(11, this.acessoconsultarproduto);
            stm.setBoolean(12, this.acessoconsultargrid);
            stm.setBoolean(13, this.acessorealizarvenda);
            stm.setBoolean(14, this.acessocancelarvenda);
            stm.setBoolean(15, this.acessoalterarvenda);
            stm.setBoolean(16, this.acessoalterarsenha);
            stm.setBoolean(17, this.acessomenuprincipal);
            stm.setBoolean(18, this.acessoconsultarvenda);
            stm.setString(19, this.tipoUsuario);

            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    /**
     * Este método consulta se o usuário possui determinado acesso, e o tipo de usuário.
     * @param pUsuario Serve para fazer consulta do acesso e tipo do usuário.
     * @return Retorna objeto Acesso, com os dados solicitados pelo método.
     */
    public Acesso consultarPermissoes(String pUsuario) {
        this.usuario = pUsuario;
        String sql = "select * from acesso where usuario = ?";
        Connection con = Conexao.conectar();
        Acesso ac = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.usuario);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                ac = new Acesso();
                ac.setUsuario(rs.getString("usuario"));
                ac.setTipoUsuario(rs.getString("tipoUsuario"));
                ac.setAcessoincluircliente(rs.getBoolean("acessoincluircliente"));
                ac.setAcessoalterarcliente(rs.getBoolean("acessoalterarcliente"));
                ac.setAcessoconsultarcliente(rs.getBoolean("acessoconsultarcliente"));
                ac.setAcessoexcluircliente(rs.getBoolean("acessoexcluircliente"));
                ac.setAcessoincluirusuario(rs.getBoolean("acessoincluirusuario"));
                ac.setAcessoalterarusuario(rs.getBoolean("acessoalterarusuario"));
                ac.setAcessoconsultarusuario(rs.getBoolean("acessoconsultarusuario"));
                ac.setAcessoincluirproduto(rs.getBoolean("acessoincluirproduto"));
                ac.setAcessoalterarproduto(rs.getBoolean("acessoalterarproduto"));
                ac.setAcessoconsultarproduto(rs.getBoolean("acessoconsultarproduto"));
                ac.setAcessoconsultargrid(rs.getBoolean("acessoconsultargrid"));
                ac.setAcessorealizarvenda(rs.getBoolean("acessorealizarvenda"));
                ac.setAcessocancelarvenda(rs.getBoolean("acessocancelarvenda"));
                ac.setAcessoalterarvenda(rs.getBoolean("acessoalterarvenda"));
                ac.setAcessoalterarsenha(rs.getBoolean("acessoalterarsenha"));
                ac.setAcessomenuprincipal(rs.getBoolean("acessomenuprincipal"));
                ac.setAcessoconsultarvenda(rs.getBoolean("acessoconsultarvenda"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro: no comando sql" + ex.getMessage());
        }
        return ac;
    }

    /**
     * Este método realiza a alteração da permissão do usuário.
     * @return 
     */
    public boolean alterarAcesso() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE acesso "
                + "SET tipoUsuario=?,"
                + "acessoincluircliente=?,"
                + "acessoalterarcliente=?,"
                + "acessoconsultarcliente=?,"
                + "acessoexcluircliente=?,"
                + "acessoincluirusuario=?,"
                + "acessoalterarusuario=?,"
                + "acessoconsultarusuario=?,"
                + "acessoincluirproduto=?,"
                + "acessoalterarproduto=?,"
                + "acessoconsultarproduto=?,"
                + "acessoconsultargrid=?,"
                + "acessorealizarvenda=?,"
                + "acessocancelarvenda=?,"
                + "acessoalterarvenda=?,"
                + "acessoalterarsenha=?,"
                + "acessomenuprincipal=?,"
                + "acessoconsultarvenda=?"
                + "where usuario=?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);

            stm.setString(1, this.tipoUsuario);
            stm.setBoolean(2, this.acessoincluircliente);
            stm.setBoolean(3, this.acessoalterarcliente);
            stm.setBoolean(4, this.acessoconsultarcliente);
            stm.setBoolean(5, this.acessoexcluircliente);
            stm.setBoolean(6, this.acessoincluirusuario);
            stm.setBoolean(7, this.acessoalterarusuario);
            stm.setBoolean(8, this.acessoconsultarusuario);
            stm.setBoolean(9, this.acessoincluirproduto);
            stm.setBoolean(10, this.acessoalterarproduto);
            stm.setBoolean(11, this.acessoconsultarproduto); 
            stm.setBoolean(12, this.acessoconsultargrid); 
            stm.setBoolean(13, this.acessorealizarvenda);
            stm.setBoolean(14, this.acessocancelarvenda);
            stm.setBoolean(15, this.acessoalterarvenda);
            stm.setBoolean(16, this.acessoalterarsenha);
            stm.setBoolean(17, this.acessomenuprincipal);
            stm.setBoolean(18, this.acessoconsultarvenda);
            stm.setString(19, this.usuario);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    public String getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public boolean isAcessoincluircliente() {
        return acessoincluircliente;
    }

    public void setAcessoincluircliente(boolean acessoincluircliente) {
        this.acessoincluircliente = acessoincluircliente;
    }

    public boolean isAcessoalterarcliente() {
        return acessoalterarcliente;
    }

    public void setAcessoalterarcliente(boolean acessoalterarcliente) {
        this.acessoalterarcliente = acessoalterarcliente;
    }

    public boolean isAcessoconsultarcliente() {
        return acessoconsultarcliente;
    }

    public void setAcessoconsultarcliente(boolean acessoconsultarcliente) {
        this.acessoconsultarcliente = acessoconsultarcliente;
    }

    public boolean isAcessoexcluircliente() {
        return acessoexcluircliente;
    }

    public void setAcessoexcluircliente(boolean acessoexcluircliente) {
        this.acessoexcluircliente = acessoexcluircliente;
    }

    public boolean isAcessoincluirusuario() {
        return acessoincluirusuario;
    }

    public void setAcessoincluirusuario(boolean acessoincluirusuario) {
        this.acessoincluirusuario = acessoincluirusuario;
    }

    public boolean isAcessoalterarusuario() {
        return acessoalterarusuario;
    }

    public void setAcessoalterarusuario(boolean acessoalterarusuario) {
        this.acessoalterarusuario = acessoalterarusuario;
    }

    public boolean isAcessoconsultarusuario() {
        return acessoconsultarusuario;
    }

    public void setAcessoconsultarusuario(boolean acessoconsultarusuario) {
        this.acessoconsultarusuario = acessoconsultarusuario;
    }

    public boolean isAcessoincluirproduto() {
        return acessoincluirproduto;
    }

    public void setAcessoincluirproduto(boolean acessoincluirproduto) {
        this.acessoincluirproduto = acessoincluirproduto;
    }

    public boolean isAcessoalterarproduto() {
        return acessoalterarproduto;
    }

    public void setAcessoalterarproduto(boolean acessoalterarproduto) {
        this.acessoalterarproduto = acessoalterarproduto;
    }

    public boolean isAcessoconsultarproduto() {
        return acessoconsultarproduto;
    }

    public void setAcessoconsultarproduto(boolean acessoconsultarproduto) {
        this.acessoconsultarproduto = acessoconsultarproduto;
    }

    public boolean isAcessorealizarvenda() {
        return acessorealizarvenda;
    }

    public void setAcessorealizarvenda(boolean acessorealizarvenda) {
        this.acessorealizarvenda = acessorealizarvenda;
    }

    public boolean isAcessocancelarvenda() {
        return acessocancelarvenda;
    }

    public void setAcessocancelarvenda(boolean acessocancelarvenda) {
        this.acessocancelarvenda = acessocancelarvenda;
    }

    public boolean isAcessoalterarvenda() {
        return acessoalterarvenda;
    }

    public void setAcessoalterarvenda(boolean acessoalterarvenda) {
        this.acessoalterarvenda = acessoalterarvenda;
    }

    public boolean isAcessoalterarsenha() {
        return acessoalterarsenha;
    }

    public void setAcessoalterarsenha(boolean acessoalterarsenha) {
        this.acessoalterarsenha = acessoalterarsenha;
    }

    public boolean isAcessomenuprincipal() {
        return acessomenuprincipal;
    }

    public void setAcessomenuprincipal(boolean acessomenuprincipal) {
        this.acessomenuprincipal = acessomenuprincipal;
    }

    public boolean isAcessoconsultargrid() {
        return acessoconsultargrid;
    }

    public void setAcessoconsultargrid(boolean acessoconsultargrid) {
        this.acessoconsultargrid = acessoconsultargrid;
    }

    public boolean isAcessoconsultarvenda() {
        return acessoconsultarvenda;
    }

    public void setAcessoconsultarvenda(boolean acessoconsultarvenda) {
        this.acessoconsultarvenda = acessoconsultarvenda;
    }
}
