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
        background-image: url('Immagini/sfondo_index.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        font-family: sans-serif;
        background-color: #f4f4f4;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        opacity: 95%;
      width: 100%;
      max-width: 400px;
      padding: 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
    }

    .logo {
      display: block;
      margin: 0 auto 20px;
      height: 200px;
      width: 200px;
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
      background-color: #010066; /* Colore nuovo del pulsante */
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      box-sizing: border-box;
    }

    input[type="submit"]:hover {
      background-color: #0056b3; /* Colore nuovo per l'hover del pulsante */
    }
  </style>
</head>
<body>
  <div class="container">
    <img src="Immagini/logo.png" alt="Logo" class="logo"> 
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
      </div>
      <div class="error-message">
        <%= errorMessage %>
      </div>
      <input type="submit" value="Accedi"/>
    </form>
    </div>

</body>
</html>
