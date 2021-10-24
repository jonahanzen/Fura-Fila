<%@page import="modelos.Produto"%>
<%@page import="modelos.Acesso"%>
<%@page import="modelos.Loja"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                    case "f": %><script src="scripts/navbarFuncionario.js"></script><%
                            break;
                        case "u": %><script src="scripts/navbarTotem.js"></script><%
                                                    break;
                                                default:
                                                    break;
                                            }

                                            String idvenda = request.getParameter("idvenda");
                                            String idproduto = request.getParameter("idproduto");
                                            Loja l = new Loja();

                                            Produto p = new Produto();
                                            l.setIdVenda(Integer.parseInt(idvenda));
                                            l.setIdProduto(Integer.parseInt(idproduto));
                                            if (idvenda != null) {
                                                p = p.consultarProduto(Integer.parseInt(idproduto));
                                                l = l.consultarItensDoPedido(Integer.parseInt(idvenda), Integer.parseInt(idproduto));
                                                int bkpReserva = p.getReservaProduto();
                                                int quantidadeReservada = l.getQuantidade();
                                                int quantidadeAtualizada = (bkpReserva - quantidadeReservada);
                                                p.reporQuantidadeReserva(Integer.parseInt(idproduto), quantidadeAtualizada);
                                                if (l.excluirItemPedido()) {
                                                    response.sendRedirect("alterarPedido.jsp?id=" + idvenda);
                                                } else {
                                                    response.sendRedirect("alterarPedido.jsp?id=" + idvenda);
                                                }
                                            }
            %>       
    </body>
</html>
