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
        <form method="post" action="EsercizioTre.jsp">
            Nome utente: <input type="text" name="nomeUtente"><br>
            Password: <input type="password" name="password"><br><br>
            <input type="submit" value="Accedi">
        </form>

</body>
	<%
	if (request.getMethod().equals("POST")) {
	  	Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/verifica","root","root");
	    Statement stmt=cn.createStatement();
	    // Ottieni i parametri dalla richiesta HTTP
	    String nomeUtente = request.getParameter("nomeUtente");
	    String password = request.getParameter("password");
	    String sql = "SELECT userid, pwd FROM  dipendenti WHERE userId='"+nomeUtente+"' AND pwd='"+password+"'";
	   	ResultSet rs = stmt.executeQuery(sql);
	   	boolean registrato = false;
	   	while(rs.next()){
	   		registrato = true;
	   		session.setAttribute("nomeUtente", rs.getString("userid"));
	   		response.sendRedirect("AggiuntaAuto.jsp");	
	   	}
	   	if(registrato==false){
	   		response.sendRedirect("PaginaErrore.jsp");	
	   	}
	}
	%>
</html>