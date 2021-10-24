<%@page import="modelos.Acesso"%>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Menu Principal</title>
         <link rel="shortcut icon" href="imgPagina/favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    
    <body onload="validaStatus()" style="max-width: 100%; overflow: hidden; background-color: #a1c2de">
        
        <% 
                     //verifica sessão
                                String usuario = (String) session.getAttribute("usuario");
                                String tipo = null;
                                //verifica sessão 
                                Acesso ac = new Acesso();
                                ac = ac.consultarPermissoes(usuario);
                                tipo = ac.getTipoUsuario();
                                if (usuario == null) {
                                    response.sendRedirect("index.html?msg=UsuarioNaoLogado");
                                } else if (ac.isAcessomenuprincipal()== true) {
                                    
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
                         if (vstatus == null) {
                             vstatus = "0";
                         }
                %>
        
       <div id="header">
            <img class="imagem-banner"
                 style="float:right; width: 700px; position: fixed; right: 90px; 
                 top: 151px;"
                 src="imgPagina/furaozao.png" alt="hero-header">
        </div>

        <input type="text" name="status" id="status" value="<%out.write(vstatus);%>" readonly="true" hidden>
        <script>
            function validaStatus() {
                        var status = $('input[name=status]').val();
                        switch (status) {
                        case "1": alert("Acesso negado!");
                                 break;
                        default:
                                
                                 break;
                  } 
                }
        </script>
    <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
