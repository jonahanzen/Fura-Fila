<%@page import="modelos.Acesso"%>
<%@page import="metodopix.Autenticar"%>
<%@page import="metodopix.CriarCobranca"%>
<%@page import="metodopix.QRCode"%>
<%@page import="org.json.JSONObject"%>
<%@page import="metodopix.Status"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <meta http-equiv="refresh" content="100; url='index.html'">
        <title>Consultando Pagamento</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
    </head>

    <%        //<meta http-equiv="Refresh" content="3"> <!-- 3 seconds -->

        String usuario = (String) session.getAttribute("usuario");
        String tipo = null;
        //verifica sessão 
        Acesso ac = new Acesso();
        ac = ac.consultarPermissoes(usuario);
        tipo = ac.getTipoUsuario();
        if (usuario == null) {
            response.sendRedirect("index.html?msg=UsuarioNaoLogado");
        } else if (ac.isAcessorealizarvenda() == true) {

        } else {
            if (tipo == "u") {
                response.sendRedirect("verificaCadastraCliente.jsp?status=0");
            } else {
                response.sendRedirect("menuPrincipal.jsp?status=1");
            }
        }

        switch (tipo) {
            case "a": %><script src="scripts/navbarGerente.js"></script><%
                    break;
                case "f": %><script src="scripts/navbarFuncionario.js"></script><%
                                            break;
                                        case "u": %><script src="scripts/navbarTotem.js"></script><%
                                                break;
                                            default:
                                                break;
                                        }

                                        String id = request.getParameter("id");

                                        //AUTENTICA
                                        Autenticar authProd = new Autenticar();
                                        String access_token;

                                        //CRIA COBRANÇA
                                        CriarCobranca cobranca = new CriarCobranca();
                                        String resultCob = "";
                                        int idCob = 0;

                                        //CRIA QR CODE
                                        QRCode location = new QRCode();   //QRCode é criado a partir de um location
                                        String resultLoc;
                                        String qrCode = "";
                                        String image = "";
                                        String imageName;

                                        //----------------------------------------------------
                                        //Autenticar
                                        access_token = authProd.geraToken();
                                        System.out.println("access_token = " + access_token);

                                        //Pega os dados da pagina de cobranca para consulta
                                        Integer idCobranca = Integer.parseInt(request.getParameter("idCob"));
                                        String txidCobranca = request.getParameter("txidCob");
                                        System.out.println(txidCobranca);
                                        System.out.println(idCobranca);

                                        //----------------------------------------------------
                                        //Emitir QRCode a partir de um location
                                        resultLoc = location.genQrCode(idCobranca, access_token);
                                        image = location.getImage(resultLoc);
                                        //System.out.println(resultLoc + "  resultloc");
                                        qrCode = location.getQrCode(resultLoc);
                                        //System.out.println("qrCode = " + qrCode);

                                        Status statusCobranca = new Status();
                                        String responseCob = statusCobranca.getStatus(txidCobranca, access_token);
                                        JSONObject statusCobResponse = new JSONObject(responseCob);
                                        String statusCob = (String) statusCobResponse.getString("status");
                                        System.out.println("O status e:" + statusCob);

        %>


    <!-- conteudo alinhado em linhas e colunas (3 linhas)
    a imagem deve aparecer na segunda linha
    
    -->

    <body style="max-width: 100%; overflow: hidden; background-color: #a1c2de">
        <div class="container">
            <div class="row">
                <div class="col">
                </div>
                <div class="col">
                    <h1>Pagina para o QR Code Pix</h1>
                </div>
                <div class="col">
                </div>
            </div>
            <div class="row">
                <div class="col">
                </div>
                <div class="col">
                    <img class="w-100 h-100" src="<%=image%>" alt="Red dot" />
                </div>
                <div class="col">
                </div>
            </div>
            <div class="row">
                <div class="col">
                </div>
                <div id="statusCob" class="col">

                    <%
                        if (statusCob.contains("CONCLUIDA")) {
                            out.write("<h4 id='sucesso' class='btn btn-success w-100'>"
                                    + statusCob + "</h4>");
                        } else if (statusCob.contains("ATIVA")) {
                            out.write("<h4 id='pendente' class='btn btn-warning w-100'>"
                                    + statusCob + "</h4>");
                        };
                    %>

                    <script>
                        //atualizar div do status a cada 2 segundos
                        window.addEventListener("load", function (event) {
                            $('meta[http-equiv=refresh]')
                                    .attr('content', '40; url="errotimeout.jsp?idvenda=<%=id%>"');
                            var statusCob = document.getElementById('statusCob');
                            setInterval(function () {
                                $("#statusCob").load(window.location.href + " #statusCob");
                                if (document.getElementById("sucesso").innerHTML === "CONCLUIDA") {
                                    $('meta[http-equiv=refresh]')
                                            .attr('content', '0; url="comprovanteVenda.jsp?idvenda=<%=id%>"');
                                }
                            }, 2000);
                        });
                    </script>


                </div>
                <div class="col">
                </div>
            </div>
        </div>


        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


    </body>
</html>


