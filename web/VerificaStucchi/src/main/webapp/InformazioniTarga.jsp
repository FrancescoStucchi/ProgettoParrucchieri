<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>informazioni <%=request.getParameter("targa")%></h1>
	<p>modello: <%=request.getParameter("modello")%></p>
	<p>marca: <%=request.getParameter("marca")%></p>
	<p>anno: <%=request.getParameter("anno")%></p>
	
</body>
</html>