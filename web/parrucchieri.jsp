<%-- 
    Document   : parrucchieri.jsp
    Created on : 19-apr-2024, 12.13.09
    Author     : 5binfo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>gestore parrucchieri!</h1>
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
                            if(rs.getInt("id_sede") == 0){
                                response.sendRedirect("amministratore.jsp");
                            }else{
                                response.sendRedirect("sede.jsp");
                                request.setAttribute("id_sede", rs.getString("id_sede"));
                            }
                    }
                    if(registrato==false){
                        out.println("non registrato");	
                    }
            }
        %>
    </body>
</html>
