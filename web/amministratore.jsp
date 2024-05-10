<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pagina Amministrazione</title>
    <style>
        .container {
            text-align: center;
            margin-top: 20px;
        }

        button {
            margin: 5px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .gestore-parrucchieri {
            background-color: #4CAF50; /* Verde */
            color: white;
        }

        .gestore-clienti {
            background-color: #008CBA; /* Blu */
            color: white;
        }
    </style>
</head>
<body>
<h1>Pagina Amministrazione</h1>

<div class="container">
    <button type="button" class="gestore-parrucchieri" onclick="window.location.href='parrucchieri.jsp'">Gestore Parrucchieri</button>
    <button type="button" class="gestore-clienti" onclick="window.location.href='clienti.jsp'">Gestore Clienti</button>
</div>

</body>
</html>
