package metodopix;

import java.awt.Desktop;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.net.ssl.HttpsURLConnection;
import org.json.JSONObject;

/**
 * Classe responsável pelos Métodos referentes ao QRCode de uma Cobrança na API
 * do GerenciaNet. A classe realiza consultas na API, cria QRCode, Salva e
 * mostra a Imagem de base64.
 *
 */
public class QRCode {

    public String qRCode;
    public String image;

    /**
     * Método responsável por gerar um QRCode na API do GerenciaNet. O método
     * vai receber como parametro o ID da Cobrança e uma String de acesso,
     *
     *
     * @param idCob id da cobrança para gerar o QRCode
     * @param access_token String de acesso a API do GerenciaNet
     * @return String da consulta
     */
    public String genQrCode(int idCob, String access_token) {
        String result = "";
        StringBuilder responseBuilder = new StringBuilder();
        HttpsURLConnection conn = null;
        try {
            //URL DE PRODUCAO
            URL url = new URL("https://api-pix.gerencianet.com.br/v2/loc/" + idCob + "/qrcode");
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
            System.out.println("Erro na geração do QrCode");
            e.printStackTrace();
        }

        return result;

    }

    /**
     * Método responsável por pegar o QRCode a partir do resultado de uma
     * consulta na API do GerenciaNet. O método vai receber o String da consulta
     * e a partir dessa String, fazer o parse do resultado, deixando apenas o
     * QRCode.
     *
     * @param loc Location do QRCode
     * @return String do QRCode
     */
    public String getQrCode(String loc) {
        try {
            JSONObject jsonObject = new JSONObject(loc);
            this.qRCode = jsonObject.getString("qrcode");
        } catch (Exception e) {
            System.out.println("Erro na obtenção do QrCode do loc");
            e.printStackTrace();
        }
        return this.qRCode;
    }

    /**
     * Método responsável por pegar a imagem do QRCode a partir do resultado de
     * uma consulta na API do GerenciaNet. O método vai receber o String da
     * consulta e a partir dessa String, fazer o parse do resultado, deixando
     * apenas a imagem do QRCode. O método vai, a partir d
     *
     * @param loc Location do QRCode
     * @return String da imagem do QRCode em base64
     */
    public String getImage(String loc) {
        try {
            JSONObject jsonObject = new JSONObject(loc);
            this.image = jsonObject.getString("imagemQrcode");
        } catch (Exception e) {
            System.out.println("Erro na obtenção do QrCode do loc");
            e.printStackTrace();
        }
        return this.image;
    }

    
    /**
     * Método responsável por salvar localmente a imagem do QRCode.
     * O método vai receber a String da imagem de base64, e salvar ela em formato png
     * 
     * @param image imagem de base64 do QRCode
     * @return String do nome do arquivo da imagem salva localmente
     */
    public String saveImage(String image) {
        long timeMilis = System.currentTimeMillis();
        String fileName = "";
        String base64Image = image.split(",")[1];
        byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
        try {
            fileName = "image_" + timeMilis + "_.png";
            BufferedImage img = ImageIO.read(new ByteArrayInputStream(imageBytes));
            File outputfile = new File(fileName);
            ImageIO.write(img, "png", outputfile);
        } catch (Exception e) {
            System.out.println("Erro ao salvar imagem");
            e.printStackTrace();
            fileName = "";
        }
        return fileName;
    }

   /**
    * Método responsável por mostrar a imagem previamente salva do QRCode de base64
    * O método ao receber o nome do arquivo da imagem do QRCode, abrir a imagem.
    * 
    * @param fileName nome do arquivo a ser aberto.
    */ 
    @Deprecated
    public void showImage(String fileName) {
        try {
            File file = new File(fileName);
            Desktop desktop = Desktop.getDesktop();
            desktop.open(file);
        } catch (Exception e) {
            System.out.println("Erro ao abrir imagem");
            e.printStackTrace();
        }
    }

}
