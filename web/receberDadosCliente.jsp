<%@page import="modelos.Acesso"%>
<%@page import="modelos.Cliente"%>
<!DOCTYPE html>
<%

    String usuario = (String) session.getAttribute("usuario");
    String tipo = null;
    //verifica sessão 
    Acesso ac = new Acesso();
    ac = ac.consultarPermissoes(usuario);
    tipo = ac.getTipoUsuario();
    if (usuario == null) {
        response.sendRedirect("index.html?msg=UsuarioNaoLogado");
    } else if (ac.isAcessoincluircliente() == true) {

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
                                    String cpf = request.getParameter("cpf");
                                    String nome = request.getParameter("nome");

                                    //instancia o cliente
                                    Cliente cliente = new Cliente();
                                    cliente.setCpf(cpf);
                                    cliente.setNome(nome);
                                    boolean clienteExiste = cliente.clienteExiste(cpf);

                                    // método para incluir cliente e volta para a página incluirCliente
                                    if (clienteExiste == true) {
                                        response.sendRedirect("incluirCliente.jsp?status=1");
                                    } else {
                                        if (cliente.incluirCliente()) {
                                            response.sendRedirect("incluirCliente.jsp?status=2");
                                        } else {
                                            response.sendRedirect("incluirCliente.jsp?status=3");
                                        }
                                    }

    %>

