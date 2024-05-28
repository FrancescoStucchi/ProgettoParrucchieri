
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
            String nome, cognome, telefono, username, password;
            int idSede;
            nome=request.getParameter("nome");
            cognome=request.getParameter("cognome");
            telefono=request.getParameter("telefono");
            username=request.getParameter("username");
            password=request.getParameter("password");
            idSede=Integer.parseInt(request.getParameter("sede_scelta"));
            String paginaPrecedente=session.getAttribute("paginaPrecedente").toString();
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
     
            String sql = "INSERT INTO segretari (nome, cognome, username, password, telefono, tipo, id_sede) VALUES ('" + nome + "', '" + cognome + "', '" + username + "', '" + password + "', '" + telefono + "', 0, '" + idSede + "')";
            gestore.getFunzioni().executeQuery(sql);
            response.sendRedirect(paginaPrecedente);

        %>
  </body>
</html>
