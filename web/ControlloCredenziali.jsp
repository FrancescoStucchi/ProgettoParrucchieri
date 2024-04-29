<%-- 
    Document   : ControlloCredenziali
    Created on : 12-apr-2024, 12.00.25
    Author     : Francesco
--%>
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classi.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body> 
        <%
	if (request.getMethod().equals("POST")) {
            Gestore gestore =new Gestore();
            gestore.loadDatabase();
	    // Ottieni i parametri dalla richiesta HTTP
	    String nomeUtente = request.getParameter("nomeUtente");
	    String password = request.getParameter("password");
	    String sql = "SELECT username, password, id_sede, tipo FROM  segretari WHERE username='"+nomeUtente+"' AND password='"+password+"'";
            ResultSet rs = gestore.getFunzioni().select(sql);
	   	boolean registrato = false;
	   	while(rs.next()){
	   		registrato = true;
                        if(rs.getInt("tipo") == 1){
                            response.sendRedirect("amministratore.jsp");
                        }else{
                            response.sendRedirect("sede.jsp");
                            session.setAttribute("username", rs.getString("username"));
                            session.setAttribute("id_sede", rs.getInt("id_sede"));
                        }
	   	}
	   	if(registrato==false){
                    out.println("non registrato");	
	   	}
	}
        %>
    </body>
</html>
