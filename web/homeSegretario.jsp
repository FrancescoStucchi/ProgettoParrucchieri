
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
<body class="home">
    <div id="header">
        
        <div>

            <a href="index.jsp">
                <img id="logo" src="Immagini/icona-sede.png" alt="icona sede">

            </a>

            <% 
                try{
                    String nomeSede="";
                    String id_sede;
                    Gestore gestore = new Gestore();
                    gestore.loadDatabase();
                    try{
                         id_sede = request.getParameter("sede_scelta").toString();
                    } catch (Exception e) {
                         id_sede = session.getAttribute("id_sede").toString();
                    }
                    String sql = "SELECT citta FROM  sedi WHERE id='"+id_sede+"'";
                    session.setAttribute("id_sede", id_sede);
                    
                    //qua settiamo la pagina precendete
                    session.setAttribute("paginaPrecedente", "homeSegretario.jsp");
                    ResultSet rs = gestore.getFunzioni().select(sql);
                    boolean registrato = false;
                    while(rs.next()){
                        nomeSede=rs.getString("citta");
                    }
            %>
            <h1><%= nomeSede%></h1>
            <%  
            %>
        </div>
            <a class="logo-container">
                <img id="logo_base" src="Immagini/logo.png">
            </a>
        <button class="logout-btn" onclick="window.location.href='index.jsp'">
            <img src="Immagini/porta-logout.png" alt="Logout">
        </button>
    </div>
    <nav>
        <ul>
            <li class="<%= request.getRequestURI().endsWith("homeSegretario.jsp") ? "active" : "" %>"><a href="homeSegretario.jsp">Clienti</a></li>
            <li class="<%= request.getRequestURI().endsWith("schedaParrucchieriSegretario.jsp") ? "active" : "" %>"><a href="schedaParrucchieriSegretario.jsp">Parrucchieri</a></li>
            <!-- Aggiungi altri elementi del menu se necessario -->
        </ul>
    </nav>
    <br>
    <div class="containerButton">
        <button class="aggiungi-btn" onclick="window.location.href='aggiuntaCliente.jsp'">Aggiungi</button>
        <button class="aggiungi-btn" onclick="window.location.href='visualizzazioneAppuntamentiGlobali.jsp'">Visualizza appuntamenti</button>
    </div>
    <br>
   <div class="container">
    <table class="table-container">
            <thead>
              <tr>
                <th>Id</th>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Telefono</th>
                <th>Prenota</th>
                <th>Appuntamenti</th>
                <th>Modifica</th>
                <th>Elimina</th>
              </tr>
            </thead>
            <tbody>
            <%
                sql = "SELECT id, nome, cognome, telefono FROM clienti";
                rs = gestore.getFunzioni().select(sql);
                while(rs.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("nome") + "</td>");
                    out.println("<td>" + rs.getString("cognome") + "</td>");
                    out.println("<td>" + rs.getString("telefono") + "</td>");
                    out.println("<td><button class='capacita-btn' onclick=\"window.location.href='sceltaServizioPrenotazione.jsp?id=" + rs.getInt("id") + "'\">Prenota</button></td>");
                    out.println("<td><button class='prenota-btn' onclick=\"window.location.href='visualizzazioneAppuntamentiCliente.jsp?id=" + rs.getInt("id") + "'\">Appuntamenti</button></td>");
                    out.println("<td><button class='modifica-btn' onclick=\"window.location.href='modificaCliente.jsp?id=" + rs.getInt("id") + "'\">Modifica</button></td>");
                    out.println("<td><button class='elimina-btn' onclick=\"window.location.href='eliminaCliente.jsp?id=" + rs.getInt("id") + "'\">Elimina</button></td>");
                    out.println("</tr>");    
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