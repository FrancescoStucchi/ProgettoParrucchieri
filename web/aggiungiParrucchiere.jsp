<%-- 
    Document   : aggiungiParrucchiere
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
        <title>Aggiungi Nuovo Parrucchiere</title>
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
            function validateForm() {
                const nome = document.getElementById('nome').value;
                const cognome = document.getElementById('cognome').value;
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const telefono = document.getElementById('telefono').value;
                const sede = document.getElementById('sedeSelect').value;
                const submitButton = document.getElementById('submitButton');

                const isNomeValid = nome.trim() !== '';
                const isCognomeValid = cognome.trim() !== '';
                const isUsernameValid = username.trim() !== '';
                const isPasswordValid = password.trim() !== '';
                const isTelefonoValid = /^\d{10}$/.test(telefono);
                const isSedeValid = sede !== '';

                submitButton.disabled = !(isNomeValid && isCognomeValid && isUsernameValid && isPasswordValid && isTelefonoValid && isSedeValid);
            }

            function restrictToNumbers(event) {
                const key = event.key;
                if (!/^\d$/.test(key) && key !== 'Backspace' && key !== 'Delete') {
                    event.preventDefault();
                }
            }

            function togglePasswordVisibility() {
                const passwordInput = document.getElementById('password');
                const passwordToggle = document.getElementById('passwordToggle');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    passwordToggle.textContent = '🙈';
                } else {
                    passwordInput.type = 'password';
                    passwordToggle.textContent = '👁️';
                }
            }

            document.addEventListener('DOMContentLoaded', (event) => {
                const inputs = document.querySelectorAll('#nome, #cognome, #username, #password, #telefono, #sedeSelect');
                inputs.forEach(input => {
                    input.addEventListener('input', validateForm);
                });

                const telefonoInput = document.getElementById('telefono');
                telefonoInput.addEventListener('keydown', restrictToNumbers);

                const passwordToggle = document.getElementById('passwordToggle');
                passwordToggle.addEventListener('click', togglePasswordVisibility);

                validateForm();  // Initialize form state
            });
        </script>
    </head>
    <body>
        <div class="form-container">
            <h1>Aggiungi Nuovo Parrucchiere</h1>
             <form method="POST" action="controlloAggiungiParruchiere.jsp">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                <div class="form-group">
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome" required>
                </div>
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <span id="passwordToggle" class="toggle-password">👁️</span>
                </div>
                <div class="form-group">
                    <label for="telefono">Telefono:</label>
                    <input type="tel" id="telefono" name="telefono" pattern="\d{10}" required maxlength="10">
                </div>
                <div class="form-group">
                    <label for="sedeSelect">Scegli la sede:</label>
                    <select id="sedeSelect" name="sede_scelta" required>
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
                </div>
                <div class="form-group">
                    <input type="submit" id="submitButton" value="Aggiungi Nuovo Parrucchiere" disabled>
                </div>
            </form>
        </div>
    </body>
</html>
