<%@page import="classi.Gestore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <%
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String telefono = request.getParameter("telefono");
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String paginaPrecedente = session.getAttribute("paginaPrecedente").toString();
            
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
            
            // Query di aggiornamento
            String sql = "UPDATE clienti SET nome = '" + nome + "', cognome = '" + cognome + "', telefono = '" + telefono + "' WHERE id = " + idCliente;
            gestore.getFunzioni().executeQuery(sql);

            response.sendRedirect(paginaPrecedente);

        %>
    </body>
</html>
