
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
            String citta, cap, via, civico;
            citta=request.getParameter("citta");
            cap=request.getParameter("cap");
            via=request.getParameter("via");
            civico=request.getParameter("civico");

            String paginaPrecedente=session.getAttribute("paginaPrecedente").toString();
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
     
            String sql = "INSERT INTO sedi (citta, cap, civico, via) VALUES ('" + citta + "', '" + cap + "', '" + civico + "', '" + via + "')";
            gestore.getFunzioni().executeQuery(sql);
            response.sendRedirect(paginaPrecedente);

        %>
  </body>
</html>
