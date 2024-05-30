<%-- 
    Document   : eliminaCliente
    Created on : 22-mag-2024, 20.45.02
    Author     : Admin
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
            int idCliente=Integer.parseInt(request.getParameter("id"));
            String paginaPrecedente=session.getAttribute("paginaPrecedente").toString();

            // Query per ottenere i dati delle sedi
            String sql = "DELETE FROM appuntamenti WHERE id = '"+idCliente+"'";
            gestore.getFunzioni().executeQuery(sql);
            response.sendRedirect(paginaPrecedente);
            
        %>
    </body>
</html>
