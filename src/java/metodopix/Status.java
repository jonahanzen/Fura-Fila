package metodopix;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import org.json.JSONObject;

/**
 * Classe responsável por consultar o Status de uma cobrança na API do
 * GerenciaNet.
 *
 * @see metodopix.CriarCobranca
 *
 */
public class Status {

    /**
     * Método responsável por consultar o Status de uma cobrança. O método vai,
     * ao receber uma String txid e String de acesso a API irá consultar a API e
     * retornar os dados da cobrança.
     *
     *
     * @param txid txid da cobrança
     * @param access_token string de acesso a API
     * @return String de dados da cobrança que foi consultada
     */
    public String getStatus(String txid, String access_token) {
        String result = "";
        StringBuilder responseBuilder = new StringBuilder();
        HttpsURLConnection conn = null;
        try {
            //URL DE PRODUCAO
            URL url = new URL("https://api-pix.gerencianet.com.br/v2/cob/" + txid);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + access_token);

            InputStreamReader reader = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(reader);

            String response;
            while ((response = br.readLine()) != null) {
                //System.out.println("Recebido "+response);
                responseBuilder.append(response);
            }
            result = responseBuilder.toString();
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("Erro na consulta dos dados da cobrança");
            e.printStackTrace();
        }

        return result;

    }

}
