
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
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/parrucchieridb", "root", "");
                Statement stmt = cn.createStatement();
                // Ottieni i parametri dalla richiesta HTTP
                String nomeUtente = request.getParameter("nomeUtente");
                String password = request.getParameter("password");
                String sql = "SELECT username, password, id_sede FROM segretari WHERE username='" + nomeUtente + "' AND password='" + password + "'";
                ResultSet rs = stmt.executeQuery(sql);
                boolean registrato = false;
                while (rs.next()) {
                    registrato = true;
                    session.setAttribute("credentialValidated", true);
                    if (rs.getInt("id_sede") == 0) 
                    {
                      response.sendRedirect("sceltaSedeAmministatore.jsp");
                    } 
                    else 
                    {
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("id_sede", rs.getInt("id_sede"));
                        response.sendRedirect("homeSegretario.jsp");
                    }
                }
                if (!registrato) { 
                  out.println("<p class=\"error\">Credenziali errate. Riprova.</p>");
                  session.setAttribute("credentialValidated", false);
                  response.sendRedirect("index.jsp");
                }
            } catch (Exception e) {
              out.println("<p class=\"error\">Si è verificato un errore. Riprova più tardi.</p>");
              e.printStackTrace();
            }
          }
        %>
  </body>
</html>
