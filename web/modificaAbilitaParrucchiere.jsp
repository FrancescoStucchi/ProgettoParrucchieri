<%@page import="classi.Gestore"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="style.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500&display=swap" rel="stylesheet">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sede</title>
    <style>
        

.checkboxes {
  background-color: #fff;
  color: #333;
  border-radius: 8px;
  padding: 20px;
  margin-top: 20px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.checkbox {
  display: flex;
  align-items: center;
  margin: 10px 0;
}

.checkbox input {
  display: none;
}

.checkbox label {
  position: relative;
  padding-left: 40px;
  cursor: pointer;
  font-size: 15px;
}

.checkbox label:before {
  content: '';
  position: absolute;
  left: 0;
  width: 20px;
  height: 20px;
  border-radius: 10%;
  background: #ecf0f1;
  transition: background 0.3s ease;
}

.checkbox input:checked + label:before {
  background: #5aa2ed;
}

.checkbox label:after {
  content: '';
  position: absolute;
  left: 4px;
  top: 1px;
  width: 10px;
  height: 10px;
  border: solid white;
  border-width: 0 3px 3px 0;
  transform: rotate(45deg);
  display: none;
}

.checkbox input:checked + label:after {
  display: block;
}

.checkbox.disabled label {
  color: #bdc3c7;
  cursor: not-allowed;
}

.checkbox.disabled label:before {
  background: #5aa2ed;
}

.checkbox.disabled label:after {
  color: #5aa2ed;
}

.aggiungi-btn {
  background-color: #5aa2ed;
  color: #fff;
  border: none;
  padding: 10px 20px;
  font-size: 18px;
  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s ease;
  margin-top: 10px;
}

.aggiungi-btn:hover {
  background-color: #5aa2ed;
}

    </style>
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
    <form id="serviziForm" action="salvaCapacita.jsp" method="POST">
        <%
            String serviziSql = "SELECT * FROM servizi";
            ResultSet rsServizi = gestore.getFunzioni().select(serviziSql);

            String capacitaSql = "SELECT id_servizio FROM capacita WHERE id_parrucchiere = ?";
            PreparedStatement psCapacita = gestore.getFunzioni().getConnection().prepareStatement(capacitaSql);
            psCapacita.setString(1, idParrucchiere);
            ResultSet rsCapacita = psCapacita.executeQuery();

            HashSet<String> serviziSelezionati = new HashSet<String>();
            while (rsCapacita.next()) {
                serviziSelezionati.add(rsCapacita.getString("id_servizio"));
            }

            while (rsServizi.next()) {
                String idServizio = rsServizi.getString("id");
                String nomeServizio = rsServizi.getString("tipo");
                boolean checked = serviziSelezionati.contains(idServizio);
        %>
                <div class="checkbox">
                    <input type="checkbox" id="servizio_<%= idServizio %>" name="servizi" value="<%= idServizio %>" <%= checked ? "checked" : "" %>>
                    <label for="servizio_<%= idServizio %>"><%= nomeServizio %></label>
                </div>
        <%
            }
        %>
        <input type="hidden" name="idParrucchiere" value="<%= idParrucchiere %>">
        <button class="aggiungi-btn" type="submit">Salva</button>
    </form>
</div>
</body>
</html>
