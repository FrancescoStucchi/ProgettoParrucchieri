
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sede</title>
    <link rel="stylesheet" href="style.css"  type="text/css">
</head>
<body>
    <div id="header">
        <div>
            <a href="sceltaSedeAmministratore.jsp">
                <img id="logo" src="Immagini/icona-sede.png" alt="icona sede">
            </a>
            <% 
                
                    String nomeSede="";
                    String id_sede;
                    Gestore gestore = new Gestore();
                    gestore.loadDatabase();
                    try{
                         id_sede = request.getParameter("sede_scelta").toString();
                    } catch (Exception e) {
                         id_sede = session.getAttribute("id_sede").toString();
                    }
                    String sql = "SELECT citta FROM  sedi WHERE id='"+id_sede+"'";
                    session.setAttribute("id_sede", id_sede);
                    
                    //qua settiamo la pagina precendete
                    session.setAttribute("paginaPrecedente", "homeAmministratore.jsp");
                    ResultSet rs = gestore.getFunzioni().select(sql);
                    boolean registrato = false;
                    while(rs.next()){
                        nomeSede=rs.getString("citta");
                    }
            %>
            <h1><%= nomeSede%></h1>
            <%  
            %>
        </div>
        <button class="logout-btn" onclick="window.location.href='index.jsp'">
            <img src="Immagini/porta-logout.png" alt="Logout">
        </button>
    </div>
    <nav>
        <ul>
            <li class="<%= request.getRequestURI().endsWith("homeAmministratore.jsp") ? "active" : "" %>"><a href="homeAmministratore.jsp">Clienti</a></li>
            <li class="<%= request.getRequestURI().endsWith("schedaParrucchieriAmministratore.jsp") ? "active" : "" %>"><a href="schedaParrucchieriAmministratore.jsp">Parrucchieri</a></li>
            <li class="<%= request.getRequestURI().endsWith("schedaSegretariAmministratore.jsp") ? "active" : "" %>"><a href="schedaSegretariAmministratore.jsp">Segretari</a></li>
            <li class="<%= request.getRequestURI().endsWith("schedaSediAmministratore.jsp") ? "active" : "" %>"><a href="schedaSediAmministratore.jsp">Sedi</a></li>
            <!-- Aggiungi altri elementi del menu se necessario -->
        </ul>
    </nav>
        <%
            String idParrucchiere = request.getParameter("id").toString();
            sql = "SELECT citta FROM  sedi WHERE id='"+id_sede+"'";
            rs = gestore.getFunzioni().select(sql);
            while(rs.next()){
            %>
            <input type="checkbox" name="A" value="checkboxValue" <%= true ? "checked" : "" %>>
            <label for="checkboxName">Checkbox Label</label>
            <%
            }
        %>
    <div class="containerButton">
        <button class="aggiungi-btn" onclick="window.location.href='aggiuntaCliente.jsp'">Aggiungi</button>
    </div>
   <div class="container">
    
</div>

</body>
</html>