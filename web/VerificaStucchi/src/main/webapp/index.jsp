<%@ page import="ClassiJava.UtenteManager,ClassiJava.Utente" %>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    	<h1>verifica Stucchi Francesco</h1>
        <br>
        <a href="EsercizioUno.jsp">esercizio1</a> 
        <br>
        <a href="EsercizioDue.jsp">esercizio2</a> 
        <br>
        <a href="EsercizioTre.jsp">esercizio3</a> 
        <br>
        <a href="EsercizioQuattro.jsp">esercizio4</a> 
        <br>
        <a href="EsercizioCinque.jsp">esercizio5</a> 
        
        <%
        int numeroVisualizzazioni = 0;
        application.setAttribute("numeroVisualizzazioni", numeroVisualizzazioni);
        %>

    </body>
</html>