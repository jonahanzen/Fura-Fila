/*******************************************************************************
* ENTRA21 - TURMA 2021 - EQUIPE INFINITY
* DEFINIÇÃO: CADASTRO DE VENDA
* AUTOR: FERNANDO D B DA CUNHA
********************************************************************************
*/
package modelos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import metodopix.Autenticar;
import metodopix.CriarCobranca;
import metodopix.QRCode;
import utils.Conexao;

/**
 * Esta classe é responsavel por representar o objeto Loja e seus metodos de crud.
 * 
 */
public class Loja {

    private int idVenda;
    private Date dataAtual;
    private int quantidade;
    private int idProduto;
    private String idCpf;
    private float totalVenda;
    private boolean situacaovenda;
    private boolean situacaoatendimento;
    private Timestamp horaconfirmacao;
    private Timestamp horaatual;

    @Override
    public String toString() {
        return "Loja{" + "idVenda=" + idVenda + ", dataAtual=" + dataAtual + ", quantidade=" + quantidade + ", idProduto=" + idProduto + ", idCpf=" + idCpf + ", totalVenda=" + totalVenda + ", situacaovenda=" + situacaovenda + ", situacaoatendimento=" + situacaoatendimento + ", horaconfirmacao=" + horaconfirmacao + ", horaatual=" + horaatual + '}';
    }

   
    /**
     * Este método realiza a inclusão das informções relacionados a venda no BD.
     * @return 
     */
    public boolean incluirVenda() {
        String sql = "insert into loja (dataatual,idcpf,situacaovenda,situacaoatendimento) ";
        sql += " values(current_date,?,?,?) ";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.idCpf);
            stm.setBoolean(2, this.situacaovenda);
            stm.setBoolean(3, this.situacaoatendimento);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    
    public boolean vendaExiste(int pIdVenda) {
        String sql = "select * from loja where situacaovenda=true and id=?";   
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            return false;
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
           
        }
       return true;
    }
    
    
    
    /**
     * Este método realiza a inclusão dos itens no pedido.
     * @return 
     */
    public boolean incluirItensNoPedido() {
        String sql = "insert into itemvenda (idvenda,idcpf,idproduto,quantidade) ";
        sql += " values(?,?,?,?) ";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idVenda);
            stm.setString(2, this.idCpf);
            stm.setInt(3, this.idProduto);
            stm.setInt(4, this.quantidade);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza alteração da quantidade unitária do item no pedido.
     * @return 
     */
    public boolean alterarQuantidadeItensNoPedido() {
        String sql = "UPDATE itemvenda ";
        sql += " set quantidade = ?";
        sql += " where idvenda = ?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.quantidade);
            stm.setInt(2, this.idVenda);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    
    
      /**
     * Este método realiza a alteração do horário atual.
     * @param pIdVenda Identificação da venda.
     * @return 
     */ 
    public boolean atualizaHoraAtual(int pIdVenda) {
        String sql = "UPDATE loja ";
        sql += " set horaatual = (select current_timestamp)";
        sql += " where id= ?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a alteração do horário atual.
     * @param pIdVenda Identificação da venda.
     * @return 
     */ 
    public boolean atualizaHoraConfirmacao(int pIdVenda) {
        String sql = "UPDATE loja ";
        sql += " set horaconfirmacao = (select current_timestamp)";
        sql += " where id= ?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    } 
    
    /**
     * Este metodo realiza a alteração da situação atendimento
     * @param pIdVenda Identificação da venda
     * @return 
     */ 
    public boolean alterarSituacaoAtendimento(int pIdVenda) {
        String sql = "UPDATE loja ";
        sql += " set situacaoatendimento = true";
        sql += " where id= ?";   
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            return false;
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
           
        }
       return true;
    }
    
    /**
     * Este método realiza a alteração da situação da venda.
     * @param pIdVenda Identificação da venda.
     * @return 
     */
    public boolean confirmaVenda(int pIdVenda) {
        String sql = "UPDATE loja ";
        sql += " set situacaovenda = true";
        sql += " where id = ?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.execute();

        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a alteração do valor total da venda.
     * @return 
     */
    public boolean atualizarValorTotal() {
        // declarando comando de execucao do banco de dados
        String sql = "UPDATE loja ";
        sql += "set totalvenda     = ? ";
        sql += "where id = ? ";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setFloat(1, this.totalVenda);
            stm.setInt(2, this.idVenda );
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
    
    /**
     * Este método realiza a exclusão da venda.
     * OBS: Para exclusão da venda é necessária a exclusão dos itens do pedido primeiro.
     * @param pIdVenda Identificação da venda.
     * @return 
     */ 
    public boolean excluirVenda(int pIdVenda) {
        String sql = "delete from loja where id =?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
     
     /**
      * Este método realiza a exclusão dos itens do pedido.
      * @param pIdVenda Identificação da venda.
      * @return 
      */
     public boolean excluirTodosItensPedido(int pIdVenda) {
        String sql = "delete from itemvenda where idvenda=?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }
     
     /**
      * Este método realiza a exclusão do item no pedido.
      * @return 
      */
     public boolean excluirItemPedido() {
        String sql = "DELETE FROM itemvenda ";
        sql += "WHERE idvenda=? and idproduto=?";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, this.idVenda);
            stm.setInt(2, this.idProduto);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    public List<Loja> gerarPainel() {
        List<Loja> lista = new ArrayList<>();
        Connection con = Conexao.conectar();
        String sql = "select l.id,l.idcpf,i.idproduto,i.quantidade,l.totalvenda"; 
        sql += " from loja l, itemvenda i where l.id = i.idvenda order by id";

        ResultSet rs = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("id"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setDataAtual(rs.getDate("dataatual"));
                loj.setIdProduto(rs.getInt("idproduto"));
                loj.setQuantidade(rs.getInt("quantidade"));
                loj.setTotalVenda(rs.getFloat("totalvenda"));
                lista.add(loj);
            }

        } catch (SQLException ex) {
        }
        return lista;
    }
   

    /**
     * Este método consulta a última venda realizada no sistema pelo cliente.
     * @param pCpf CPF do cliente.
     * @return Retorna uma lista com as informações da venda.
     */ 
    public List<Loja> consultarVendaLista(String pCpf) {
        this.idCpf = pCpf;
        List<Loja> lista = new ArrayList<>();
        String sql = "select * from loja where idcpf=? and id=(select max(id) from loja where idcpf=?)";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, this.idCpf);
            stm.setString(2, this.idCpf);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("id"));
                loj.setDataAtual(rs.getDate("dataatual"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setTotalVenda(rs.getFloat("totalVenda"));
                lista.add(loj);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
    
    
    /**
     * Este método consulta todas as vendas realizadas no sistema.
     * @return Retorna uma Lista com as informações de todas as vendas realizadas no sistema.
     */ 
    public List<Loja> consultarVendaLista() {
        List<Loja> lista = new ArrayList<>();
        String sql = "select * from loja order by id";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("id"));
                loj.setDataAtual(rs.getDate("dataatual"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setTotalVenda(rs.getFloat("totalVenda"));
                lista.add(loj);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
     
     
     /**
      * Este método consulta as vendas que possuem a situacaoVenda= True.
      * @return Retorna uma lista com as informações da venda conforme solicitado no método.
      */
     public List<Loja> consultarVendasTRUE() {
        List<Loja> lista = new ArrayList<>();
        String sql = "select * from loja where situacaovenda=true and situacaoatendimento=false";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("id"));
                loj.setDataAtual(rs.getDate("dataatual"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setTotalVenda(rs.getFloat("totalVenda"));
                loj.setSituacaovenda(rs.getBoolean("situacaovenda"));
                loj.setSituacaoatendimento(rs.getBoolean("situacaoatendimento"));
                loj.setHoraconfirmacao(rs.getTimestamp("horaconfirmacao"));
                loj.setHoraatual(rs.getTimestamp("horaatual"));
                lista.add(loj);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
     
     /**
      * Este método consulta as informações da venda.
      * @param pIdVenda Identificação da venda.
      * @return Retorna uma Lista com informações da venda.
      */
     public List<Loja> consultarVendasPorIdVenda(int pIdVenda) {
         
        List<Loja> lista = new ArrayList<>();
        String sql = "select * from loja where id=?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("id"));
                loj.setDataAtual(rs.getDate("dataatual"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setTotalVenda(rs.getFloat("totalVenda"));
                loj.setSituacaovenda(rs.getBoolean("situacaovenda"));
                lista.add(loj);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
     
     /**
      * Este método serve para consultar os itens do pedido.
      * @param pIdVenda O número de identificação de venda.
      * @return Retorna Lista com itens do pedido.
      */
     public List<Loja>consultaListaPedidoPorIdVenda(int pIdVenda) { 
        List<Loja> lista = new ArrayList<>();
        String sql = "select * from itemvenda where idvenda=?";
        Connection con = Conexao.conectar();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Loja loj = new Loja();
                loj.setIdVenda(rs.getInt("idvenda"));
                loj.setIdCpf(rs.getString("idcpf"));
                loj.setIdProduto(rs.getInt("idproduto"));
                loj.setQuantidade(rs.getInt("quantidade"));
                lista.add(loj);
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return null;
        }
        return lista;
    }
    
     
     
    /**
     * @deprecated 
     * @param pIdCpf
     * @return 
     */
     public Loja consultarVenda(String pIdCpf) {
        String sql = "select * from loja where idcpf=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, pIdCpf);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("id"));
                loja.setDataAtual(rs.getDate("dataatual"));
                loja.setQuantidade(rs.getInt("quantidade"));
                loja.setIdProduto(rs.getInt("idproduto"));
                loja.setIdCpf(rs.getString("idcpf"));
                loja.setTotalVenda(rs.getFloat("totalvenda"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
    
    /**
     * @deprecated 
     * @param pIdVenda
     * @param pIdProduto
     * @return 
     */
     public Loja consultarItemPedido(int pIdVenda,int pIdProduto) {
        String sql = "select * from itemvenda where idvenda=?,idproduto=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.setInt(1, pIdProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("id"));
                loja.setIdProduto(rs.getInt("idproduto"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
    
        
    /**
     * Este médoto consulta as informações da venda.
     * @param pIdVenda Identificação da venda.
     * @return Retorna Objeto Loja com as informações solicitadas no método.
     */
    public Loja consultarPorIDVenda(int pIdVenda) {
        String sql = "select * from loja where id=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("id"));
                loja.setDataAtual(rs.getDate("dataatual"));
                loja.setQuantidade(rs.getInt("quantidade"));
                loja.setIdProduto(rs.getInt("idproduto"));
                loja.setIdCpf(rs.getString("idcpf"));
                loja.setTotalVenda(rs.getFloat("totalvenda"));
                loja.setSituacaovenda(rs.getBoolean("situacaovenda"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
        
        
        /**
         * Este método consulta os itens do pedido.
         * @param pIdVenda Identificação de venda.
         * @return Retorna objeto Loja com as informações solicitadas no método.
         */
        public Loja consultarPedidosPorIDVenda(int pIdVenda) {
        String sql = "select * from itemvenda where idvenda=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("id"));
                loja.setDataAtual(rs.getDate("dataatual"));
                loja.setQuantidade(rs.getInt("quantidade"));
                loja.setIdProduto(rs.getInt("idproduto"));
                loja.setIdCpf(rs.getString("idcpf"));
                loja.setTotalVenda(rs.getFloat("totalvenda"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
        
        /**
         * Este método consulta determinado produto na venda.
         * @param pIdVenda Identificação da venda.
         * @param pIdProduto Identificação do produto.
         * @return Retorna um Objeto Loja com as informações solicitadas no método.
         */
        public Loja consultarItensDoPedido(int pIdVenda, int pIdProduto) {
        String sql = "select * from itemvenda where idvenda=? and idproduto=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            stm.setInt(2, pIdProduto);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("idvenda"));
                loja.setQuantidade(rs.getInt("quantidade"));
                loja.setIdProduto(rs.getInt("idproduto"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
        
        /**
         * Este método consulta as informações da venda(Id da venda, CPF cliente, Total de venda).
         * @param pIdVenda Identificação da venda.
         * @return Retorna objeto Loja com informações solicitadas.
         */ 
        public Loja dadosGeraConta(int pIdVenda) {
        String sql = "select * from loja where id=?";
        Connection con = Conexao.conectar();
        Loja loja = null;
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, pIdVenda);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                loja = new Loja();
                loja.setIdVenda(rs.getInt("id"));
                loja.setIdCpf(rs.getString("idcpf"));
                loja.setTotalVenda(rs.getFloat("totalvenda"));

            }
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
        }
        return loja;
    }
    
        
    /**
     * @deprecated 
     * @param pIdProduto
     * @param pQuantidade
     * @return 
     */
        public boolean alterarEstoque(Integer pIdProduto, Integer pQuantidade) {
        this.idProduto = pIdProduto;
        this.quantidade = pQuantidade;
        // declarando comando de execucao do banco de dados
        Produto p = new Produto();
        p=p.consultarProduto(pIdProduto);
        int quantidadeAtual = p.getQuantidadeProduto();
        int quantidadeAtualizar = (quantidadeAtual - pQuantidade);
        
        String sql = "UPDATE produto ";
        sql += "SET quantidadeproduto  ="+quantidadeAtualizar+",";
        sql += "where idproduto = "+pIdProduto+",";
        // conectando no banco de dados
        Connection con = Conexao.conectar();
        // 
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.execute();
        } catch (SQLException ex) {
            System.out.println("Erro:" + ex.getMessage());
            return false;
        }
        return true;
    }

    public Date getDataAtual() {
        return dataAtual;
    }

    public void setDataAtual(Date dataAtual) {
        this.dataAtual = dataAtual;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public int getIdProduto() {
        return idProduto;
    }

    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
    }

    public String getIdCpf() {
        return idCpf;
    }

    public void setIdCpf(String idCpf) {
        this.idCpf = idCpf;
    }

    public int getIdVenda() {
        return idVenda;
    }

    public void setIdVenda(int idVenda) {
        this.idVenda = idVenda;
    }

    public float getTotalVenda() {
        return totalVenda;
    }

    public void setTotalVenda(float totalVenda) {
        this.totalVenda = totalVenda;
    }

    public boolean isSituacaovenda() {
        return situacaovenda;
    }

    public void setSituacaovenda(boolean situacaovenda) {
        this.situacaovenda = situacaovenda;
    }

    public boolean isSituacaoatendimento() {
        return situacaoatendimento;
    }

    public void setSituacaoatendimento(boolean situacaoatendimento) {
        this.situacaoatendimento = situacaoatendimento;
    }

    public Timestamp getHoraconfirmacao() {
        return horaconfirmacao;
    }

    public void setHoraconfirmacao(Timestamp horaconfirmacao) {
        this.horaconfirmacao = horaconfirmacao;
    }

    public Timestamp getHoraatual() {
        return horaatual;
    }

    public void setHoraatual(Timestamp horaatual) {
        this.horaatual = horaatual;
    }
}
