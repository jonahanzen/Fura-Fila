<%@page import="modelos.Acesso"%>
<%@page import="modelos.Usuario"%>
<!DOCTYPE html>
<html lang="pt-BR">

    <%

        //recebe os valores da tela HTML e executa m�todos de inclus�o  
        //recebe os valores da tela HTML  
        String cpf = request.getParameter("cpf");
        String nome = request.getParameter("usuario");
        String senha = request.getParameter("senha");
        String grupo = "u";
        boolean usuarioExiste = false;
        boolean cpfCadastrado = false;

        //instancia o usuario
        Acesso ac = new Acesso();
        Usuario usuario = new Usuario();
        usuario.setidCpf(cpf);
        usuario.setUsuario(nome);
        usuario.setSenhausuario(senha);
        usuario.setSituacao(true);
        usuarioExiste = usuario.usuarioExiste(nome);
        cpfCadastrado = usuario.usuarioExisteComEsteCPF(cpf);
        ac.setUsuario(nome);
        ac.setTipoUsuario(grupo);

        // m�todo para incluir cliente e volta para a p�gina incluirCliente
        if (cpfCadastrado == true) {
            response.sendRedirect("incluirUsuario.jsp?status=4");
        } else {
            if (usuarioExiste != true) {
                if (usuario.incluirUsuario()) {
                    if (ac.incluirAcesso()) {
                        response.sendRedirect("incluirUsuario.jsp?status=2");
                    } else {
                        response.sendRedirect("incluirUsuario.jsp?status=3");
                    }
                }
            } else {
                response.sendRedirect("incluirUsuario.jsp?status=1");
            }
        }

    %>
</html>
