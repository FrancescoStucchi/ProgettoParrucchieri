<%-- 
    Document   : controlloModificaSede
    Created on : 30-mag-2024, 17.04.30
    Author     : Admin
--%>

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
            String citta = request.getParameter("citta");
            String cap = request.getParameter("cap");
            String via = request.getParameter("via");
            String civico = request.getParameter("civico");
            int idSede = Integer.parseInt(request.getParameter("idSede"));
            String paginaPrecedente = session.getAttribute("paginaPrecedente").toString();

            Gestore gestore = new Gestore();
            gestore.loadDatabase();

            // Query di aggiornamento
            String sql = "UPDATE sedi SET citta = '" + citta + "', cap = '" + cap + "', via = '" + via + "', civico = '" + civico + "' WHERE id = " + idSede;
            gestore.getFunzioni().executeQuery(sql);

            response.sendRedirect(paginaPrecedente);
        %>
    </body>
</html>
