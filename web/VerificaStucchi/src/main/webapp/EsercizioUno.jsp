<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<form method="post" action="EsercizioUno.jsp">
        <!-- Aggiungi campi del modulo per i dati dell'utente -->
        numero 1: <input type="number" name="numeroUno"><br>
        numero 2: <input type="number" name="numeroDue"><br>
        <input type="submit" value="invia">
    </form>
    
    <%
    	if (request.getMethod().equals("POST")) {
            // Ottieni i parametri dalla richiesta HTTP
            int numeroUno = Integer.parseInt(request.getParameter("numeroUno"));
            int numeroDue = Integer.parseInt(request.getParameter("numeroDue"));
            if(numeroUno>0 && numeroUno<11){
            	if(numeroDue>0 && numeroDue<11){
            		out.write("media ("+numeroUno+" e "+numeroDue+")"+(numeroUno+numeroDue)/2);
            	}else{
            		out.write("il secondo numero dev' essere compreso tra 1 e 10");
            	}
            }else{
            	out.write("il primo numero dev' essere compreso tra 1 e 10");
            }

            }
    %>

</body>
</html>