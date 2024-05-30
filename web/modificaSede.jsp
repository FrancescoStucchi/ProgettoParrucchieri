<%-- 
    Documento   : modificaSede
    Creato il   : 23-mag-2024, 18.13.11
    Autore      : Admin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modifica Sede</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .contenitore {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
        }
        h1 {
            text-align: center;
            color: #333333;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 10px;
            color: #333333;
        }
        input[type="text"] {
            width: calc(100% - 16px);
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #007BFF;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:disabled {
            background-color: #cccccc;
        }
        #mappa {
            height: 300px;
            width: 100%;
            margin-top: 20px;
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1dPZkic9Nd-NR1IvNvCq5Ualun-ybvmU&libraries=places"></script> <!-- Linea da sostituire con la tua chiave API -->
    <script>
        let mappa, marcatore, indirizzoIniziale, cittaIniziale, capIniziale, viaIniziale, civicoIniziale;

        function initMap() {
            mappa = new google.maps.Map(document.getElementById('mappa'), {
                center: {lat: 45.4642, lng: 9.1900}, // Default to Milan
                zoom: 12
            });
            marcatore = new google.maps.Marker({
                map: mappa,
                draggable: true
            });

            cittaIniziale = document.getElementById('citta').value;
            capIniziale = document.getElementById('cap').value;
            viaIniziale = document.getElementById('via').value;
            civicoIniziale = document.getElementById('civico').value;

            indirizzoIniziale = viaIniziale + ' ' + civicoIniziale + ', ' + cittaIniziale + ' ' + capIniziale;
            geocodeIndirizzo(indirizzoIniziale);
        }

        function geocodeIndirizzo(indirizzo) {
            const geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'address': indirizzo }, function(results, status) {
                if (status === 'OK') {
                    mappa.setCenter(results[0].geometry.location);
                    marcatore.setPosition(results[0].geometry.location);
                } else {
                    ripristinaCampi();
                    alert('Geocodifica non riuscita per il seguente motivo: ' + status);
                    document.getElementById('submitBtn').disabled = true; // Disabilita il pulsante se la geolocalizzazione non è riuscita
                }
            });
        }

        function validaForm() {
            const citta = document.getElementById('citta').value.trim();
            const cap = document.getElementById('cap').value.trim();
            const via = document.getElementById('via').value.trim();
            const civico = document.getElementById('civico').value.trim();
            const indirizzoCorrente = via + ' ' + civico + ', ' + citta + ' ' + cap;
            const isValid = citta && cap && via && civico && indirizzoCorrente !== indirizzoIniziale;

            document.getElementById('submitBtn').disabled = !isValid;
            if (isValid) {
                geocodeIndirizzo(indirizzoCorrente);
            }
        }

        function ripristinaCampi() {
            document.getElementById('citta').value = cittaIniziale;
            document.getElementById('cap').value = capIniziale;
            document.getElementById('via').value = viaIniziale;
            document.getElementById('civico').value = civicoIniziale;
        }
    </script>
</head>
<body onload="initMap()">
    <div class="contenitore">
        <h1>Modifica Sede</h1>
        <%
            Gestore gestore = new Gestore();
            gestore.loadDatabase();
            int idSede = Integer.parseInt(request.getParameter("id"));
            
            // Query per ottenere i dati della sede 
            String sql = "SELECT * FROM sedi WHERE id = " + idSede;
            ResultSet rs = gestore.getFunzioni().select(sql);
            String citta = "", cap = "", via = "", civico = "";
            if (rs.next()) {
                citta = rs.getString("citta");
                cap = rs.getString("cap");
                via = rs.getString("via");
                civico = rs.getString("civico");
            }
        %>
        <form action="controlloModificaSede.jsp" oninput="validaForm()" method="post">
            <input type="hidden" name="idSede" value="<%= idSede %>">
            <label for="citta">Città</label>
            <input type="text" id="citta" name="citta" value="<%= citta %>" required>

            <label for="cap">CAP</label>
            <input type="text" id="cap" name="cap" value="<%= cap %>" required>

            <label for="via">Via</label>
            <input type="text" id="via" name="via" value="<%= via %>" required>

            <label for="civico">Civico</label>
            <input type="text" id="civico" name="civico" value="<%= civico %>" required>

            <button type="submit" id="submitBtn" disabled>Salva Modifiche</button>
        </form>
        <div id="mappa"></div>
    </div>
</body>
</html>
