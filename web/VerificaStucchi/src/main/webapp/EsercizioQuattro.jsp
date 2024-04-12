<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>visualizzazioni</title>
</head>
<body>
	<h1>numero visualizzazioni </h1>
	<%
	int numeroVisualizzazioni = (int) application.getAttribute("numeroVisualizzazioni");
	out.write(numeroVisualizzazioni+"");
	numeroVisualizzazioni+=1;
	application.setAttribute("numeroVisualizzazioni", numeroVisualizzazioni);

		
	%>
</body>
</html>