<%-- 
    Document   : ControlloCredenziali
    Created on : 12-apr-2024, 12.00.25
    Author     : Francesco
--%>
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body> 
        <%
	if (request.getMethod().equals("POST")) {
	  	Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/parrucchieridb","root","");
	    Statement stmt=cn.createStatement();
	    // Ottieni i parametri dalla richiesta HTTP
	    String nomeUtente = request.getParameter("nomeUtente");
	    String password = request.getParameter("password");
	    String sql = "SELECT username, password, id_sede FROM  segretari WHERE username='"+nomeUtente+"' AND password='"+password+"'";
	   	ResultSet rs = stmt.executeQuery(sql);
	   	boolean registrato = false;
	   	while(rs.next()){
	   		registrato = true;
                        if(rs.getInt("id_sede") == null){
                            response.sendRedirect("amministratore");
                        }
                            
                        
                        response.sendRedirect("sede.jsp");
	   		//session.setAttribute("nomeUtente", rs.getString("username"));
                        
	   	}
	   	if(registrato==false){
                    out.println("non registrato");	
	   	}
	}
        %>
    </body>
</html>
