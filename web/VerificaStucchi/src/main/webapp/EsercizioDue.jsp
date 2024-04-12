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
<h1>elenco targhe: </h1>
	  <%
	  	Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/verifica","root","root");
        Statement stmt=cn.createStatement();
        String sql = "SELECT * FROM auto";
       	ResultSet rs =	stmt.executeQuery(sql);
       	String targa;
       	while(rs.next()){
       		targa = rs.getString("targa");
       		%>
       		<a href="InformazioniTarga.jsp?targa=<%= rs.getString("targa")%>&modello=<%= rs.getString("Modello")%>&marca=<%= rs.getString("Marca")%>&anno=<%= rs.getString("anno")%>"><%=targa %></a>
       		<br>
       		<%
       	}
    %>
</body>
</html>