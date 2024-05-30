<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
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
                Gestore gestore = null;
                try {
                    gestore = new Gestore();
                    gestore.loadDatabase();
                    try {
                        id_sede = request.getParameter("sede_scelta").toString();
                    } catch (Exception e) {
                        id_sede = session.getAttribute("id_sede").toString();
                    }
                    String sql = "SELECT citta FROM sedi WHERE id='" + id_sede + "'";
                    session.setAttribute("id_sede", id_sede);
                    String idParrucchiere = request.getParameter("id");
                    session.setAttribute("paginaPrecedente", "visualizzazioneAppuntamentiCliente.jsp");
                    ResultSet rs = gestore.getFunzioni().select(sql);
                    while (rs.next()) {
                        nomeSede = rs.getString("citta");
                    }
                %>
                <h1><%= nomeSede %></h1>
                <% } catch (Exception e) { %>
                <p class="error">Si è verificato un errore. Riprova più tardi.</p>
                <%
                    e.printStackTrace();
                } 
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
            <!-- Aggiungi altri elementi del menu se necessario -->
        </ul>
    </nav>

    <div class="container">
        <div class="date-navigation">
            <%
                LocalDate currentDate;
                String dateParam = request.getParameter("date");
                if (dateParam != null) {
                    currentDate = LocalDate.parse(dateParam);
                } else {
                    currentDate = LocalDate.now();
                }
            %>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>NOME CLIENTE</th>
                    <th>NOME PARRUCCHIERE</th>
                    <th>TIPO SERVIZIO</th>
                    <th>DATA</th>
                    <th>ORA INIZIO</th>
                    <th>ORA FINE</th>
                    <th>ELIMINA</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        String clientId = request.getParameter("id");
                        if (clientId != null && !clientId.isEmpty()) {
                            String sql = "SELECT appuntamenti.id, appuntamenti.data, appuntamenti.durata, appuntamenti.ora, " +
                                         "clienti.nome AS nome_cliente, clienti.cognome AS cognome_cliente, " +
                                         "servizi.tipo, " +
                                         "parrucchieri.nome AS nome_parrucchiere, parrucchieri.cognome AS cognome_parrucchiere " +
                                         "FROM appuntamenti " +
                                         "JOIN clienti ON appuntamenti.id_cliente = clienti.id " +
                                         "JOIN impegno ON appuntamenti.id = impegno.id_appuntamento " +
                                         "JOIN servizi ON impegno.id_servizio = servizi.id " +
                                         "JOIN parrucchieri ON impegno.id_parrucchiere = parrucchieri.id " +
                                         "WHERE clienti.id = '" + clientId + "'";
                            ResultSet rs = gestore.getFunzioni().select(sql);
                            while (rs.next()) {
                                LocalTime oraInizio = rs.getTime("ora").toLocalTime();
                                LocalTime durata = rs.getTime("durata").toLocalTime();
                                LocalTime oraFine = oraInizio.plusHours(durata.getHour()).plusMinutes(durata.getMinute());

                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("id") + "</td>");
                                out.println("<td>" + rs.getString("nome_cliente") + " " + rs.getString("cognome_cliente") + "</td>");
                                out.println("<td>" + rs.getString("nome_parrucchiere") + " " + rs.getString("cognome_parrucchiere") + "</td>");
                                out.println("<td>" + rs.getString("tipo") + "</td>");
                                out.println("<td>" + rs.getDate("data") + "</td>");
                                out.println("<td>" + oraInizio + "</td>");
                                out.println("<td>" + oraFine + "</td>");
                                out.println("<td><button class='elimina-btn' onclick=\"window.location.href='eliminaAppuntamento.jsp?id=" + rs.getInt("id") + "'\">Elimina</button></td>");
                                out.println("</tr>");
                            }
                        } 
                    } catch (Exception e) {
                        out.println("<p class=\"error\">Si è verificato un errore. Riprova più tardi.</p>");
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
