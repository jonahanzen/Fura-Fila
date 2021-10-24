<%@page import="modelos.Acesso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                                    String tipoUsuario = request.getParameter("tipoUsuario");
                                    String acessoincluircliente = request.getParameter("acessoincluircliente");
                                    String acessoalterarcliente = request.getParameter("acessoalterarcliente");
                                    String acessoconsultarcliente = request.getParameter("acessoconsultarcliente");
                                    String acessoexcluircliente = request.getParameter("acessoexcluircliente");

                                    String acessoincluirusuario = request.getParameter("acessoincluirusuario");
                                    String acessoalterarusuario = request.getParameter("acessoalterarusuario");
                                    String acessoconsultarusuario = request.getParameter("acessoconsultarusuario");

                                    String acessoincluirproduto = request.getParameter("acessoincluirproduto");
                                    String acessoalterarproduto = request.getParameter("acessoalterarproduto");
                                    String acessoconsultarproduto = request.getParameter("acessoconsultarproduto");

                                    String acessorealizarvenda = request.getParameter("acessorealizarvenda");
                                    String acessocancelarvenda = request.getParameter("acessocancelarvenda");
                                    String acessoalterarvenda = request.getParameter("acessoalterarvenda");

                                    String acessoalterarsenha = request.getParameter("acessoalterarsenha");

                                    String acessomenuprincipal = request.getParameter("acessomenuprincipal");

                                    //instancia o acesso
                                    Acesso acesso = new Acesso();
                                    acesso.setUsuario(usuario);
                                    acesso.setTipoUsuario(tipoUsuario);
                                    if (acessoincluircliente != null) {
                                        acesso.setAcessoincluircliente(Boolean.parseBoolean(acessoincluircliente));
                                    }
                                    if (acessoalterarcliente != null) {
                                        acesso.setAcessoalterarcliente(Boolean.parseBoolean(acessoalterarcliente));
                                    }
                                    if (acessoconsultarcliente != null) {
                                        acesso.setAcessoconsultarcliente(Boolean.parseBoolean(acessoconsultarcliente));
                                    }
                                    if (acessoexcluircliente != null) {
                                        acesso.setAcessoexcluircliente(Boolean.parseBoolean(acessoexcluircliente));
                                    }
                                    if (acessoincluirusuario != null) {
                                        acesso.setAcessoincluirusuario(Boolean.parseBoolean(acessoincluirusuario));
                                    }
                                    if (acessoalterarusuario != null) {
                                        acesso.setAcessoalterarusuario(Boolean.parseBoolean(acessoalterarusuario));
                                    }
                                    if (acessoconsultarusuario != null) {
                                        acesso.setAcessoconsultarusuario(Boolean.parseBoolean(acessoconsultarusuario));
                                    }
                                    if (acessoincluirproduto != null) {
                                        acesso.setAcessoincluirproduto(Boolean.parseBoolean(acessoincluirproduto));
                                    }
                                    if (acessoalterarproduto != null) {
                                        acesso.setAcessoalterarproduto(Boolean.parseBoolean(acessoalterarproduto));
                                    }
                                    if (acessoconsultarproduto != null) {
                                        acesso.setAcessoconsultarproduto(Boolean.parseBoolean(acessoconsultarproduto));
                                    }
                                    if (acessorealizarvenda != null) {
                                        acesso.setAcessorealizarvenda(Boolean.parseBoolean(acessorealizarvenda));
                                    }
                                    if (acessocancelarvenda != null) {
                                        acesso.setAcessocancelarvenda(Boolean.parseBoolean(acessocancelarvenda));
                                    }
                                    if (acessoalterarvenda != null) {
                                        acesso.setAcessoalterarvenda(Boolean.parseBoolean(acessoalterarvenda));
                                    }
                                    if (acessoalterarsenha != null) {
                                        acesso.setAcessoalterarsenha(Boolean.parseBoolean(acessoalterarsenha));
                                    }
                                    if (acessomenuprincipal != null) {
                                        acesso.setAcessomenuprincipal(Boolean.parseBoolean(acessomenuprincipal));
                                    }
                                    if (usuario != null) {
                                        acesso.alterarAcesso();
                                        response.sendRedirect("consultarUsuario.jsp?pmsg=Ok");
                                    } else {
                                        response.sendRedirect("consultarUsuario.jsp?pmsg=Erro");
                                    }


            %>

    </body>
</html>
