<%@page import="modelos.Acesso"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.File"%>
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
            } else if (ac.isAcessoincluirproduto() == true) {

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
                                    String descricaoproduto = request.getParameter("descricaoproduto");
                                    String marcaproduto = request.getParameter("marcaproduto");
                                    String quantidadeproduto = request.getParameter("quantidadeproduto");
                                    String valorproduto = request.getParameter("valorproduto");

                                    //instancia o produto
                                    Produto p = new Produto();
                                    p.setDescricaoProduto(descricaoproduto);
                                    p.setMarcaProduto(marcaproduto);
                                    if (quantidadeproduto != null) {
                                        p.setQuantidadeProduto(Integer.parseInt(quantidadeproduto));
                                    }
                                    if (valorproduto != null) {
                                        p.setValorProduto(Float.parseFloat(valorproduto));
                                    }
                                    p.setSituacaoProduto(true);
                                    p.setSituacaoEstoque(true);
                                    p.setBkpquantidade(Integer.parseInt(quantidadeproduto));

                                    if (p.incluirProduto()) {
                                        response.sendRedirect("incluirImagemProduto.jsp?desc=" + descricaoproduto);
                                    } else {
                                        response.sendRedirect("incluirProduto.jsp?status=2");
                                    }


            %>

    </body>
</html>