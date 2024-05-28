<%@page import="java.sql.Time"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="style.css" type="text/css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Sede</title>
</head>
<body>
  <div id="header">
    <div>
      <a href="sceltaSedeAmministratore.jsp">
        <img id="logo" src="Immagini/icona-sede.png" alt="icona sede">
      </a>
      <%
        String nomeSede = "";
        String id_sede;
        String idParrucchiere;
        Gestore gestore = new Gestore();
        gestore.loadDatabase();
        id_sede = request.getParameter("sede_scelta") != null ? request.getParameter("sede_scelta").toString() : session.getAttribute("id_sede").toString();
        idParrucchiere = request.getParameter("id").toString();
        String sql = "SELECT citta FROM sedi WHERE id='" + id_sede + "'";
        session.setAttribute("id_sede", id_sede);
         
        // Set the previous page
        session.setAttribute("paginaPrecedente", "homeAmministratore.jsp");
        ResultSet rs = gestore.getFunzioni().select(sql);
        boolean registrato = false;
        while (rs.next()) {
          nomeSede = rs.getString("citta");
        }
      %>
      <h1><%= nomeSede %></h1>
      <%
      %>
    </div>
    <button class="logout-btn" onclick="window.location.href='index.jsp'">
      <img src="Immagini/porta-logout.png" alt="Logout">
    </button>
  </div>
  <nav>
    <ul>
      <li class="<%= request.getRequestURI().endsWith("homeAmministratore.jsp") ? "active" : "" %>"><a href="homeAmministratore.jsp">Clienti</a></li>
      <li class="<%= request.getRequestURI().endsWith("schedaParrucchieriAmministratore.jsp") ? "active" : "" %>"><a href="schedaParrucchieriAmministratore.jsp">Parrucchieri</a></li>
      <li class="<%= request.getRequestURI().endsWith("schedaSegretariAmministratore.jsp") ? "active" : "" %>"><a href="schedaSegretariAmministratore.jsp">Segretari</a></li>
      <li class="<%= request.getRequestURI().endsWith("schedaSediAmministratore.jsp") ? "active" : "" %>"><a href="schedaSediAmministratore.jsp">Sedi</a></li>
      <!-- Add other menu items if necessary -->
    </ul>
  </nav>
  <div class="checkboxes">
    <form id="turniForm" action="salvaTurni.jsp" method="POST">
      <%
        sql = "SELECT * FROM turni";
        String sql2;
        rs = gestore.getFunzioni().select(sql);
        ResultSet rsTurno;
         
        while (rs.next()) {
          String turnoId = rs.getString("id");
          sql2 = "SELECT * FROM svolge WHERE id_parrucchiere = '"+idParrucchiere+"' AND id_turno = '"+turnoId+"'";
          rsTurno = gestore.getFunzioni().select(sql2);
          String giorno = rs.getString("giorno");
          Time oraInizio = rs.getTime("ora_inizio");
          Time oraFine = rs.getTime("ora_fine");
          String turno = giorno;
          String fasciaOraria = oraInizio.before(Time.valueOf("12:00:00")) ? "Mattina" : "Pomeriggio";
          if (rsTurno.next()) { // Check if the parrucchiere has this turno
          %>
          <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>" checked>
          <label for="turno_<%= turnoId %>"><%= turno %> <%= fasciaOraria %></label><br>
          <%
          } else {
          %>
          <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>">
          <label for="turno_<%= turnoId %>"><%= turno %> <%= fasciaOraria %></label><br>
          <%
          }
        }
      %>
      <input type="hidden" name="idParrucchiere" value="<%= idParrucchiere %>">
      <button type="submit">Salva</button>
    </form>
  </div>
</body>
</html>
