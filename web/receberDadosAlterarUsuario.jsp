<%@page import="modelos.Acesso"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>

    <body>
        <%

            String usuario1 = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario1);
            tipo = ac.getTipoUsuario();
            if (usuario1 == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoalterarusuario() == true) {

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

                                    //recebe os valores da tela HTML
                                    String usuario = request.getParameter("usuario");
                                    String senha = request.getParameter("senha");
                                    String situacao = request.getParameter("situacao");

                                    //instancia o usuario
                                    Usuario u = new Usuario();
                                    u.setUsuario(usuario);
                                    u.setSenhausuario(senha);
                                    if (situacao != null) {
                                        u.setSituacao(Boolean.parseBoolean(situacao));
                                    }
                                    // método para alterar usuario e volta para a página consultar usuario
                                    if (u.alterarUsuario()) {
                                        response.sendRedirect("consultarUsuario.jsp?pmsg=Ok");
                                    } else {
                                        response.sendRedirect("consultarUsuario.jsp?pmsg=Erro");
                                    }


            %>
    </body>
</html>
