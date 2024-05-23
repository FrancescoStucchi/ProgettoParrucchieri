<%-- 
    Document   : confermaAppuntamento
    Created on : 23-mag-2024, 8.53.04
    Author     : Francesco
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        // Recupera i parametri dalla richiesta
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date startTime = formatter.parse( request.getParameter("startTime"));
        
        %>
    </body>
</html>
    