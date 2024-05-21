<%@page import="classi.Gestore"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Scegli la sede da amministrare</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
        }
        select, input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Scegli il servizio</h1>
        <form id="servizioForm" action="calendario.jsp" method="post">
            <select name="sede_scelta" id="servizoiSelect">
                <option value="" disabled selected>Scegli la il servizio</option>
                <% 
                    try {
                        Gestore gestore = new Gestore();
                        gestore.loadDatabase();
                        
                        // Query per ottenere i dati delle sedi
                        String sql = "SELECT id, tipo FROM servizi";
                        ResultSet rs = gestore.getFunzioni().select(sql);
                        
                        // Iterazione sui risultati della query e generazione delle opzioni
                        while (rs.next()) {
                            int idServizio = rs.getInt("id");
                            String nomeServizio = rs.getString("tipo");
                            out.println("<option value=\"" + idServizio + "\">" + nomeServizio + "</option>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
            <br>
            <input type="submit" value="Seleziona Sede">
        </form>
    </div>
    <script>
            document.getElementById("servizioForm").addEventListener("submit", function(event) {
            var sedeSelect = document.getElementById("servizioSelect");
            var selectedId = sedeSelect.options[sedeSelect.selectedIndex].value;
            sessionStorage.setItem("ServizioForm", selectedId);
        });
    </script>
</body>
</html>
