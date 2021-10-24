<%@page import="modelos.Acesso"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Alterar Senha</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body style="max-width: 100%; overflow: hidden; background-color: #a1c2de">

        <%
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoalterarsenha() == true) {

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

                                            List<Usuario> usuarios = new ArrayList();

                                            Usuario user = new Usuario();
                                            if (usuario == null) {

                                            } else {
                                                //Método de consulta passando cpf como argumento
                                                usuarios = user.consultarUsuarioLista2(usuario);
                                            }

            %>
        <!-- vai mandar os dados para recebeeditacliente.jsp -->
        <form action="receberDadosAlterarSenha.jsp" method="POST">
            <% for (Usuario u : usuarios) {%>

            <!-- classe container para separar em grid -->
            <div class="container" >
                <!-- classe formata pagina em 3 colunas horizontais -->
                <div class="row">
                    <div class="col">
                    </div>

                    <!-- classe grid 1 de 3 -->
                    <div class="col">
                        <div class="card" style="background-color: #a1c2de">
                            <div class="card-body" style="background-color: #a1c2de">
                                <h5 class="card-title">Alterar Usuario</h5>
                            </div>
                            <ul class="list-group list-group-flush" style="background-color: #a1c2de">
                                <li class="list-group-item" style="background-color: #a1c2de">
                                    <p>Usuario</p>
                                    <input type="text" name="usuario" class="rounded-pill"
                                           readonly
                                           value="<%out.write(u.getUsuario());%>" />
                                </li>
                                <li class="list-group-item" style="background-color: #a1c2de">
                                    <p>Senha atual</p>
                                    <input type="text" name="consultasenha" readonly="true" class="rounded-pill"
                                           value="<%out.write(u.getSenhausuario());%>" />    
                                </li>
                                <li class="list-group-item" style="background-color: #a1c2de">
                                    <p>Senha Nova</p>
                                    <input type="password" name="senha" class="rounded-pill" placeholder="Insira sua nova senha"/>    
                                </li>


                                </li>
                                <%}%>
                            </ul>
                            <div class="card-body">
                                <input style="text-align: center;" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0" type="submit" value="Alterar" />
                            </div>
                        </div>
                    </div>
                    <div class="col">
                    </div>
                </div>
            </div>
        </form>
        <script>
            $(document).ready(function () {
                $('#txtInput').on("cut copy paste", function (e) {
                    e.preventDefault();
                });
            });
        </script>

        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
