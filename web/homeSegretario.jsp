
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sede</title>
    <style>
        /* Stili per la barra di menu */
        body {
            margin: 0;
            padding: 0;
        }
        
        h1 {
            align-items: center;
        }

        #header {
            background-color: #f0f0f0;
            padding: 5px;
        }

        #logo {
            float: left;
            width: 50px;
            height: auto;
            margin-right: 10px;
            margin-left: 10px;
            margin-top: 5px;
        }

        nav {
            background-color: #f8f8f8; /* colore leggermente più chiaro */
            overflow: hidden;
            border-top: 1px solid #ccc; /* aggiungo una sottile linea sopra */
            border-bottom: 1px solid #ccc; /* e una sottile linea sotto */
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            float: left;
        }

        nav ul li a {
            display: block;
            color: #333; /* colore del testo */
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        nav ul li a:hover {
            background-color: #ddd; /* colore leggermente più scuro al passaggio del mouse */
        }
        
        .container {
        width: 100%;
        max-width: 800px;
        margin: 0 auto;
      }

      table {
        width: 100%;
        border-collapse: collapse;
      }

      th, td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: left;
      }

      th {
        background-color: #f0f0f0;
}
    </style>
</head>
<body>
    <div id="header">
        <nav>
            <div>
                <img id="logo" src="Immagini/icona-sede.png" alt="icona sede">
                <% 
                    try{
                        String nomeSede="";
                        Gestore gestore = new Gestore();
                        gestore.loadDatabase();
                        String id_sede = session.getAttribute("id_sede").toString();        
                        String sql = "SELECT citta FROM  sedi WHERE id='"+id_sede+"'";
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
            <ul>
                <li><a href="homeSegretario.jsp">Clienti</a></li>
                <li><a href="hchedaParrucchieriSegretario.jsp">Parrucchieri</a></li>
                <li><a href="#">Impostazioni</a></li>
                <!-- Aggiungi altri elementi del menu se necessario -->
            </ul>
        </nav>
    </div>
    <br>
    <br>
    <div class="container">
        <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>NOME</th>
                <th>COGNOME</th>
                <th>TELEFONO</th>
              </tr>
            </thead>
            <tbody>
            <%
                sql = "SELECT id, nome, cognome, telefono FROM segretari WHERE id_sede='"+id_sede+"' AND tipo = 0";
                rs = gestore.getFunzioni().select(sql);
                while(rs.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("nome") + "</td>");
                    out.println("<td>" + rs.getString("cognome") + "</td>");
                    out.println("<td>" + rs.getString("telefono") + "</td>");
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
