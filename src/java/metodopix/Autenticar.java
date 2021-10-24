package metodopix;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.util.Base64;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSocketFactory;
import org.json.JSONObject;

/**
 * Classe responsável por gerar um Token de acesso na API do GerenciaNet. A
 * classe contém as propriedades do certificado e credenciais necessários para a
 * autenticação.
 *
 *
 */
public class Autenticar {

    private final String client_id = "SEU CLIENT ID AQUI";
    private final String client_secret = "SEU CLIENT SECRET AQUI";
    private final String basicAuth = Base64.getEncoder().encodeToString(((client_id + ':' + client_secret).getBytes()));

    /**
     * Método responsável por acessar a API e gerar um token de acesso O método
     * localiza o certificado (que também deve estar instalado no servidor) e
     * retorna um String que corresponde ao acesso.
     *
     * @return String token de acesso a API do GerenciaNet
     */
    public String geraToken() {
        String tokenAcesso = "";
        try {
            //Diretório em que seu certificado em formato .p12 deve ser inserido
            System.setProperty("javax.net.ssl.keyStore",
                    "CAMINHO DO SEU CERTIFICADO .p12");
            SSLSocketFactory sslsocketfactory = (SSLSocketFactory) SSLSocketFactory.getDefault();

            //URL DA API PARA PRODUCAO
            URL url = new URL("https://api-pix.gerencianet.com.br/oauth/token");
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Basic " + basicAuth);
            conn.setSSLSocketFactory(sslsocketfactory);
            String input = "{\"grant_type\": \"client_credentials\"}";

            OutputStream os = conn.getOutputStream();
            os.write(input.getBytes());
            os.flush();

            InputStreamReader reader = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(reader);

            String response;
            StringBuilder responseBuilder = new StringBuilder();
            while ((response = br.readLine()) != null) {
                //System.out.println(response);
                responseBuilder.append(response);
            }
            try {
                JSONObject jsonObject = new JSONObject(responseBuilder.toString());
                tokenAcesso = jsonObject.getString("access_token");
            } catch (Exception e) {
                // TODO: handle exception
                System.out.println("Erro na conversão de " + responseBuilder);
                e.printStackTrace();
            }
            conn.disconnect();
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("Erro na autenticação de ");
            e.printStackTrace();
        }

        return tokenAcesso;
    }

}
