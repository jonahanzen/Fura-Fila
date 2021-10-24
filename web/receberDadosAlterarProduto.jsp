<%@page import="modelos.Acesso"%>
<%@page import="modelos.Produto"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="modelos.Cliente" %>
<!DOCTYPE html>
<html lang="pt-BR">
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

                                        //recebe os valores da tela HTML 
                                        String idproduto = request.getParameter("idproduto");
                                        String descricaoproduto = request.getParameter("descricaoproduto");
                                        String marcaproduto = request.getParameter("marcaproduto");
                                        String valorproduto = request.getParameter("valorproduto");
                                        String situacao = request.getParameter("situacao");

                                        //instancia o produto
                                        Produto p = new Produto();
                                        p.setIdProduto(Integer.parseInt(idproduto));
                                        p.setDescricaoProduto(descricaoproduto);
                                        p.setMarcaProduto(marcaproduto);
                                        if (valorproduto != null) {
                                            p.setValorProduto(Float.parseFloat(valorproduto));
                                        }
                                        if (situacao != null) {
                                            p.setSituacaoProduto(Boolean.parseBoolean(situacao));
                                        }
                                        p.setSituacaoEstoque(true);
                                        if (idproduto != null) {
                                            p.alterarProduto();
                                            response.sendRedirect("consultarProduto.jsp?pmsg=Ok");
                                        } else {
                                            response.sendRedirect("consultarProduto.jsp?pmsg=Erro");
                                        }


            %>

    </body>
</html>