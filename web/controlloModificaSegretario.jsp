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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int idSede = Integer.parseInt(request.getParameter("sede_scelta"));
            int idSegretario = Integer.parseInt(request.getParameter("idSegretario"));
            String paginaPrecedente = session.getAttribute("paginaPrecedente").toString();

            Gestore gestore = new Gestore();
            gestore.loadDatabase();

            // Query di aggiornamento
            String sql = "UPDATE segretari SET nome = '" + nome + "', cognome = '" + cognome + "', telefono = '" + telefono + "', username = '" + username + "', password = '" + password + "', id_sede = " + idSede + " WHERE id = " + idSegretario;
            gestore.getFunzioni().executeQuery(sql);

            response.sendRedirect(paginaPrecedente);
        %>

    </body>
</html>
