package metodopix;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import org.json.JSONObject;
import com.mifmif.common.regex.Generex;

/**
 * Classe responsável por criar uma cobranca na API do GerenciaNet. A classe
 * possui um método que cria a cobrança, retornando a String de resposa da API,
 * bem como um método para capturar o ID da cobrança criada.
 *
 *
 */
public class CriarCobranca {

    /**
     * Método responsável por criar uma cobrança na API do GerenciaNet O método
     * vai, a partir dos parametros, e já com o acesso a API
     *
     * @see metodopix.Autenticar Criar uma cobrança com parametro de CPF da
     * pessoa que irá pagar, Nome e Valor da cobrança a ser criada
     *
     * @param token de acesso
     * @param pCpf de quem vai realizar o pagamento
     * @param pNome de quem vai realizar o pagamento
     * @param pValor do pagamento a ser feito
     * @return String de resposta da API contendo todos os dados refente a
     * cobrança criada
     */
    public String doCob(String token, String pCpf, String pNome, float pValor) {
        String payload;
        payload = "{\r\n"
                + "  \"calendario\": {\r\n"
                + "    \"expiracao\": 3600\r\n"
                + "  },\r\n"
                + "  \"devedor\": {\r\n"
                + "    \"cpf\": \"" + pCpf + "\",\r\n"
                + "    \"nome\": \"" + pNome + "\"\r\n"
                + "  },\r\n"
                + "  \"valor\": {\r\n"
                + "    \"original\": \"" + pValor + "\"\r\n"
                + "  },\r\n"
                + "  \"chave\": \"SUA CHAVE AQUI\",\r\n"
                + "  \"solicitacaoPagador\": \"Informe o número ou identificador do pedido.\"\r\n"
                + "}";

        //cobrança
        StringBuilder responseBuilder = new StringBuilder();
        HttpsURLConnection conn = null;

        try {
            System.setProperty("javax.net.ssl.keyStore", "NOME DO SEU CERTIFICADO.p12");

            String txid;
            Generex generex = new Generex("[a-zA-Z0-9]{26,35}");
            txid = generex.random();
            //URL DE HOMOLOGACAO
            URL url = new URL("https://api-pix.gerencianet.com.br/v2/cob/" + txid);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("PUT");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + token);

            OutputStream os = conn.getOutputStream();
            os.write(payload.getBytes());
            os.flush();

            InputStreamReader reader = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(reader);

            String response;
            while ((response = br.readLine()) != null) {
                responseBuilder.append(response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseBuilder.toString();
    }

    /**
     * Método responsável por pegar o ID da cobrança criada,
     *
     * @see metodopix.CriarCobranca
     *
     *
     * @param cob String da cobrança criada
     * @return int Id da cobrança
     */
    public int getIdCob(String cob) {
        int id = 0;
        try {
            JSONObject jsonObject = new JSONObject(cob);
            JSONObject loc = (JSONObject) jsonObject.get("loc");
            id = loc.getInt("id");
        } catch (Exception e) {
            System.out.println("Erro na obtenção do id da Cobrança");
            e.printStackTrace();
        }
        return id;
    }

}
