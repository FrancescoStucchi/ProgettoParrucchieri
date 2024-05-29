<%@page import="java.sql.Time"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link href="style.css" rel="stylesheet" type="text/css">
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
      <table class="turni-table">
        <thead>
          <tr>
            <th></th>
            <th>LUN</th>
            <th>MAR</th>
            <th>MER</th>
            <th>GIO</th>
            <th>VEN</th>
            <th>SAB</th>
            <th>DOM</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Mattina</td>
            <% for (int i = 0; i < 7; i++) { %>
              <td>
                <%
                  String turnoId = null;
                  String sql2 = "SELECT * FROM turni WHERE giorno = '" + (i + 1) + "' AND ora_inizio < '12:00:00'";
                  ResultSet rsTurno = gestore.getFunzioni().select(sql2);
                  if (rsTurno != null && rsTurno.next()) {
                    turnoId = rsTurno.getString("id");
                    sql2 = "SELECT * FROM svolge WHERE id_parrucchiere = '"+idParrucchiere+"' AND id_turno = '"+turnoId+"'";
                    ResultSet rsCheck = gestore.getFunzioni().select(sql2);
                    if (rsCheck != null && rsCheck.next()) {
                %>
                      <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>" checked>
                <%
                    } else {
                %>
                      <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>">
                <%
                    }
                  }
                %>
              </td>
            <% } %>
          </tr>
          <tr>
            <td>Pomeriggio</td>
            <% for (int i = 0; i < 7; i++) { %>
              <td>
                <%
                  String turnoId = null;
                  String sql2 = "SELECT * FROM turni WHERE giorno = '" + (i + 1) + "' AND ora_inizio >= '12:00:00'";
                  ResultSet rsTurno = gestore.getFunzioni().select(sql2);
                  if (rsTurno != null && rsTurno.next()) {
                    turnoId = rsTurno.getString("id");
                    sql2 = "SELECT * FROM svolge WHERE id_parrucchiere = '"+idParrucchiere+"' AND id_turno = '"+turnoId+"'";
                    ResultSet rsCheck = gestore.getFunzioni().select(sql2);
                    if (rsCheck != null && rsCheck.next()) {
                %>
                      <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>" checked>
                <%
                    } else {
                %>
                      <input type="checkbox" name="turno" value="<%= turnoId %>" id="turno_<%= turnoId %>">
                <%
                    }
                  }
                %>
              </td>
            <% } %>
          </tr>
        </tbody>
      </table>
      <input type="hidden" name="idParrucchiere" value="<%= idParrucchiere %>">
      <button type="submit">Salva</button>
    </form>
  </div>
</body>
</html>
