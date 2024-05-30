<%-- 
    Document   : modificaParrucchiere
    Created on : 19-mag-2024, 15.02.11
    Author     : Admin
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modifica Parrucchiere</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .form-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .form-container h1 {
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
                position: relative;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .form-group .toggle-password {
                position: absolute;
                right: 10px;
                top: 35px;
                cursor: pointer;
            }
            .form-group input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                padding: 10px 20px;
            }
            .form-group input[type="submit"]:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }
        </style>
        
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const inputs = document.querySelectorAll('#nome, #cognome, #username, #password, #telefono, #sedeSelect');
                const submitButton = document.getElementById('submitButton');
                const initialValues = {};

                inputs.forEach(input => {
                    initialValues[input.id] = input.value;
                    input.addEventListener('input', validateForm);
                });

                function validateForm() {
                    let isChanged = false;
                    inputs.forEach(input => {
                        if (input.value !== initialValues[input.id]) {
                            isChanged = true;
                        }
                    });
                    submitButton.disabled = !isChanged;
                }

                function restrictToNumbers(event) {
                    const key = event.key;
                    if (!/^\d$/.test(key) && key !== 'Backspace' && key !== 'Delete') {
                        event.preventDefault();
                    }
                }

                const telefonoInput = document.getElementById('telefono');
                telefonoInput.addEventListener('keydown', restrictToNumbers);

                const passwordToggle = document.getElementById('passwordToggle');
                passwordToggle.addEventListener('click', togglePasswordVisibility);

                validateForm();  // Initialize form state
            });
        </script>
    </head>
    <body>
        <%
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
            int idParrucchiere = Integer.parseInt(request.getParameter("id"));
            
            // Query per ottenere i dati del cliente 
            String sql = "SELECT * FROM parrucchieri WHERE id = " + idParrucchiere;
            ResultSet rs = gestore.getFunzioni().select(sql);
            String nome = "", cognome = "", telefono = "", username="", password="";
            int idSede = 0;
            if (rs.next()) {
                nome = rs.getString("nome");
                cognome = rs.getString("cognome");
                telefono = rs.getString("telefono");
                username = rs.getString("username");
                password = rs.getString("password");
                idSede = rs.getInt("id_sede");
            }
        %>
        <div class="form-container">
            <h1>Modifica Parrucchiere</h1>
             <form method="POST" action="controlloModificaParrucchiere.jsp">
                <input type="hidden" name="idParrucchiere" value="<%= idParrucchiere %>">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" value="<%= nome %>" required>
                </div>
                <div class="form-group">
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome" value="<%= cognome %>" required>
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= username %>" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= password %>" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Telefono:</label>
                    <input type="tel" id="telefono" name="telefono" value="<%= telefono %>" pattern="\d{10}" required maxlength="10">
                </div>
                <div class="form-group">
                    <label for="sedeSelect">Scegli la sede:</label>
                    <select id="sedeSelect" name="sede_scelta" required>
                        <option value="" disabled>Scegli la sede</option>
                        <% 
                            try {
                                sql = "SELECT id, citta FROM sedi";
                                rs = gestore.getFunzioni().select(sql);
                                while (rs.next()) {
                                    int sedeId = rs.getInt("id");
                                    String citta = rs.getString("citta");
                                    String selected = (sedeId == idSede) ? "selected" : "";
                                    out.println("<option value=\"" + sedeId + "\" " + selected + ">" + citta + "</option>");
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" id="submitButton" value="Salva Modifiche" disabled>
                </div>
            </form>
        </div>
    </body>
</html>
