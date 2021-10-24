<%@page import="modelos.Acesso"%>
<%@page import="modelos.Loja"%>
<%@page import="modelos.Produto"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body>


        <%
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoconsultarvenda() == true) {

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

                                        String idvenda = request.getParameter("idvenda");
                                        boolean validaPagamento;
                                        Loja loja = new Loja();

                                        if (idvenda == null) {
                                            response.sendRedirect("segundaVia.jsp?status=2");
                                        } else {
                                            List<Loja> informacaoVenda = loja.consultarVendasPorIdVenda(Integer.parseInt(idvenda));
                                            if (informacaoVenda.isEmpty()) {
                                                response.sendRedirect("segundaVia.jsp?status=1");
                                            }
                                            for (int z = 0; z < informacaoVenda.size(); z++) {
                                                validaPagamento = informacaoVenda.get(z).isSituacaovenda();
                                                if (validaPagamento == true) {

                                                    List<Loja> vendas = loja.consultaListaPedidoPorIdVenda(Integer.parseInt(idvenda));


            %>

        <div>
            <% for (int x = 0; x < informacaoVenda.size(); x++) {%>
            <label>Numero do Pedido:</label> <% out.write("" + idvenda);%> <br>
            <label>CPF do Cliente:</label> <% out.write("" + informacaoVenda.get(x).getIdCpf());%> <br>
            <label>Data:</label> <% out.write("" + informacaoVenda.get(x).getDataAtual());%> <br>
            <label>Total da Compra:  R$</label> <% out.write("" + informacaoVenda.get(x).getTotalVenda());%><br>
            <%}%>
        </div>

        <div>
            <table class="table table-striped table-bordered table-light table-hover">
                <thead class="thead-primary">
                <th>Descrição Produto</th>
                <th>Quantidade Unitario</th>
                <th>Valor Unitario</th>
                </thead>

                <tbody>
                    <tr>
                        <%

                            Produto p = new Produto();
                            int y = 0;
                            while (y < vendas.size()) {
                                p = p.consultarProduto(vendas.get(y).getIdProduto());
                        %>

                    <tr><td><%  out.write(p.getDescricaoProduto());%></td> 
                        <td><% out.write("" + vendas.get(y).getQuantidade());%></td>
                        <td><% out.write("R$ " + p.getValorProduto());%></td></tr> 
                <br> <%y++;%>          
                <%}%> 
                <%}
                        }
                    }

                %> 
                </tr>   
                </tbody>
            </table>
        </div>
        <div> 
            <label>Nós agradecemos pela sua escolha! <br>
                Retire o seu pedido no balcão!    <br>
                Tenha otimo filme! </label>       <br>
        </div>



        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
