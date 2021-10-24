<%@page import="modelos.Acesso"%>
<%@page import="org.json.JSONObject"%>
<%@page import="modelos.Cliente"%>
<%@page import="modelos.Loja"%>
<%@page import="metodopix.QRCode"%>
<%@page import="metodopix.CriarCobranca"%>
<%@page import="metodopix.Autenticar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- esse head/html esta editado para utilizar o bootstrap 4.3.x
        ele tambem ajusta automaticamente em caso da tela ser menor ou mobile -->
        <title>Gerar Conta</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="styles.css">
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
    </head>
    <body style="background-color: #a1c2de">

        <%

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
                response.sendRedirect("menuPrincipal.jsp?status=1");
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

                                    String idvenda = request.getParameter("id");

                                    //AUTENTICA
                                    Autenticar authProd = new Autenticar();
                                    String access_token;

                                    Loja l = new Loja();
                                    l = l.dadosGeraConta(Integer.parseInt(idvenda));
                                    String cpfCliente = l.getIdCpf();
                                    Cliente c = new Cliente();
                                    c = c.consultarCliente(cpfCliente);
                                    String nomeCliente = c.getNome();
                                    float valor = l.getTotalVenda();

                                    //CRIA COBRANÇA
                                    CriarCobranca cobranca = new CriarCobranca();
                                    String resultCob = "";
                                    Integer idCob = 0;

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

                                    //----------------------------------------------------
                                    //Criar uma cobrança autenticada
                                    resultCob = cobranca.doCob(access_token, cpfCliente, nomeCliente, valor);

                                    //Pega id cobranca
                                    idCob = cobranca.getIdCob(resultCob);
                                    if (idCob == 0) {
                                        response.sendRedirect("errocadastro.jsp?idvenda=" + idvenda);
                                    } else {
                                        System.out.println("idCobranca = " + idCob);
                                        //Pega txid cobranca
                                        JSONObject cobCriada = new JSONObject(resultCob);
                                        String txidCob = (String) cobCriada.getString("txid");

                                        //idcob nao igual a zero,  txid nao nulo
                                        if ((!idCob.equals(0)) && (txidCob != null)) {
                                            response.sendRedirect("gerarConsulta.jsp?idCob=" + idCob + "&txidCob=" + txidCob + "&id=" + idvenda);
                                        }
                                        if ((idCob.equals(0)) && (txidCob == null)) {
                                            // mandar para pagina de erro
                                            response.sendRedirect("errocadastro.jsp?idvenda=" + idvenda);
                                        }
                                    }

            %>





        <!-- area de scripts a serem carregados, DEVE ser nesta sequencia: jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
