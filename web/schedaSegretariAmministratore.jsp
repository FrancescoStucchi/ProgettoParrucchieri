
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
        text-align: center;
      }

      th {
        background-color: #f0f0f0;
    }
    /* Stile per i pulsanti "Modifica" ed "Elimina" */
    .modifica-btn,
    .elimina-btn {
        display: inline-block;
        padding: 8px 16px;
        background-color: #4CAF50; /* Colore di sfondo verde */
        color: white;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    /* Stile per il pulsante "Modifica" */
    .modifica-btn {
        background-color: blue; /* Colore di sfondo verde */
    }

    /* Stile per il pulsante "Elimina" */
    .elimina-btn {
        background-color: #f44336; /* Colore di sfondo rosso */
    }

    /* Stile quando il cursore è sopra il pulsante */
    .modifica-btn:hover,
    .elimina-btn:hover {
        background-color: blueviolet; /* Cambia il colore di sfondo in verde più scuro quando il cursore è sopra */
    }
    .container {
        width: 100%;
        max-width: 800px;
        margin: 0 auto;
        position: relative; /* Aggiunto posizionamento relativo per posizionare il bottone accanto alla tabella */
    }
    .aggiungi-btn {
        background-color: #4CAF50; /* Colore di sfondo verde */
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 5px;
    }

    .containerButton {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    /* Stile quando il cursore è sopra il pulsante */
    .aggiungi-btn:hover {
        background-color: #45a049; /* Cambia il colore di sfondo in verde più scuro quando il cursore è sopra */
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
                <li><a href="homeAmministratore.jsp">Clienti</a></li>
                <li><a href="schedaParrucchieriAmministratore.jsp">Parrucchieri</a></li>
                <li><a href="schedaSegretariAmministratore.jsp">Segretari</a></li>
                <li><a href="schedaSediAmministratore.jsp">Sedi</a></li>
                <li><a href="#">Impostazioni</a></li>
                <!-- Aggiungi altri elementi del menu se necessario -->
            </ul>
        </nav>
    </div>
     
    <br>
    <div class="containerButton">
        <button class="aggiungi-btn" onclick="window.location.href='aggiungiSegretario.jsp'">Aggiungi</button>
    </div>
    
    <br>
    <div class="container">
        <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>NOME</th>
                <th>COGNOME</th>
                <th>TELEFONO</th>
                <th>MODIFICA</th>
                <th>ELIMINA</th>
              </tr>
            </thead>
            <tbody>
            <%
                sql = "SELECT id, nome, cognome, telefono FROM segretari where tipo = 0 AND  id_sede='"+id_sede+"'";
                rs = gestore.getFunzioni().select(sql);
                while(rs.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("nome") + "</td>");
                    out.println("<td>" + rs.getString("cognome") + "</td>");
                    out.println("<td>" + rs.getString("telefono") + "</td>");
                    out.println("<td><button class='modifica-btn' onclick=\"window.location.href='modifica.jsp?id=" + rs.getInt("id") + "'\">Modifica</button></td>");
                    out.println("<td><button class='elimina-btn' onclick=\"window.location.href='elimina.jsp?id=" + rs.getInt("id") + "'\">Elimina</button></td>");
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
