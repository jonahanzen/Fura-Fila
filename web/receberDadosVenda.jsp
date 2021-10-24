<%@page import="modelos.Acesso"%>
<%@page import="modelos.Loja"%>
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

                                    //recebe os valores da tela HTML  
                                    String cpf = request.getParameter("cpfconsulta");
                                    //instancia o cliente e loja 
                                    Loja l = new Loja();
                                    Cliente cliente = new Cliente();
                                    boolean consulta = cliente.clienteExiste(cpf);
                                    if (consulta != true) {
                                        response.sendRedirect("verificaCadastraCliente.jsp?status=1");
                                    } else {
                                        l.setIdCpf(cpf);
                                        l.setSituacaovenda(false);
                                        l.setSituacaoatendimento(false);
                                        if (l.incluirVenda()) {
                                            response.sendRedirect("incluirItensVenda.jsp?status=0&id=" + cpf);
                                        } else {
                                            response.sendRedirect("verificaCadastraCliente.jsp?status=2");
                                        }
                                    }


    %>

