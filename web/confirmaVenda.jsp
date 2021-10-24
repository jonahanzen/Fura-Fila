<%@page import="modelos.Acesso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Confirma Venda</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body class="" style="max-width: 100%; background-color: #a1c2de">
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
            %>
        <div class="container w-100 h-100">


            <%
                String vstatus = request.getParameter("status");
                String idvenda = request.getParameter("id");
            %>


            <div class="row d-flex justify-content-center bg-danger">
                <h1 class="text-dark" style="font-family: Roboto, sans-serif; text-align: center; font-weight: bold">
                    ATENÇÃO! Siga as instruções para pagamento</h1>
            </div>
            <div class="row bg-warning">
                <div class="col align-middle d-flex justify-content-center">
                    <h1 class="text-dark " style="padding-top:8%;"> Primeiro Passo</h1>
                </div>
                <div class="col"></div>
                <div class="col">
                    <h1 style="font-family: Roboto, sans-serif; text-align: center; font-weight: bold">
                        Abra o aplicativo de sua preferência para pagar o QR Code
                    </h1>
                </div>
            </div>
            <div class="row" style="background-color: white">
                <div class="col align-middle d-flex justify-content-center">
                    <h1 class="text-dark " style="padding-top:30%;"> Segundo Passo</h1>
                </div>
                <div class="col">
                    <img style="max-height: 80%; max-width: 80%" class="img-responsive" src="imgPagina/qrcode.jpg" alt="alt"/>
                </div>
                <div class="col align-middle d-flex justify-content-center">
                    <h1 class="text-dark" style="font-family: Roboto, sans-serif;
                        padding-top: 10%; font-weight: bold">
                        Aponte a câmera do seu celular para o código que irá aparecer na tela
                    </h1>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col"></div>
                <div class="col">
                    <form id="form" action="gerarConta.jsp"  method="POST">
                        <button name="botaoEnviar" id="botaoEnviar" type="submit"  class="btn btn-primary" style="font-size:20px;">JÁ ESTOU COM O APLICATIVO ABERTO!</button>
                        <input name="id" class="id" type="text" value="<%out.write(idvenda);%>" readonly="true" hidden="true"/>

                </div>
                <div class="col"></div>
            </div>
        </div>



        <script>
            function validaStatus() {
                var status = $('input[name=status]').val();
                switch (status) {
                    case "1":
                        alert("Venda realizada com sucesso!");
                        break;
                    case "2":
                        alert("Ocorreu um problema ao realizar a venda \n entre em contato com administração local!");
                        break;
                    default:

                        break;
                }
                return;
            }

            function teste() {
                var url = "cancelarVenda.jsp"
                document.forms[0].action = url;
                document.forms[0].submit();
            }
        </script>


        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
