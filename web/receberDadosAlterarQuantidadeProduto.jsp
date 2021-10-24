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
                            String tipoOperacao = request.getParameter("tipoOperacao");
                            String quantidadeProduto = request.getParameter("quantidadeproduto");
                            int quantidadeAtual = 0;

                            Produto p = new Produto();
                            p = p.consultarQuantidadeAtualProduto(Integer.parseInt(idproduto));
                            quantidadeAtual = p.getQuantidadeProduto();
                            if (tipoOperacao == null) {
                                response.sendRedirect("alterarQuantidadeProduto.jsp?status=1&&idProduto=" + idproduto);
                            } else {
                                if (quantidadeProduto != null) {
                                    switch (tipoOperacao) {
                                        case "a":
                                            p = p.consultarQuantidadeAtualProduto(Integer.parseInt(idproduto));
                                            quantidadeAtual = p.getQuantidadeProduto();
                                            if (quantidadeAtual == 0) {
                                                p.setSituacaoEstoque(true);
                                                p.alterarSomenteSituacaoEstoque(Integer.parseInt(idproduto));
                                                if (p.aumentarQuantidadeProduto(Integer.parseInt(idproduto), Integer.parseInt(quantidadeProduto))) {
                                                    response.sendRedirect("consultarProduto.jsp?pmsg=Ok");
                                                } else {
                                                    response.sendRedirect("consultarProduto.jsp?pmsg=Erro");
                                                }
                                            } else if (p.aumentarQuantidadeProduto(Integer.parseInt(idproduto), Integer.parseInt(quantidadeProduto))) {
                                                response.sendRedirect("consultarProduto.jsp?pmsg=Ok");
                                            } else {
                                                response.sendRedirect("consultarProduto.jsp?pmsg=Erro");
                                            }
                                            break;
                                        case "d":

                                            if (Integer.parseInt(quantidadeProduto) > quantidadeAtual) {
                                                response.sendRedirect("alterarQuantidadeProduto.jsp?status=1&&idProduto=" + idproduto);
                                            } else {
                                                p.diminuirQuantidadeProduto(Integer.parseInt(idproduto), Integer.parseInt(quantidadeProduto));
                                                p = p.consultarQuantidadeAtualProduto(Integer.parseInt(idproduto));
                                                quantidadeAtual = p.getQuantidadeProduto();
                                                if (quantidadeAtual == 0) {
                                                    p.setSituacaoEstoque(false);
                                                    p.alterarSomenteSituacaoEstoque(Integer.parseInt(idproduto));
                                                    response.sendRedirect("consultarProduto.jsp?status=3");
                                                }
                                            }
                                            break;
                                        default:
                                            break;
                                    }
                                }
                            }
            %>

    </body>
</html>