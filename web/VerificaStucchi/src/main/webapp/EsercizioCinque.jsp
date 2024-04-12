<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	  <h1>Inserimento Auto con limitazioni</h1>
        <form method="post" action="EsercizioCinque.jsp">
            targa: <input type="text" name="targa"><br>
            modello: <input type="text" name="modello"><br>
          <p>modello: </p><select name="marca" id="marca">
		       <%
		  		Class.forName("com.mysql.cj.jdbc.Driver");
		       Connection cn=DriverManager.getConnection("jdbc:mysql://localhost/verifica","root","root");
		       Statement stmt=cn.createStatement();
		       String sql="SELECT marca FROM auto";
		       ResultSet rs = stmt.executeQuery(sql);
		       while (rs.next()) {
		    	   %><option ><%=rs.getString("marca")%></option><%    
		       }
		       %>
		
	        </select>
	        <br>
            anno: <input type="text" name="anno"><br><br>
            <input type="submit" value="invia">
     	</form>
    
    <%
	if (request.getMethod().equals("POST")) {
	    // Ottieni i parametri dalla richiesta HTTP
	    String targa = request.getParameter("targa");
	    String modello = request.getParameter("modello");
	    String marca = request.getParameter("marca");
	    String anno = request.getParameter("anno");
	    sql = "INSERT INTO auto (targa, modello, marca, anno) VALUES ('" + targa + "', '" + modello + "', '" + marca + "', '" + anno+"')" ;
        stmt.executeUpdate(sql);
        out.write("auto aggiunta con successo");
		
	}
	%>

</body>
</html>