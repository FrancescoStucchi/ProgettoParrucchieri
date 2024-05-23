<%-- 
    Document   : aggiuntaCliente
    Created on : 19-mag-2024, 14.38.58
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aggiungi Nuovo Cliente</title>
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
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .form-group input[type="text"], .form-group input[type="tel"] {
                border: 1px solid #ccc;
                border-radius: 4px;
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
                const telefono = document.getElementById('telefono').value;
                const submitButton = document.getElementById('submitButton');

                const isNomeValid = nome.trim() !== '';
                const isCognomeValid = cognome.trim() !== '';
                const isTelefonoValid = /^\d{10}$/.test(telefono);

                submitButton.disabled = !(isNomeValid && isCognomeValid && isTelefonoValid);
            }

            function restrictToNumbers(event) {
                const key = event.key;
                if (!/^\d$/.test(key) && key !== 'Backspace' && key !== 'Delete') {
                    event.preventDefault();
                }
            }

            document.addEventListener('DOMContentLoaded', (event) => {
                const inputs = document.querySelectorAll('#nome, #cognome, #telefono');
                inputs.forEach(input => {
                    input.addEventListener('input', validateForm);
                });

                const telefonoInput = document.getElementById('telefono');
                telefonoInput.addEventListener('keydown', restrictToNumbers);

                validateForm();  
            });
        </script>
    </head>
    <body>
        <div class="form-container">
            <h1>Aggiungi Nuovo Cliente</h1>
            <form method="POST" action="controlloAggiungiCliente.jsp">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                <div class="form-group">
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Telefono:</label>
                    <input type="tel" id="telefono" name="telefono" pattern="\d{10}" required maxlength="10">
                </div>
                <div class="form-group">
                    <input type="submit" id="submitButton" value="Aggiungi Nuovo Cliente" disabled>
                </div>
            </form>
        </div>
    </body>
</html>
