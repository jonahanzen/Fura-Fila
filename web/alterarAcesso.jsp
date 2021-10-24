<%@page import="modelos.Usuario"%>
<%@page import="modelos.Acesso"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Alterar Permissão</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    </head>
    <body style="max-width: 100%; overflow: hidden; background-color: #a1c2de">
        <%
            String usuario = request.getParameter("user");
            //verifica sessão
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

            %>
        <!--  mostra as permissões que o usaurio possui, lembrando que são criado com valor padrao ao
        realizar o cadastro do usuario-->
        <%            Acesso a = new Acesso();
            if (usuario != null) {
                a = a.consultarPermissoes(usuario);
            }
        %>
        <!-- classe container para separar em grid -->
        <div class="container">

            <!-- classe formata pagina em 3 colunas horizontais -->
            <div class="row">
                <div class="col">
                </div>
                <!-- classe grid 2 de 3 -->
                <div class="col-9 justify-content-center">
                    <form action="receberDadosAlterarAcesso.jsp" method="POST">
                        <!-- final do campo para inserir texto modelo -->
                        <div class="form-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" class="form-control rounded-pill"  
                                   name="usuario" id="usuario"
                                   readonly="true" value="<%out.write(a.getUsuario());%>" />
                        </div>

                        <!-- campo para cada tipo radio em linha -->
                        <div class="form-check form-check-inline">
                            <label for="consultarTipoUsuario">Tipo Usuario</label>
                            <input type="text" name="consultarTipoUsuario" id="consultarTipoUsuario"
                                   readonly="true" value="<%out.write(a.getTipoUsuario());%>" />
                            <input class="form-check-input" type="radio" name="tipoUsuario" id="tipoUsuario" value="u">
                            <label class="form-check-label" for="tipoUsuario">
                                Usuario Comun
                            </label>
                        </div>
                        <!-- final do campo do tipo radio em linha -->

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="tipoUsuario" id="tipoUsuario" value="f">
                            <label class="form-check-label" for="tipoUsuario">
                                Funcionario
                            </label>
                        </div>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="tipoUsuario" id="tipoUsuario" value="a">
                            <label class="form-check-label" for="tipoUsuario">
                                Administrador
                            </label>
                        </div>


                        <!-- final do campo para inserir texto modelo -->
                        <div class="form-group">
                            <label for="acessoincluircliente">Acesso Incluir Cliente</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoincluircliente" name="consultaracessoincluircliente" 
                                   readonly="true" value="<%out.write("" + a.isAcessoincluircliente());%>" />
                            <select name="acessoincluircliente" id="acessoincluircliente" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoalterarcliente">Acesso Alterar Cliente</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoalterarcliente" name="consultaracessoalterarcliente" 
                                   readonly="true" value="<%out.write("" + a.isAcessoalterarcliente());%>" />
                            <select name="acessoalterarcliente" id="acessoalterarcliente" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoconsultarcliente">Acesso Consultar Cliente</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoconsultarcliente" name="consultaracessoconsultarcliente" 
                                   readonly="true" value="<%out.write("" + a.isAcessoconsultarcliente());%>" />
                            <select name="acessoconsultarcliente" id="acessoconsultarcliente" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoexcluircliente">Acesso Excluir Cliente</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessoexcluircliente" name="consultaracessoexcluircliente" 
                                   readonly="true" value="<%out.write("" + a.isAcessoconsultarcliente());%>" />
                            <select name="acessoexcluircliente" id="acessoexcluircliente" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoincluirusuario">Acesso Incluir Usuario</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoincluirusuario" name="consultaracessoincluirusuario" 
                                   readonly="true" value="<%out.write("" + a.isAcessoincluirusuario());%>" />
                            <select name="acessoincluirusuario" id="acessoincluirusuario" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoalterarusuario">Acesso Alterar Usuario</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoalterarusuario" name="consultaracessoalterarusuario" 
                                   readonly="true" value="<%out.write("" + a.isAcessoalterarusuario());%>" />
                            <select name="acessoalterarusuario" id="acessoalterarusuario" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoconsultarusuario">Acesso Consultar Usuario</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessoconsultarusuario" name="consultaracessoconsultarusuario" 
                                   readonly="true" value="<%out.write("" + a.isAcessoconsultarusuario());%>" />
                            <select name="acessoconsultarusuario" id="acessoconsultarusuario" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>      

                        <div class="form-group">
                            <label for="acessoincluirproduto">Acesso Incluir Produto</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessoincluirproduto" name="consultaracessoincluirproduto" 
                                   readonly="true" value="<%out.write("" + a.isAcessoincluirproduto());%>" />
                            <select name="acessoincluirproduto" id="acessoincluirproduto" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoalterarproduto">Acesso Alterar Produto</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoalterarproduto" name="consultaracessoalterarproduto" 
                                   readonly="true" value="<%out.write("" + a.isAcessoalterarproduto());%>" />
                            <select name="acessoalterarproduto" id="acessoalterarproduto" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoconsultarproduto">Acesso Consultar Produto</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoconsultarproduto" name="consultaracessoconsultarproduto" 
                                   readonly="true" value="<%out.write("" + a.isAcessoconsultarproduto());%>" />
                            <select name="acessoconsultarproduto" id="acessoconsultarproduto" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessorealizarvenda">Acesso Realizar Venda</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessorealizarvenda" name="consultaracessorealizarvenda" 
                                   readonly="true" value="<%out.write("" + a.isAcessorealizarvenda());%>" />
                            <select name="acessorealizarvenda" id="acessorealizarvenda" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessocancelarvenda">Acesso Cancelar Venda</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessocancelarvenda" name="consultaracessocancelarvenda" 
                                   readonly="true" value="<%out.write("" + a.isAcessocancelarvenda());%>" />
                            <select name="acessocancelarvenda" id="acessocancelarvenda" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoalterarvenda">Acesso Alterar Venda</label>
                            <input type="text" class="form-control rounded-pill" 
                                   id="consultaracessoalterarvenda" name="consultaracessoalterarvenda" 
                                   readonly="true" value="<%out.write("" + a.isAcessoalterarvenda());%>" />
                            <select name="acessoalterarvenda" id="acessoalterarvenda" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessoalterarsenha">Acesso Alterar Senha</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessoalterarsenha" name="consultaracessoalterarsenha" 
                                   readonly="true" value="<%out.write("" + a.isAcessoalterarsenha());%>" />
                            <select name="acessoalterarsenha" id="acessoalterarsenha" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="acessomenuprincipal">Acesso Alterar Senha</label>
                            <input type="text" class="form-control rounded-pill"
                                   id="consultaracessomenuprincipal" name="consultaracessomenuprincipal" 
                                   readonly="true" value="<%out.write("" + a.isAcessomenuprincipal());%>" />
                            <select name="acessomenuprincipal" id="acessomenuprincipal" class="rounded-pill">
                                <option value="true">Sim</option>
                                <option value="false">Não</option>
                            </select>
                        </div>     
                        <input type="submit" value="Alterar" class="btn btn-primary rounded-pill btn-outline-light my-2 my-sm-0"/>
                    </form>
                </div>
                <div class="col">
                </div>
            </div>
        </div>



        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
