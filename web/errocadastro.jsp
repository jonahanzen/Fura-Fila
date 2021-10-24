<%@page import="modelos.Acesso"%>
<%@page import="modelos.Loja"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Produto"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Erro Cadastro</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="shortcut icon" href="imagPagina/favicon.ico">
        <link rel="stylesheet" href="styles/styles.css">
    </head>

    <body id="errocadastro">

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
            %>

        <!-- adicionando imagens na página -->
        <div>
            <img class="imagem-Furaobad" src="imgPagina/furaozaobad.png" alt="hero-header"
                 style="float: right;
                 width: 700px;
                 position: fixed; 
                 right: 0px; 
                 top: 40px;">
        </div>

        <div>
            <div class="textErro" style="position: absolute;
                 color: rgb(255, 255, 255);
                 font-size: 65px; 
                 left: 365px; 
                 top: 65px;
                 font-weight: bold;
                 font-family:  'Brush Script MT', 'Lucida Handwriting', monospace;">
                <label>Oops...</label>
            </div>
            <div>
                <div class="textErroParagrafo" style="position: absolute;
                     color: rgb(255, 255, 255);
                     font-size: 27px; 
                     left: 350px; 
                     top: 150px;
                     font-weight: bold;
                     font-family:  'Brush Script MT', 'Lucida Handwriting', monospace;">
                    <label>Algo deu errado,   <br>                    
                        verificamos que existe problemas! <br>
                        Erro no cadastro: <br>
                        (CPF incorreto ou invalido)
                    </label>
                    <br>

                    <%
                        String idvenda = request.getParameter("idvenda");
                        Loja l = new Loja();
                        List<Loja> informacaoVenda = l.consultaListaPedidoPorIdVenda(Integer.parseInt(idvenda));
                        boolean temEstoque;
                        boolean itensDeletado;
                        boolean fimProcesso = false;
                        Produto p = new Produto();
                        int y = 0;
                        while (y < informacaoVenda.size()) {
                            int idProduto = informacaoVenda.get(y).getIdProduto();
                            int quantidadeDevolver = informacaoVenda.get(y).getQuantidade();
                            p = p.consultarProduto(idProduto);
                            temEstoque = p.isSituacaoEstoque();
                            if (temEstoque == true) {
                                p = p.consultarProduto(idProduto);
                                int bkpReserva = p.getReservaProduto();
                                int quantidadeAtualizada = (bkpReserva - quantidadeDevolver);
                                p.reporQuantidadeReserva(idProduto, quantidadeAtualizada);
                            } else {
                                p = p.consultarProduto(idProduto);
                                int bkpQuantidade = p.getBkpquantidade();
                                int bkpReserva = (bkpQuantidade - quantidadeDevolver);
                                p.setQuantidadeProduto(bkpQuantidade);
                                p.setReservaProduto(bkpReserva);
                                p.setSituacaoEstoque(true);
                                p.alterarSituacaoEstoque(idProduto);
                            }
                            y++;
                            fimProcesso = true;
                        }
                        if (fimProcesso == true) {
                            l = l.consultarPedidosPorIDVenda(Integer.parseInt(idvenda));
                            l.excluirTodosItensPedido(Integer.parseInt(idvenda));
                            itensDeletado = true;
                            if (itensDeletado == true) {
                                l = l.consultarPorIDVenda(Integer.parseInt(idvenda));
                                l.excluirVenda(Integer.parseInt(idvenda));
                            }
                        }


                    %>
                    <a href="verificaCadastraCliente.jsp?status=0" class="btn btn-primary">Voltar</a>
                </div>
            </div>
        </div>

        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    </body>
</html>