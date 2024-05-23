<%-- 
    Documento   : aggiungiSede
    Creato il   : 23-mag-2024, 18.13.11
    Autore      : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Aggiungi Sede</title>
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
        let mappa, marcatore;

        function initMap() {
            mappa = new google.maps.Map(document.getElementById('mappa'), {
                center: {lat: 45.4642, lng: 9.1900}, // Default to Milan
                zoom: 12
            });
            marcatore = new google.maps.Marker({
                map: mappa,
                draggable: true
            });
        }

        function geocodeIndirizzo() {
            const geocoder = new google.maps.Geocoder();
            const indirizzo = document.getElementById('via').value + ' ' +
                              document.getElementById('civico').value + ', ' +
                              document.getElementById('citta').value + ' ' +
                              document.getElementById('cap').value;

            geocoder.geocode({ 'address': indirizzo }, function(results, status) {
                if (status === 'OK') {
                    mappa.setCenter(results[0].geometry.location);
                    marcatore.setPosition(results[0].geometry.location);
                } else {
                    pulisciCampi();
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
            const isValid = citta && cap && via && civico;
            document.getElementById('submitBtn').disabled = !isValid;
            if (isValid) {
                geocodeIndirizzo();
            } else {
                document.getElementById('submitBtn').disabled = true; // Disabilita il pulsante se i dati non sono validi
            }
        }
    </script>
    <script>
        function pulisciCampi() {
            document.getElementById('citta').value = '';
            document.getElementById('cap').value = '';
            document.getElementById('via').value = '';
            document.getElementById('civico').value = '';
        }
    </script>
</head>
<body onload="initMap()">
    <div class="contenitore">
        <h1>Aggiungi Sede</h1>
        <form oninput="validaForm()">
            <label for="citta">Città</label>
            <input type="text" id="citta" name="citta" required>

            <label for="cap">CAP</label>
            <input type="text" id="cap" name="cap" required>

            <label for="via">Via</label>
            <input type="text" id="via" name="via" required>

            <label for="civico">Civico</label>
            <input type="text" id="civico" name="civico" required>

            <button type="button" id="submitBtn" disabled>Aggiungi Sede</button>
        </form>
        <div id="mappa"></div>
    </div>
</body>
</html>
