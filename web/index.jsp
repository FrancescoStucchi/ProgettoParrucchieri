<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    </head>
    <body>
            <h1>Pagina di login</h1>
            <form method="post" action="ControlloCredenziali.jsp">
                Nome utente: <input type="text" name="nomeUtente"><br>
                Password: <input type="password" name="password"><br><br>
                <input type="submit" value="Accedi">
            </form>
        </body>
</html>