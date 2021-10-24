<%@page import="modelos.Loja"%>
<%@page import="modelos.Acesso"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Produto"%>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <title>Alterando Situação do Atendimento</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
            } else if (ac.isAcessoalterarvenda() == true) {

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
                              case "f": %><script src="scripts/navbarFuncionar        io.js"></script><%
                                          break;
                                      case "u": %><script src="scripts/navbarTotem.js"></script><%
                                              break;
                                          default:
                                              break;
                                      }

                                      String idvenda = request.getParameter("idVenda");
                                      Loja l = new Loja();

                                      Produto p = new Produto();

                                      if (idvenda != null) {
                                          if (l.alterarSituacaoAtendimento(Integer.parseInt(idvenda))) {
                                              response.sendRedirect("consultarGrid.jsp");
                                          } else {
                                              response.sendRedirect("consultarGrid.jsp");
                                          }
                                      }
            %>       
    </body>
</html>