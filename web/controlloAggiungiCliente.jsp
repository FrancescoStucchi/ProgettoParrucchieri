
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
            String nome, cognome, telefono;
            nome=request.getParameter("nome");
            cognome=request.getParameter("cognome");
            telefono=request.getParameter("telefono");
            String paginaPrecedente=session.getAttribute("paginaPrecedente").toString();
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
     
            String sql = "INSERT INTO clienti (nome, cognome, telefono) VALUES ('" + nome + "', '" + cognome + "', '" + telefono + "')";
            gestore.getFunzioni().executeQuery(sql);
            response.sendRedirect(paginaPrecedente);

        %>
  </body>
</html>
