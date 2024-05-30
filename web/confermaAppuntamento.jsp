<%-- 
    Document   : confermaAppuntamento
    Created on : 23-mag-2024, 8.53.04
    Author     : Francesco
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
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
               String sql = "INSERT INTO appuntamenti (data, durata, ora, id_cliente) VALUES ('"
        + a + "-" + m + "-" + g + "','" + rs.getTime("durata") + "', '"
        + request.getParameter("oraInizio") + "'," + session.getAttribute("idCliente") + ")";
    
        // Eseguire l'inserimento e recuperare le chiavi generate
        PreparedStatement ps = gestore.getFunzioni().getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.executeUpdate();

        ResultSet chiaviGenerate = ps.getGeneratedKeys();
        if (chiaviGenerate.next()) {
            int idAppuntamento = chiaviGenerate.getInt(1);

            String sql2 = "INSERT INTO impegno (id_parrucchiere, id_servizio, id_appuntamento) VALUES ('"
                + request.getParameter("idParrucchiere") + "'," + session.getAttribute("id_servizio") + "," + idAppuntamento + ")";
            gestore.getFunzioni().executeQuery(sql2);
        }
        }
        String paginaPrecedente = session.getAttribute("paginaPrecedente").toString();
        response.sendRedirect(paginaPrecedente);
        %>
    </body>
</html>
    