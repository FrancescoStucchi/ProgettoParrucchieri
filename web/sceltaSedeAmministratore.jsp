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
            background-image: url('Immagini/sfondo_scelta.png');
             background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
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
            opacity: 90%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            font-family: 'Helvetica', 'Arial', sans-serif;
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
            background-color: #010066;
            color: white;
            cursor: pointer;
            disabled: true;
        }
        input[type="submit"]:hover {
            background-color: darker;
        }
        input[type="submit"]:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Scegli la sede da amministrare:</h1>
        <form id="sedeForm" action="homeAmministratore.jsp" method="post">
            <select name="sede_scelta" id="sedeSelect">
                <option value="" disabled selected>Scegli la sede</option>
                <% 
                    try {
                        Gestore gestore = new Gestore();
                        gestore.loadDatabase();
                        
                        // Query per ottenere i dati delle sedi
                        String sql = "SELECT id, citta FROM sedi";
                        ResultSet rs = gestore.getFunzioni().select(sql);
                        
                        // Iterazione sui risultati della query e generazione delle opzioni
                        while (rs.next()) {
                            int idSede = rs.getInt("id");
                            String citta = rs.getString("citta");
                            out.println("<option value=\"" + idSede + "\">" + citta + "</option>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
            <br>
            <input type="submit" value="Seleziona Sede" id="submitBtn" disabled>
        </form>
    </div>
    <script>
        const sedeSelect = document.getElementById("sedeSelect");
        const submitBtn = document.getElementById("submitBtn");

        sedeSelect.addEventListener("change", function() {
            if (sedeSelect.value) {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        });

        document.getElementById("sedeForm").addEventListener("submit", function(event) {
            var selectedId = sedeSelect.options[sedeSelect.selectedIndex].value;
            sessionStorage.setItem("id_sede", selectedId);
        });
    </script>
</body>
</html>
