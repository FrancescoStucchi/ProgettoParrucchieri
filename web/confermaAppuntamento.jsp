<%-- 
    Document   : confermaAppuntamento
    Created on : 23-mag-2024, 8.53.04
    Author     : Francesco
--%>

<%@page import="java.sql.Time"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
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
        String g = request.getParameter("giorno").split("/")[0];
        String m = request.getParameter("giorno").split("/")[1];
        String a = request.getParameter("giorno").split("/")[2];

        Gestore gestore = new Gestore();
        gestore.loadDatabase();
        String sql1 = "SELECT durata FROM servizi WHERE id="+session.getAttribute("id_servizio");
        ResultSet rs = gestore.getFunzioni().select(sql1);
        if (rs.next()) {    
            String sql = "INSERT INTO appuntamenti (data, durata, ora, id_cliente) VALUES ('"+a+"-"+m+"-"+g+"','"+rs.getTime("durata")+"', '"+request.getParameter("oraInizio")+"',"+session.getAttribute("idCliente") +");";
            gestore.getFunzioni().executeQuery(sql);
        }
        response.sendRedirect("homeSegretario.jsp");
        %>
    </body>
</html>
    