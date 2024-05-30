<%@page import="classi.Gestore"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recupera i parametri dalla richiesta
    String idParrucchiere = request.getParameter("idParrucchiere");
    String[] nuoviServizi = request.getParameterValues("servizi");

    Gestore gestore = new Gestore();
    gestore.loadDatabase();
    Connection conn = gestore.getFunzioni().getConnection();

    try {
        // Avvia una transazione
        conn.setAutoCommit(false);

        // Cancella le capacità esistenti del parrucchiere
        String deleteSql = "DELETE FROM capacita WHERE id_parrucchiere = ?";
        PreparedStatement psDelete = conn.prepareStatement(deleteSql);
        psDelete.setString(1, idParrucchiere);
        psDelete.executeUpdate();

        // Inserisci le nuove capacità
        if (nuoviServizi != null) {
            String insertSql = "INSERT INTO capacita (id_parrucchiere, id_servizio) VALUES (?, ?)";
            PreparedStatement psInsert = conn.prepareStatement(insertSql);

            for (String idServizio : nuoviServizi) {
                psInsert.setString(1, idParrucchiere);
                psInsert.setString(2, idServizio);
                psInsert.addBatch();
            }

            psInsert.executeBatch();
        }

        // Conferma la transazione
        conn.commit();
    } catch (SQLException e) {
        // In caso di errore, effettua il rollback
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
    } finally {
        // Ripristina l'auto commit e chiudi la connessione
        if (conn != null) {
            try {
                conn.setAutoCommit(true);
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Reindirizza a una pagina di conferma o alla pagina precedente
    String paginaPrecedente = session.getAttribute("paginaPrecedente").toString();
    response.sendRedirect(paginaPrecedente);
%>
