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
</head>
<body>
  <div class="container">
    <h1>TT</h1>
    <form method="post" action="ControlloCredenziali.jsp">
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
      <div class="error-message" style="color: red; font-weight: bold; margin-bottom: 10px;">
        <%= errorMessage %>
      </div>
      <button type="submit">Accedi</button>
    </form>
  </div>
</body>
</html>

<style>
  body {
    font-family: sans-serif;
  }

  .container {
    width: 400px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
  }

  h1 {
    text-align: center;
    margin-bottom: 20px;
  }

  .input-group {
    margin-bottom: 15px;
  }

  label {
    display: block;
    margin-bottom: 5px;
  }

  input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
  }

  button {
    background-color: #4CAF50;
    color: white;
    padding: 10px 20px;
    border: none;
    cursor: pointer;
  }

  button:hover {
    background-color: #45a049;
  }

  .error-message {
    display: block;
  }
</style>
