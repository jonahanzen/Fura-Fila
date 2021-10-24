<%@page import="modelos.Acesso"%>
<%@page import="modelos.Cliente"%>
<%@page import="modelos.Loja"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Produto"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- esse head/html esta editado para utilizar o bootstrap 4.3.x
        ele tambem ajusta automaticamente em caso da tela ser menor ou mobile -->
        <title></title>
        <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="styles.css">
    </head>


    <body onload="validaStatus()" style="max-width: 100%; background-color: #a1c2de">

        <!--  escolher a navbar a ser carregada da pasta de scripts -->

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

                                        String vstatus = request.getParameter("status");
                                        if (vstatus == null) {
                                            vstatus = "0";
                                        }
                                        String idproduto = request.getParameter("idproduto");
                                        if (idproduto == null) {
                                            idproduto = "nada";
                                        }

            %>
        <input type="text" name="status" id="status2" value="<%out.write(vstatus);%>" readonly="true" hidden>
        <input type="text" name="status2" id="status2" value="<%out.write(idproduto);%>" readonly="true" hidden>
        <form id="form" action="receberDadosIncluirItensVenda.jsp"  method="POST">
            <%
                String cpf = request.getParameter("id");
                Loja l = new Loja();
                List<Loja> vendas = l.consultarVendaLista(cpf);

                float totalVenda = 0;
                Cliente c = new Cliente();
                c = c.consultarCliente(cpf);

                Produto produto = new Produto();

                List<Produto> produtos = produto.consultarTodosProdutosDisponiveis();
                String srcImagem;
            %> 

            <div>
                <label>Ola <%out.write(c.getNome());%></label> <br>
                <input type="text" name="cpfcliente" id="cpfcliente" value="<%out.write(cpf);%>" readonly=true >
                <%for (Loja loja : vendas) {
                        int idvenda = loja.getIdVenda();
                        String id = Integer.toString(idvenda);
                        session.setAttribute("idvenda", id);
                %>
                <label>Numero do Pedido:</label>
                <input type="text" name="idvenda" id="idvenda" value="<% out.write("" + loja.getIdVenda());%>" readonly=true>

            </div>

            <table class="table table-striped table-bordered table-light table-hover">
                <thead class="thead-primary">
                <th>Codigo Produto</th>
                <th>Foto</th>
                <th>Descrição</th>
                <th>Quantidade</th>
                <th>Preço</th>
                </thead>

                <tbody>

                    <%
                        Integer i = 0;
                        while (i < produtos.size()) {  //enquanto houver prox elemento
                            for (Produto p : produtos) {
                                int teste = 0;
                                srcImagem = "imagens/produto_" + produtos.get(i).getIdProduto() + ".png";%>

                    <tr>
                        <!-- caso for um dado numerico, utilizar duas aspas duplas 
                        ex: out.write("" + dado); -->

                        <td><% out.write("" + produtos.get(i).getIdProduto());%></td>
                <input type="text" name="idProduto" id="idProduto" value="<% out.write("" + produtos.get(i).getIdProduto());%>" readonly=true hidden="true">
                <input type="text" name="verificaEstoque" id="verificaEstoque" value="<% out.write("" + produtos.get(i).getQuantidadeProduto());%>" readonly=true hidden="true">
                <td><img src="<%=srcImagem%>" style="height:160px"></td>
                <td><% out.write(produtos.get(i).getDescricaoProduto());%></td>
                <input type="text" name="descricaoproduto" id="descricaoproduto" value="<% out.write(produtos.get(i).getDescricaoProduto());%>" readonly=true hidden="true">
                <td><input type="text" name="quantidadeproduto"   id="quantidadeproduto" value="<%out.write("" + teste);%>" onkeypress="return onlyNumberKey(event)" 
                           class="form-control"></td>
                <td><% out.write("R$" + p.getValorProduto());%></td>
                <input type="text" name="valorProduto" id="valorProduto" value="<% out.write("" + produtos.get(i).getValorProduto());%>" readonly=true hidden="true">

                </tr> 



                <!-- caso um for seja utilizado ali em cima para percorrer os dados na tabela
                tirar o comentario abaixo que fecha o for -->
                <!-- final do conteudo de cada elemento -->
                <% i++; %>
                <%}%>  <!-- final do for-loop -->
                <%}%>  <!-- final do while-loop -->
                <%}%>

                </tbody>
            </table>
            <div class="text-center">
                <button name="botaoComprar" id="botaoComprar" type="submit"  class="btn btn-primary btn-lg btn-block rounded-pill btn-outline-light" >Comprar</button>
            </div>
        </form>
        <script>


            $(document).ready(function () {
                $('#txtInput').on("cut copy paste", function (e) {
                    e.preventDefault();
                });
            });


            function onlyNumberKey(evt) {
                // Only ASCII character in that range allowed
                var ASCIICode = (evt.which) ? evt.which : evt.keyCode
                if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                    return false;
                return true;
            }

            function validaStatus() {
                var status = $('input[name=status]').val();
                var status2 = $('input[name=status2]').val();
                switch (status) {
                    case "1":
                        alert("O produto com codigo: " + status2 + " não tem estoque suficiente! \n Por favor alterar valor da quantidade!");
                        break;
                    case "2":
                        alert("Usuario cadastrado com sucesso!");
                        break;
                    case "3":
                        alert("Ocorreu um problema ao realizar o cadastro \n entre em contato com administração local!");
                        break;
                    case "0":
                        break;
                    default:

                        break;
                }
            }



            function teste() {
                var url = "cancelarVenda.jsp"
                document.forms[0].action = url;
                document.forms[0].submit();
            }

        </script>


        <!-- area de scripts a serem carregados, DEVE ser nesta sequencia: jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
