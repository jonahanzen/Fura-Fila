<%@page import="modelos.Acesso"%>
<%@page import="modelos.Loja"%>
<%@page import="modelos.Produto"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <!-- head formatado para ser responsivo conforme o tamanho do dispositivo/tela, incluindo celulares -->
    <head>
        <title>Consultar Venda</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
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

                                        // COMANDOS JAVA PARA MONTAR A TABELA DE CONSULTA AQUI
                                        Loja loja = new Loja();
                                        List<Loja> vendas = loja.consultarVendaLista();

                                        //FINAL DOS COMANDOS PARA MONTAR A TABELA DE CONSULTA 
            %>


        <table class="table table-striped table-bordered table-light table-hover">
            <thead class="thead-primary">
            <th>ID Venda</th>
            <th>CPF Cliente</th>
        </thead>

        <tbody>
            <% for (Loja l : vendas) {%>
            <tr>
                <!-- caso for um dado numerico, utilizar duas aspas duplas 
                ex: out.write("" + dado); -->
                <td><% out.write("" + l.getIdVenda());%></td>
                <td><% out.write("" + l.getIdCpf());%></td>






            </tr> 



            <!-- caso um for seja utilizado ali em cima para percorrer os dados na tabela
            tirar o comentario abaixo que fecha o for -->
            <%}%>
        </tbody>
    </table>




    <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
