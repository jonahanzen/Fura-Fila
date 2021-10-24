<%@page import="modelos.Acesso"%>
<%@page import="modelos.Produto"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Loja"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <%
        String usuario = (String) session.getAttribute("usuario");
        String tipo = null;
        //verifica sessão 
        Acesso ac = new Acesso();
        ac = ac.consultarPermissoes(usuario);
        tipo = ac.getTipoUsuario();
        if (usuario == null) {
            response.sendRedirect("index.html?msg=UsuarioNaoLogado");
        } else if (ac.isAcessorealizarvenda() == true) {

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
                                    String quantidadeProduto[] = request.getParameterValues("quantidadeproduto");
                                    boolean status = false;
                                    boolean temEstoque = true;
                                    int quantidadeNoPedido = 0;
                                    int x = 0;
                                    int iProduto = 0;
                                    int testeA = 0;
                                    int testeB = 0;
                                    int reserva = 0;
                                    int somaReservaQuantidadeDigitada = 0;
                                    float totalVendas = 0;
                                    Loja l = new Loja();
                                    List<Loja> vendas = l.consultaListaPedidoPorIdVenda(Integer.parseInt(idvenda));
                                    Produto p = new Produto();
                                    float totalVenda = 0;

                                    while ((temEstoque != false) && (x < vendas.size())) {
                                        iProduto = vendas.get(x).getIdProduto();
                                        p = p.consultarProduto(iProduto);
                                        reserva = p.getReservaProduto();
                                        testeA = Integer.parseInt((quantidadeProduto[x]));
                                        testeB = p.getQuantidadeProduto();
                                        somaReservaQuantidadeDigitada = (reserva + testeA);
                                        if (somaReservaQuantidadeDigitada > testeB) {
                                            temEstoque = false;
                                        }
                                        if (somaReservaQuantidadeDigitada <= testeB) {
                                            if (x < vendas.size()) {
                                                x++;
                                            }

                                        }

                                    }

                                    if (temEstoque == true) {
                                        for (int i = 0; i < vendas.size(); i++) {
                                            String cpf = vendas.get(i).getIdCpf();
                                            int quantidade = Integer.parseInt(quantidadeProduto[i]);
                                            int id = vendas.get(i).getIdVenda();
                                            l.setIdVenda(id);
                                            int idproduto = vendas.get(i).getIdProduto();
                                            p = p.consultarProduto(idproduto);
                                            if (quantidadeProduto[i] != null) {
                                                l.setQuantidade(Integer.parseInt(quantidadeProduto[i]));
                                            }
                                            float valor = p.getValorProduto();
                                            if (l.alterarQuantidadeItensNoPedido()) {
                                                float total = 0;
                                                total += quantidade * valor;
                                                totalVenda += total;
                                                l.setIdVenda(id);
                                                l.setTotalVenda(totalVenda);
                                                if (totalVenda != 0) {
                                                    l.atualizarValorTotal();
                                                    status = true;

                                                }
                                            }
                                            Produto prod = new Produto();
                                            prod = prod.consultarProduto(idproduto);
                                            quantidadeNoPedido = vendas.get(i).getQuantidade();
                                            int quantidadeDigitadaAtual = Integer.parseInt(quantidadeProduto[i]);
                                            if (quantidadeDigitadaAtual == quantidadeNoPedido) {

                                            } else {
                                                prod.alterarQuantidadeReserva(idproduto, Integer.parseInt((quantidadeProduto[i])));
                                            }
                                            if (prod.verificarAlterarListaVenda(idproduto) == true) {
                                                prod.setQuantidadeProduto(0);
                                                prod.setReservaProduto(0);
                                                prod.setSituacaoEstoque(false);
                                                if (prod.alterarSituacaoEstoque(idproduto)) {

                                                }
                                            }
                                        }

                                        if (status == true) {
                                            response.sendRedirect("confirmaVenda.jsp?status=1&id=" + idvenda);
                                        } else {
                                            l.excluirVenda(Integer.parseInt(idvenda));
                                            response.sendRedirect("verificaCadastraCliente.jsp?status=6");
                                        }
                                    } else {
                                        response.sendRedirect("alterarPedido.jsp?status=1&id=" + idvenda + "&idproduto=" + iProduto);
                                    }

        %>
</html>
