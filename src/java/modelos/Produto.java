/*******************************************************************************
* ENTRA21 - TURMA 2021 - EQUIPE INFINITY
* DEFINIÇÃO: CADASTRO DO PRODUTO
* AUTOR: FERNANDO D B DA CUNHA
********************************************************************************
*/
package modelos;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import org.apache.tomcat.util.http.fileupload.FileItem;
import utils.Conexao;

/**
 * Esta classe é responsavel por representar o objeto Produto e seus metodos de crud.
 * 
 */
public class Produto {

    private int idProduto;
    private String descricaoProduto;
    private String marcaProduto;
    private int quantidadeProduto;
    private float valorProduto;
    private boolean situacaoProduto;
    private int reservaProduto;
    private int bkpquantidade;
    private boolean situacaoEstoque;

    @Override
    public String toString() {
        return "Produto{" + "idProduto=" + idProduto + ", descricaoProduto=" + descricaoProduto + ", marcaProduto=" + marcaProduto + ", quantidadeProduto=" + quantidadeProduto + ", valorProduto=" + valorProduto + ", situacaoProduto=" + situacaoProduto + ", reservaProduto=" + reservaProduto + ", bkpquantidade=" + bkpquantidade + ", situacaoEstoque=" + situacaoEstoque + '}';
    }

   
    /**
     * Este método realiza a inclusão das informações do produto no BD.
     * @return 
     */
    public boolean incluirProduto() {
        // declarando comando de execucao do banco de dados
        String sql = "INSERT INTO produto ";
        sql += "(descricaoproduto,marcaproduto,quantidadeproduto,valorproduto,situacaoproduto,reserva,situacaoestoque,bkpquantidade)";
        sql += " VALUES(?,?,?,?,?,?,?,?) ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.descricaoProduto);
            stm.setString(2, this.marcaProduto);
            stm.setInt(3, this.quantidadeProduto);
            stm.setFloat(4, this.valorProduto);
            stm.setBoolean(5, this.situacaoProduto);
            stm.setInt(6, this.reservaProduto);
            stm.setBoolean(7, this.situacaoEstoque);
            stm.setInt(8, this.bkpquantidade);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    } 

    /**
     * Este método realiza a alteração das informações relacionada ao produto.
     * @return 
     */
    public boolean alterarProduto() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE produto ";
        sql += "SET descricaoproduto  = ?,";
        sql += "    marcaproduto = ?,";
        sql += "    valorproduto = ?, ";
        sql += "    situacaoproduto = ?,";
        sql += "    situacaoestoque = ?";
        sql += "where idproduto = ?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1,  this.descricaoProduto);
            stm.setString(2,  this.marcaProduto);
            stm.setFloat(3,   this.valorProduto);
            stm.setBoolean(4, this.situacaoProduto);
            stm.setBoolean(5, this.situacaoEstoque);
            stm.setInt(6,     this.idProduto);
            
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a alteração aumentando a quantidade e a reserva do produto.
     * @param iIdProduto Identificação produto.
     * @param iQuantidadeProduto Quantidade do produto a ser alterada.
     * @return 
     */
    public boolean aumentarQuantidadeProduto(int iIdProduto, int iQuantidadeProduto) {
        Produto p = new Produto();
        p=p.consultarQuantidadeAtualProduto(iIdProduto);
        int quantidadeAtual = p.getQuantidadeProduto();
        int quantidadeAtualizar = (quantidadeAtual+iQuantidadeProduto);
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE produto ";
        sql += "SET quantidadeproduto  = ?,";
        sql += "    bkpquantidade  = ?";
        sql += "where idproduto = ?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, quantidadeAtualizar);
            stm.setInt(2, quantidadeAtualizar);
            stm.setInt(3, iIdProduto);
            stm.execute();
            
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a alteração diminuindo a quantidade e a reserva do produto.
     * @param iIdProduto Identificação do produto.
     * @param iQuantidadeProduto Quantidade a ser reduzida do produto.
     * @return 
     */
    public boolean diminuirQuantidadeProduto(int iIdProduto, int iQuantidadeProduto) {
        Produto p = new Produto();
        p=p.consultarQuantidadeAtualProduto(iIdProduto);
        int quantidadeAtual = p.getQuantidadeProduto();
        int quantidadeAtualizar = (quantidadeAtual-iQuantidadeProduto);
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE produto ";
        sql += "SET quantidadeproduto  = ?,";
        sql += "    bkpquantidade  = ?";
        sql += "where idproduto = ?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, quantidadeAtualizar);
            stm.setInt(2, quantidadeAtualizar);
            stm.setInt(3, iIdProduto);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a alteração na quantidade de reserva do produto.
     * @param pIdProduto Identificação do produto.
     * @param pQuantidade Quantidade de produtos a ser reservados.
     * @return 
     */
    public boolean alterarQuantidadeReserva(int pIdProduto,int pQuantidade) {
   
        String sql = "UPDATE produto ";
        sql += "SET reserva  = "+pQuantidade+"";
        sql += "where idproduto = "+pIdProduto+"";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
     
    /**
     * Este método altera a situaçao do estoque do produto.
     * @param pIdProduto identificação do produto.
     * @return 
     */
    public boolean alterarSituacaoEstoque(int pIdProduto) {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE produto ";
        sql += "SET quantidadeproduto  = ?,";
        sql += "    reserva    = ?,";
        sql += "    situacaoestoque    = ?";
        sql += "where idproduto        = ?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.quantidadeProduto);
            stm.setInt(2, this.reservaProduto);
            stm.setBoolean(3, this.situacaoEstoque);
            stm.setInt(4, pIdProduto);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
     
    /**
     * Este método realiza a alteração da situação do estoque referente ao produto.
     * @param pIdProduto Identificação do produto.
     * @return 
     */ 
    public boolean alterarSomenteSituacaoEstoque(int pIdProduto) {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE produto ";
        sql += "SET situacaoestoque   = ?";
        sql += "where idproduto        = ?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setBoolean(1, this.situacaoEstoque);
            stm.setInt(2, pIdProduto);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
     /**
      * Este método realiza a consulta da quantidade e a reserva atual do produto no estoque.
      * @param pIdProduto Identificação do produto.
      * @return Este método retorna um objeto Produto com as informações solicitadas no método.
      */
     public Produto consultarQuantidadeAtualProduto(Integer pIdProduto) {
        this.idProduto = pIdProduto;
        String sql = "select * from produto where idproduto =?";
        Connection con = Conexao.conectar();
        Produto p = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setReservaProduto(rs.getInt("reserva"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return p;
    }
     
    
    
   /**
    * Este método verifica se a quantidade do produto nao é igual a quantidade de reserva.
    * @param pIdProduto Indentificação do produto.
    * @return 
    */
     public boolean verificarAlterarListaVenda(int pIdProduto){
       Produto p = null;
        p = new Produto();
        p=p.consultarProduto(pIdProduto);
       
           int quantidadeProduto=p.getQuantidadeProduto();
           int quantidadeReserva=p.getReservaProduto();
           if (quantidadeReserva>=quantidadeProduto){
           return true;
       }       
       return false;
   }  
     
  
   
   /**
    * Este método altera quantidade reserva do produto.
    * @param pIdProduto Identificação do produto.
    * @param pQuantidade Quantidade de produto que vai na reserva.
    * @return 
    */
   public boolean reporQuantidadeReserva(int pIdProduto,int pQuantidade) {
        // declarando comando de execucao do banco de dados     
        String sql = "UPDATE produto ";
        sql += "SET reserva  = "+pQuantidade+"";
        sql += "where idproduto = "+pIdProduto+"";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
   
   
   
    /**
     * Este método consulta um produto pela identificação do produto.
     * @param pIdProduto Identificação do produto.
     * @return Retorna um objeto Produto com as informações que foram solicitadas no método.
     */
   public Produto consultarProduto(Integer pIdProduto) {
        this.idProduto = pIdProduto;
        String sql = "select * from produto where idproduto =?";
        Connection con = Conexao.conectar();
        Produto p = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setDescricaoProduto(rs.getString("descricaoProduto"));
                p.setMarcaProduto(rs.getString("marcaProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setValorProduto(rs.getFloat("valorProduto"));
                p.setSituacaoProduto(rs.getBoolean("situacaoProduto"));
                p.setReservaProduto(rs.getInt("reserva"));
                p.setSituacaoEstoque(rs.getBoolean("situacaoEstoque"));
                p.setBkpquantidade(rs.getInt("bkpquantidade"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return p;
    }

    
   /**
    * Este método consulta o produto através da descrição do produto.
    * @param pDescricaoProduto Descrição do produto.
    * @return Retorna uma lista com a descrição dos produtos cadastrados no sistema.
    */ 
   public List<Produto> consultarProdutoPelaDescricao(String pDescricaoProduto) {
        List<Produto> lista = new ArrayList<>();
        String sql = "select * from produto where descricaoproduto =?";
        Connection con = Conexao.conectar();

        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pDescricaoProduto);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setDescricaoProduto(rs.getString("descricaoProduto"));
                p.setMarcaProduto(rs.getString("marcaProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setValorProduto(rs.getFloat("valorProduto"));
                p.setSituacaoProduto(rs.getBoolean("situacaoProduto"));
                lista.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }

   /**
    * @deprecated 
    * @param pIdProduto
    * @return 
    */ 
   public List<Produto> consultarProdutoPelaId(int pIdProduto) {
        List<Produto> lista = new ArrayList<>();
        String sql = "select * from produto where idproduto =?";
        Connection con = Conexao.conectar();

        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdProduto);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setDescricaoProduto(rs.getString("descricaoProduto"));
                p.setMarcaProduto(rs.getString("marcaProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setValorProduto(rs.getFloat("valorProduto"));
                p.setSituacaoProduto(rs.getBoolean("situacaoProduto"));
                p.setReservaProduto(rs.getInt("reserva"));
                lista.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }
    
    
    
    /**
     * Este método realiza a consulta de todos os produtos cadastrados no sistema.
     * @return Retorna uma Lista com todos os produtos cadastrados no sistema.
     */
    public List<Produto> consultarTodosProdutos() {
        List<Produto> lista = new ArrayList<>();
        Connection con = Conexao.conectar();
        String sql = "select * from produto order by idproduto ";
        
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setDescricaoProduto(rs.getString("descricaoProduto"));
                p.setMarcaProduto(rs.getString("marcaProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setValorProduto(rs.getFloat("valorProduto"));
                p.setSituacaoProduto(rs.getBoolean("situacaoProduto"));
                lista.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }

    /**
     * Este método consulta os produtos que estão disponíveis no sistema.
     * @return Retorna uma lista com os produtos disponíveis no sistema.
     */
    public List<Produto> consultarTodosProdutosDisponiveis() {
        List<Produto> lista = new ArrayList<>();
        Connection con = Conexao.conectar();
        String sql = "select * from produto where situacaoproduto=true and situacaoestoque=true order by idproduto";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Produto p = new Produto();
                p.setIdProduto(rs.getInt("idProduto"));
                p.setDescricaoProduto(rs.getString("descricaoProduto"));
                p.setMarcaProduto(rs.getString("marcaProduto"));
                p.setQuantidadeProduto(rs.getInt("quantidadeProduto"));
                p.setValorProduto(rs.getFloat("valorProduto"));
                p.setReservaProduto(rs.getInt("reserva"));
                p.setSituacaoProduto(rs.getBoolean("situacaoProduto"));
                lista.add(p);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return lista;
    }
    
    

    // area de getters e setters
    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public String getDescricaoProduto() {
        return descricaoProduto;
    }

    public void setDescricaoProduto(String descricaoProduto) {
        this.descricaoProduto = descricaoProduto;
    }

    public String getMarcaProduto() {
        return marcaProduto;
    }

    public void setMarcaProduto(String marcaProduto) {
        this.marcaProduto = marcaProduto;
    }

    public int getQuantidadeProduto() {
        return quantidadeProduto;
    }

    public void setQuantidadeProduto(int quantidadeProduto) {
        this.quantidadeProduto = quantidadeProduto;
    }

    public float getValorProduto() {
        return valorProduto;
    }

    public void setValorProduto(float valorProduto) {
        this.valorProduto = valorProduto;
    }

    public boolean isSituacaoProduto() {
        return situacaoProduto;
    }

    public void setSituacaoProduto(boolean situacaoProduto) {
        this.situacaoProduto = situacaoProduto;
    }

    public int getReservaProduto() {
        return reservaProduto;
    }

    public void setReservaProduto(int reservaProduto) {
        this.reservaProduto = reservaProduto;
    }

    public boolean isSituacaoEstoque() {
        return situacaoEstoque;
    }

    public void setSituacaoEstoque(boolean situacaoEstoque) {
        this.situacaoEstoque = situacaoEstoque;
    }

    public int getBkpquantidade() {
        return bkpquantidade;
    }

    public void setBkpquantidade(int bkpquantidade) {
        this.bkpquantidade = bkpquantidade;
    }

}
