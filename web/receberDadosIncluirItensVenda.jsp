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
                                        boolean status = true;
                                        boolean temEstoque = true;
                                        Loja l = new Loja();
                                        List<Loja> vendas = l.consultarVendasPorIdVenda(Integer.parseInt(idvenda));
                                        for (Loja loja : vendas) {
                                            String cpf = loja.getIdCpf();
                                            int id = loja.getIdVenda();

                                            Produto produto = new Produto();
                                            List<Produto> produtos = produto.consultarTodosProdutosDisponiveis();
                                            Integer i = 0;
                                            int identidadeProduto = 0;
                                            int testeA = 0;
                                            int testeB = 0;
                                            int reserva = 0;
                                            int somaReservaQuantidadeDigitada = 0;
                                            int cont = 0;

                                            while ((temEstoque != false) && (cont < produtos.size())) {
                                                reserva = produtos.get(cont).getReservaProduto();
                                                identidadeProduto = produtos.get(cont).getIdProduto();
                                                testeA = Integer.parseInt((quantidadeProduto[cont]));
                                                testeB = produtos.get(cont).getQuantidadeProduto();
                                                somaReservaQuantidadeDigitada = (reserva + testeA);
                                                if (somaReservaQuantidadeDigitada > testeB) {
                                                    temEstoque = false;
                                                }
                                                if (somaReservaQuantidadeDigitada <= testeB) {
                                                    if (cont < produtos.size()) {
                                                        cont++;
                                                    }

                                                }

                                            }

                                            if (temEstoque == true) {
                                                while (i < produtos.size()) {
                                                    for (Produto p : produtos) {
                                                        float total = 0;
                                                        l.setIdVenda(id);
                                                        l.setIdCpf(cpf);
                                                        l.setIdProduto(p.getIdProduto());
                                                        l.setQuantidade(Integer.parseInt((quantidadeProduto[i])));
                                                        float valor = p.getValorProduto();
                                                        if ((Integer.parseInt((quantidadeProduto[i]))) != 0) {
                                                            if (l.incluirItensNoPedido()) {
                                                                p.alterarQuantidadeReserva(p.getIdProduto(), Integer.parseInt((quantidadeProduto[i])));
                                                            } else {
                                                                status = false;
                                                            }
                                                        }
                                                        i++;
                                                    }
                                                }

                                                if (status == true) {
                                                    response.sendRedirect("alterarPedido.jsp?id=" + idvenda);
                                                } else {
                                                    response.sendRedirect("alterarPedido.jsp?status=2");
                                                }

                                            } else {
                                                response.sendRedirect("incluirItensVenda.jsp?status=1&id=" + cpf + "&idproduto=" + identidadeProduto);
                                            }

                                        }

        %>

</html>
