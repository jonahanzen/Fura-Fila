/*******************************************************************************
* ENTRA21 - TURMA 2021 - EQUIPE INFINITY
* DEFINIÇÃO: CONEXÃO COM BANCO DE DADOS
* AUTOR: FERNANDO D B DA CUNHA
********************************************************************************
*/
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Esta classe é responsavel por representar o objeto Conexão e seus metodos de conexão para o BD
 * 
 */
public class Conexao {
    
    /**
     * Este metodo realiza a conexão com o banco de dados
     * @return 
     */
    public static Connection conectar(){
        Connection con = null;
        String url = "jdbc:postgresql://localhost:5432/projetofurafila";
        String user = "postgres";
        String password = "admin";
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, user, password);
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("Erro ao conectar com o banco");
        }
        return con;                
    }
}
