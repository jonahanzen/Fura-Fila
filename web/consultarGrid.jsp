<%@page import="modelos.Acesso"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="modelos.Loja"%>
<%@page import="modelos.Produto"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <title>Consultar Grid de Pedidos</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <meta http-equiv="refresh" content="5; url='consultarGrid.jsp'">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body style="max-width: 100%; overflow: hidden; background-color: #a1c2de">

        <%
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoconsultargrid() == true) {

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

                                        Loja loja = new Loja();
                                        List<Loja> disponivel = loja.consultarVendasTRUE();
                                        for (int z = 0; z < disponivel.size(); z++) {
                                            int id = disponivel.get(z).getIdVenda();
                                            loja.atualizaHoraAtual(id);
                                            Timestamp horaAtual = disponivel.get(z).getHoraatual();
                                            Timestamp horaConfirmacao = disponivel.get(z).getHoraconfirmacao();
                                            long t1 = horaAtual.getTime();
                                            if (horaAtual == null) {
                                                horaAtual = horaConfirmacao;
                                            }
                                            long t2 = horaConfirmacao.getTime();
                                            long primeiroAviso = t1 + 30000;
                                            long segundoAviso = primeiroAviso + 10000;

            %>
        <table class="table table-striped table-bordered table-light table-hover">
            <%                if (t1 > t2) {
                    out.write("<div style='background-color: red'>");
            %>

            <input type="text" name="status" id="status" readonly hidden/>
            <label><h3>Numero do Pedido:  <% out.write("   " + disponivel.get(z).getIdVenda());%></h3></label> 
            <thead class="thead-primary">            
            <th>Descrição Produto</th>
            <th>Quantidade Unitario</th>
            <th><%out.write("<a href=alterarSituacaoAtendimento.jsp?idVenda=" + disponivel.get(z).getIdVenda() + ">Pedido Atendido</a>");%></th> 
                <%} else if (segundoAviso > t2) {

                    out.write("<div style='background-color: yellow'>");
                %>

            <input type="text" name="status" id="status" readonly hidden/>
            <label><h3>Numero do Pedido:  <% out.write("   " + disponivel.get(z).getIdVenda());%></h3></label> 
            <thead class="thead-primary">            
            <th>Descrição Produto</th>
            <th>Quantidade Unitario</th> 
            <th><%out.write("<a href=alterarSituacaoAtendimento.jsp?idVenda=" + disponivel.get(z).getIdVenda() + ">Pedido Atendido</a>");%></th> 
                <%} else {

                    out.write("<div style='background-color: #a1c2de'>");
                %>

            <input type="text" name="status" id="status" readonly hidden/>
            <label><h3>Numero do Pedido:  <% out.write("   " + disponivel.get(z).getIdVenda());%></h3></label> 
            <thead class="thead-primary">            
            <th>Descrição Produto</th>
            <th>Quantidade Unitario</th> 
            <th><%out.write("<a href=alterarSituacaoAtendimento.jsp?idVenda=" + disponivel.get(z).getIdVenda() + ">Pedido Atendido</a>");%></th> 
                <%}%>
        </thead>

        <%
            List<Loja> vendas = loja.consultaListaPedidoPorIdVenda(id);
        %>

        <div>
            <% for (int x = 0; x < vendas.size(); x++) {%>



            <tbody>

                <%
                    Produto p = new Produto();
                    p = p.consultarProduto(vendas.get(x).getIdProduto());
                %>
                <tr><td><%  out.write(p.getDescricaoProduto());%></td> 
                    <td><% out.write("" + vendas.get(x).getQuantidade());%></td></tr>

                <%}%>  
                <%}%>


            </tbody>
    </table>
</div>



<!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
