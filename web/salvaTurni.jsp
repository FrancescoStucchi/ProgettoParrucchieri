<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="classi.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Salva Turni</title>
</head>
<body>
<%
  String idParrucchiere = request.getParameter("idParrucchiere");
  String[] selectedTurni = request.getParameterValues("turno");

  Gestore gestore = new Gestore();
  gestore.loadDatabase();
  Connection conn = gestore.getFunzioni().getConnection();

  try {
    // Delete existing entries for the idParrucchiere
    String deleteSql = "DELETE FROM svolge WHERE id_parrucchiere = ?";
    PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
    deleteStmt.setString(1, idParrucchiere);
    deleteStmt.executeUpdate();

    // Insert new entries for selected checkboxes
    if (selectedTurni != null) {
      String insertSql = "INSERT INTO svolge (id_parrucchiere, id_turno) VALUES (?, ?)";
      PreparedStatement insertStmt = conn.prepareStatement(insertSql);
      for (String turnoId : selectedTurni) {
        insertStmt.setString(1, idParrucchiere);
        insertStmt.setString(2, turnoId);
        insertStmt.executeUpdate();
      }
    }

    // Redirect to a success page or back to the original page
    response.sendRedirect("homeAmministratore.jsp");
  } catch (Exception e) {
    e.printStackTrace();
    out.println("Errore durante il salvataggio dei turni.");
  } finally {
    if (conn != null) {
      try {
        conn.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }
%>
</body>
</html>
