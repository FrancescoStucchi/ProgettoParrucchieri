<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="style.css">
  <style>
    body {
      font-family: sans-serif;
      background-color: #f4f4f4;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      width: 100%;
      max-width: 400px;
      padding: 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
    }

    h1 {
      text-align: center;
      margin-bottom: 20px;
    }

    .input-group {
      margin-bottom: 15px;
      position: relative;
    }

    label {
      display: block;
      margin-bottom: 5px;
    }

    input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
    }

    .toggle-password {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      font-size: 20px;
    }

    .error-message {
      color: red;
      font-weight: bold;
      margin-bottom: 10px;
      text-align: center;
    }

    input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      box-sizing: border-box;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>TT</h1>
    <form method="POST" action="controlloCredenziali.jsp">
      <%
          Boolean credentialValidated = (Boolean) session.getAttribute("credentialValidated");
          String errorMessage = "";
          if (credentialValidated != null && credentialValidated==false) {
              errorMessage = "Credenziali errate";
          }
      %>
      
      <div class="input-group">
        <label for="nomeUtente">Nome utente:</label>
        <input type="text" id="nomeUtente" name="nomeUtente" required>
      </div>
      <div class="input-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <span class="toggle-password" id="passwordToggle" onclick="togglePasswordVisibility()">👁️</span>
      </div>
      <div class="error-message">
        <%= errorMessage %>
      </div>
      <input type="submit" value="Accedi"/>
    </form>
  </div>

  <script>
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
  </script>
</body>
</html>
