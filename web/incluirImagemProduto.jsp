<%@page import="modelos.Acesso"%>
<%@page import="java.util.List"%>
<%@page import="modelos.Produto"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Cadastrar Imagem do Produto</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <body onload="validaStatus()" style="max-width: 100%; overflow: hidden; background-color: #a1c2de">
        <!--  escolher a navbar a ser carregada da pasta de scripts -->

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

                                    String vstatus = request.getParameter("status");
                                    String descricaoproduto = request.getParameter("desc");
                                    Produto p = new Produto();
                                    List<Produto> produtos = p.consultarProdutoPelaDescricao(descricaoproduto);
                                    for (int i = 0; i < produtos.size(); i++) {
                                        int cod = produtos.get(i).getIdProduto();
            %>


        <form  method = "POST"
               enctype = "multipart/form-data">

            <label>Descrição do Produto:</label>
            <input type="text" name="descricaoproduto" id="descricaoproduto" value="<% out.write(descricaoproduto);%>" readonly="true">
            <label>Codigo do Produto:</label>
            <input type="text" name="cod" id="cod" value="<% out.write("" + cod);%>" readonly="true">
            <%}%>
            <label>Escolha a foto:</label>
            <input type = "file" name = "file" size = "50"  />

            <input type = "submit" value = "Upload File" onclick="teste()" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0"/>
        </form>
        <script>

            function validaStatus() {
                var status = $('input[name=status]').val();
                switch (status) {
                    case "1":
                        alert("Este cliente já possui cadastro!");
                        break;
                    case "2":
                        alert("Cliente cadastrado com sucesso!");
                        break;
                    case "3":
                        alert("Ocorreu um problema ao realizar o cadastro \n entre em contato com administração local!");
                        break;
                    default:

                        break;
                }
            }

            function teste() {
                var cod = $('input[name=cod]').val();
                url = "receberDadosImgProduto.jsp?cod=" + cod
                document.forms[1].action = url
                document.forms[1].submit();
            }


        </script>   

        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>