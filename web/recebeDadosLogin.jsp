<%@page import="modelos.Acesso"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>

    <body>
        <%
            String usuario = request.getParameter("usuario");
            String senhausuario = request.getParameter("senha");
            String tipo = null;
            boolean usuarioExiste = false;
            Usuario u = new Usuario();
            if (u.usuarioExiste(usuario) == true){
            u = u.consultarSituacaoUsuario(usuario);
            Boolean situacao = u.isSituacao();
            if ((situacao == true) && (usuario != null) && (senhausuario != null) && !(usuario.isEmpty())
                    && !(senhausuario.isEmpty())) {
                // verifica se usuário existe 
                if (u.podeLogar(usuario, senhausuario)) {
                    session.setAttribute("usuario", usuario);
                    Acesso ac = new Acesso();
                    ac = ac.consultarPermissoes(usuario);
                    tipo = ac.getTipoUsuario();
                    switch (tipo) {
                        case "a":
                            response.sendRedirect("menuPrincipal.jsp");
                            break;
                        case "f":
                            response.sendRedirect("menuPrincipal.jsp");
                            break;
                        case "u":
                            response.sendRedirect("verificaCadastraCliente.jsp?status=0");
                            break;
                        default:
                            break;
                    }
                } else {
                    response.sendRedirect("index.html?msg=UsuarioNaoCadastrado");
                }
            } else {
                response.sendRedirect("index.html?msg=UsuarioDesativado");
            }
            } else {
                response.sendRedirect("index.html?msg=UsuarioNaoCadastrado");
            }
           
        %>
    </body>
</html>
