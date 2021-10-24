<%@page import="modelos.Acesso"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Cadastre-se</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <link rel="stylesheet" href="styles/styles.css">
    </head>

    <body onload="validaStatus()" class="verificaCadastraClienteBody">

        <!-- adicionando imagens na página -->
        <div>       
            <img class="imagem-furao" src="imgPagina/furaozao.png"
                 style="float: right;
                 width: 700px;
                 position: fixed; 
                 right: 260px; 
                 top: 151px;">
        </div>
        <!--<div id="header">           
            <img class="imagem-nuvemright" src="imgPagina/balao.png">
        </div>-->
        <div>           
            <img class="imagem-nuvemleft" src="imgPagina/balaoleft.png" 
                 style="float: right;
                 width: 33%;
                 position: fixed; 
                 left: 20px; 
                 top: 50px;">
        </div>

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
                                    default:
                                            break;
                                    }

                                    String vstatus = request.getParameter("status");
            %>
        <input type="text" name="status" id="status" value="<%out.write(vstatus);%>" readonly="true" hidden>

        <!-- adicionando formulário de consulta -->
        <div>
            <div class="consulta" 
                 style="position: absolute; 
                 text-align: left;
                 left: 120px; 
                 top: 140px;
                 font-weight: bold;">
                <form  class="forms" action="receberDadosVenda.jsp" method="POST"> 
                    <div>
                        <label>Caso você já tenha cadastro, informe:</label></ br>
                    </div> 
                    <input type="text" class="rounded-pill" autocomplete="off" name="cpfconsulta" placeholder="Informe o CPF" maxlength="11" onkeypress="return onlyNumberKey(event)">
                    <input type="submit" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0" value="Consultar">
                </form>
            </div>

            <div class="container">


                <!-- classe formata pagina em 3 colunas horizontais -->
                <div class="row">
                    <!-- classe grid 1 de 3 -->
                    <div class="col">

                        <form  action="receberDadosCliente2.jsp"  method="POST">
                            <!--  campo para inserir nome -->
                            <div id="header">
                                <div class="textlogo"
                                     style="position: absolute; 
                                     right: 60px; 
                                     top: 120px;
                                     font-weight: bold;">
                                    <h4>Se você não tem cadastro, não perca <br /> &nbsp;&nbsp;&nbsp;seu tempo, faça agora mesmo!!!</h4>
                                </div>
                                <div id="header">
                                    <div class="cadastro" 
                                         style="position: absolute; 
                                         text-align: left;
                                         right: 30px; 
                                         top: 285px;
                                         font-weight: bold;">                
                                        <div class="form-group">
                                            <label for="nome">Nome</label>
                                            <input type="text" autocomplete="off" name="nome" id="nomeCliente" class="form-control rounded-pill" required placeholder="Informe o seu nome">
                                        </div>
                                        <!--  campo para inserir cpf -->
                                        <div class="form-group">
                                            <label for="cpfCliente">CPF</label>
                                            <input type="text" autocomplete="off" name="cpfCliente" id="cpfCliente" class="form-control rounded-pill" maxlength="11" onkeypress="return onlyNumberKey(event)" required placeholder="Informe o seu cpf">
                                        </div>   
                                        <button name="botaoEnviar" id="botaoEnviar" type="submit"  class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0">Cadastrar Cliente</button>
                                    </div>

                                    <!-- script para validar o campo nome , permitindo apenas caracteres normais e acentuacao -->

                                    <script>
                                        $('input[name=nome]').on('input', function () {
                                            $(this).val($(this).val().replace(/[^a-zA-ZÃ¡-Ã¹Ã€-Ãš_ ]/gi, ''));
                                        });
                                    </script>

                                    <!-- script que verifica o tamanho dos campos e apenas habilita o botao enviar -->

                                    <script>
                                        function onlyNumberKey(evt) {

                                            // Only ASCII character in that range allowed
                                            var ASCIICode = (evt.which) ? evt.which : evt.keyCode
                                            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                                                return false;
                                            return true;
                                        }
                                    </script>
                                    </form>
                                </div>
                            </div>
                    </div>     

                    <script>
                        //FUNÃ‡ÃƒO PARA VALIDACAO ADICIONAL DE CAMPOS DE CADASTRO E FAZER SUBMIT
                        $(document).ready(function () {
                            // desativa o botao submit do form 
                            $(':input[name=botaoEnviar]').prop('disabled', true);
                            // toda vez que apertar alguma tecla, dentro de um tipo texto
                            $('input[type="text"]').keyup(function () {
                                //verifica tamanho do campoNome e campoCpf 
                                var campoNome = $('input[name=nome]').val().length;
                                var campoCpf = $('input[name=cpfCliente]').val().length;
                                if ((campoNome !== 0 && campoCpf === 11)) {
                                    // desabilita (continua desabilitado) 
                                    $(':input[name=botaoEnviar]').prop('disabled', false);
                                } else {
                                    // habilita 
                                    $(':input[name=botaoEnviar]').prop('disabled', true);
                                }
                            });

                            $('#txtInput').on("cut copy paste", function (e) {
                                e.preventDefault();
                            });
                        });

                        function validaStatus() {
                            var status = $('input[name=status]').val();
                            switch (status) {
                                case "1":
                                    alert("Cliente não cadastrado! \n Favor realizar cadastro");
                                    nome[0].focus();
                                    break;
                                case "2":
                                    alert("Ocorreu um problema ao realizar o cadastro \n entre em contato com administração local!");
                                    break;
                                case "3":
                                    alert("Pedido cancelado com sucesso!");
                                    break;
                                case "4":
                                    alert("Ocorreu um problema ao realizar o cancelamento \n entre em contato com administração local!");
                                    break;
                                case "5":
                                    alert("Este CPF ja possui cadastro em nosso sistema! \n Por favor informar ele no campo de consulta CPF!");
                                    break;
                                case "6":
                                    alert("Nenhum item foi selecionado para compra!");
                                    break; 
                                default:

                                    break;
                            }
                        }

                    </script>


                    <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
                    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                    </body>
                    </html>
