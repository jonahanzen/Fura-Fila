<%@page import="modelos.Acesso"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Produto"%>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <title>Alterar Quantidade Produto</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body onload="validaStatus()" style="max-width: 100%; overflow: hidden; background-color: #a1c2de">
        <%
            //verifica sessão
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoalterarproduto() == true) {

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
                                                String vstatus = request.getParameter("status");
                                                if (vstatus == null) {
                                                    vstatus = "0";
                                                }

            %>


        <%        List<Produto> produtos = new ArrayList();
            String idProduto = request.getParameter("idProduto");
            Produto prod = new Produto();
            if (idProduto == null) {
                response.sendRedirect("consultarProduto.jsp");
            } else {
                //Método de consulta passando cpf como argumento
                prod = prod.consultarProduto(Integer.parseInt(idProduto));
            }

        %>

        <!-- classe container para separar em grid -->
        <div class="container">
            <input type="text" name="status" id="status" value="<%out.write(vstatus);%>" readonly="true" hidden>

            <!-- classe formata pagina em 3 colunas horizontais -->
            <div class="row">
                <div class="col">
                </div>
                <!-- classe grid 1 de 3 -->
                <div class="col">
                    <form id="form" action="receberDadosAlterarQuantidadeProduto.jsp" method="POST">

                        <div class="form-check form-check-inline">
                            <label for="tipoOperacao">Tipo Operação</label>
                            <input class="form-check-input" type="radio" name="tipoOperacao" id="tipoOperacao" value="a" checked>
                            <label class="form-check-label" for="tipoOperacao">
                                Aumentar
                            </label>
                        </div>
                        <!-- final do campo do tipo radio em linha -->

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="tipoOperacao" id="tipoOperacao" value="d">
                            <label class="form-check-label" for="tipoOperacao">
                                Diminuir
                            </label>
                        </div>

                        <!--  campo para ler o id do produto  -->
                        <div class="form-group">
                            <label for="idproduto">Id Produto</label>
                            <input type="text" class="rounded-pill" name="idproduto" value="<% out.write("" + prod.getIdProduto());%>" readonly><br>
                        </div>
                        <!-- campo para alterar descrição do Produto -->
                        <div class="form-group">
                            <label for="descricaoProduto">Descrição</label>
                            <input type="text" name="descricaoproduto" id="descricaoproduto" class="form-control rounded-pill"
                                   maxlength="30" required readonly
                                   value="<% out.write(prod.getDescricaoProduto());%>">
                        </div>
                        <!-- campo para alterar marca do Produto -->
                        <div class="form-group">
                            <label for="marcaproduto">Marca</label>
                            <input type="text" name="marcaproduto" id="marcaproduto" class="form-control rounded-pill" maxlength="30"
                                   required readonly
                                   value="<% out.write(prod.getMarcaProduto());%>">
                        </div>

                        <!-- campo para alterar quantidade do produto -->
                        <div class="form-group">
                            <label for="quantidadeproduto">Quantidade</label>
                            <input type="text" name="consultarquantidadeproduto" id="consultarquantidadeproduto" class="form-control rounded-pill" onkeypress="return onlyNumberKey(event)" class="form-control"
                                   required maxlength="8" readonly
                                   value="<%out.write("" + prod.getQuantidadeProduto());%>">
                            <input type="text" name="quantidadeproduto" id="quantidadeproduto" class="rounded-pill" onkeypress="return onlyNumberKey(event)" class="form-control"
                                   required maxlength="8" placeholder="Alterar a quantidade do produto">
                        </div>

                        <div>
                            <button type="submit" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0">Alterar</button>
                            <br>

                            <a href="consultarProduto.jsp" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0" style="margin-top:5px;">Voltar</a>
                        </div>
                    </form>
                </div>
                <div class="col">
                </div>
            </div>
        </div>

        <script>
            //FUNÇÃO PARA VALIDACAO ADICIONAL DE CAMPOS DE CADASTRO E FAZER SUBMIT
            $(document).ready(function () {
                $('#txtInput').on("cut copy paste", function (e) {
                    e.preventDefault();
                });
            });


            function validaStatus() {
                var status = $('input[name=status]').val();
                switch (status) {
                    case "1":
                        alert("O Valor digitado é maior que quantidade atual \n Por Favor digite numero valido!");
                        break;
                    case "2":
                        alert("Ocorreu um problema ao realizar o cadastro \n entre em contato com administração local!");
                        break;
                    case "3":
                        alert("Alteração efetuada com sucesso!");
                        break;
                    case "4":
                        alert("Tipo de operação não selecionado! \n Por favor selecione um tipo de operação!");
                        break;
                    default:

                        break;
                }
                return;
            }


            function onlyNumberKey(evt) {
                // Only ASCII character in that range allowed
                var ASCIICode = (evt.which) ? evt.which : evt.keyCode
                if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                    return false;
                return true;
            }
        </script>   
        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    </body>
</html>