<%@page import="modelos.Acesso"%>
<%@page import="modelos.Produto"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Carregando Imagem do Produto</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0 shrink-to-fit=no">
        <meta http-equiv="refresh" content="0; url='incluirProduto.jsp?status=1'">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>

    <div>
        <%
            String usuario = (String) session.getAttribute("usuario");
            String tipo = null;
            //verifica sessão 
            Acesso ac = new Acesso();
            ac = ac.consultarPermissoes(usuario);
            tipo = ac.getTipoUsuario();
            if (usuario == null) {
                response.sendRedirect("index.html?msg=UsuarioNaoLogado");
            } else if (ac.isAcessoincluirproduto() == true) {

            } else {
                if (tipo == "u") {
                    response.sendRedirect("verificaCadastraCliente.jsp?status=0");
                } else {
                response.sendRedirect("menuPrincipal.jsp?s    tatus=1");
                }
            }

            switch (tipo) {
            case "a": %><script src="scripts/navba    rGerente.js"></script><%
                                            break;
                                    case "f": %><script src="scripts/navbarFun    cionario.js"></script><%
                                            break;
                                        case "u": %><script src="scripts/navbarTotem.js"></script><%
                                                break;
                                            default:
                                                break;
                                        }
                                        String cod = request.getParameter("cod");
            %>
    </div>     
    <body onload="validaStatus()">

        <!--  escolher a navbar a ser carregada da pasta de scripts -->
        <script src="scripts/navbarGerente.js"></script>

        <%
            File file;
            int maxFileSize = 5000 * 1024;
            int maxMemSize = 5000 * 1024;
            ServletContext context = pageContext.getServletContext();
            String filePath = context.getInitParameter("file-upload");

            // Verify the content type
            String contentType = request.getContentType();

            if ((contentType.indexOf("multipart/form-data") >= 0)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);

                // Location to save data that is larger than maxMemSize.
                factory.setRepository(new File("c:\\temp"));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);

                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);

                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(request);

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>JSP File upload</title>");
                    out.println("</head>");
                    out.println("<body>");

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
                            String fieldName = fi.getFieldName();
                            String fileName = "produto_" + cod + ".png";
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();

                            // Write the file
                            if (fileName.lastIndexOf("\\") >= 0) {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\")));
                            } else {
                                file = new File(filePath
                                        + fileName.substring(fileName.lastIndexOf("\\") + 1));
                            }
                            fi.write(file);
                            out.println("Uploaded Filename: " + filePath
                                    + fileName + "<br>");
                        }
                    }
                    out.println("<a href=index.html>Voltar</a>");
                    out.println("</body>");
                    out.println("</html>");
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            } else {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet upload</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<p>No file uploaded</p>");
                out.println("</body>");
                out.println("</html>");
            }

        %>
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




        </script>   

        <!-- scrips utilizados pelo Bootstrap, devem estar nesta ordem : jQuery (slim), Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>