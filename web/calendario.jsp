<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario settimanale con JSP</title>
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css' rel='stylesheet' />
    <!-- FullCalendar JS -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Inizializzazione del calendario -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }
        #calendar {
            max-width: 6000px;
            width: 90%; /* Modificato da 700px a 90% */
            height: 570px;
            margin: 0 auto; /* Modificato da 900px a 0 */
            padding: 0 10px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        button{
            color: green;
        }
    </style>
</head>
<body>
    <%
        session.setAttribute("id_servizio", request.getParameter("servizioSelect"));
    %>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                displayEventTime: false,
                initialView: 'timeGridWeek', // Vista settimanale
                editable: true,
                slotMinTime: '08:00:00', // Inizio alle 8:00
                slotMaxTime: '18:00:00', // Fine alle 18:00
                hiddenDays: [0], // Nasconde la domenica (0 è domenica, 1 è lunedì, ecc.)
                allDaySlot: false, // Rimuove gli slot per eventi di tutta la giornata
                eventClick: function(info) {
                    var day = info.event.start.toLocaleDateString();
                    var startTime = info.event.start.toLocaleTimeString();
                    var endTime = info.event.end.toLocaleTimeString();
                    var id = info.event.id;

                    Swal.fire({
                        title: 'Conferma',
                        text: 'Confermare la prenotazione del ' + day + ' dalle ' + startTime + ' alle ' + endTime + '?',
                        showCancelButton: true,
                        confirmButtonText: 'Conferma',
                        cancelButtonText: 'Annulla'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'confermaAppuntamento.jsp?giorno=' + encodeURIComponent(day) + 
                                                   '&oraInizio=' + encodeURIComponent(startTime) + 
                                                   '&idParrucchiere=' + encodeURIComponent(id) + 
                                                   '&oraFine=' + encodeURIComponent(endTime);
                        }
                    });
                },
                events: [
                    <%
                        Gestore gestore = new Gestore();
                        gestore.loadDatabase();
                        LocalDate currentDate = LocalDate.now();
                        DayOfWeek lastDayOfWeek = DayOfWeek.SUNDAY;
                        DayOfWeek currentDayOfWeek = currentDate.getDayOfWeek();
                        Time durata = null;
                        String sql = "SELECT durata FROM servizi WHERE id=" + session.getAttribute("id_servizio") + ";";
                        ResultSet rs = gestore.getFunzioni().select(sql);
                        if (rs.next()) {
                            durata = rs.getTime("durata");
                        }
                        int hours = durata.getHours();
                        int minutes = durata.getMinutes();
                        double durataInOre = hours + (minutes / 60.0);
                        int cicliMattina = (int) Math.floor(4.0 / durataInOre);
                        int cicliPomeriggio = (int) Math.floor(5.0 / durataInOre);
                        boolean occupato = false;

                        sql = "SELECT id_parrucchiere FROM capacita INNER JOIN parrucchieri ON parrucchieri.id=capacita.id_parrucchiere WHERE id_servizio=" + session.getAttribute("id_servizio") + " AND id_sede='"+session.getAttribute("id_sede")+"';";
                        rs = gestore.getFunzioni().select(sql);
                        boolean firstEvent = true;
                        while (rs.next()) {
                            int id_parrucchiere = rs.getInt("id_parrucchiere");
                            while(!currentDayOfWeek.equals(lastDayOfWeek.minus(1))){
                                String sqlTurno = "SELECT turni.id, parrucchieri.cognome FROM turni INNER JOIN svolge ON turni.id=svolge.id_turno INNER JOIN parrucchieri ON svolge.id_parrucchiere=parrucchieri.id WHERE svolge.id_parrucchiere=" + rs.getInt("id_parrucchiere") + " AND ora_inizio='08:00:00' AND giorno='" + currentDayOfWeek + "'";
                                ResultSet rsTurno = gestore.getFunzioni().select(sqlTurno);
                                if (rsTurno.next()) {
                                    String cognome = rsTurno.getString("cognome");
                                    LocalTime orarioInizio = LocalTime.parse("08:00:00", DateTimeFormatter.ofPattern("HH:mm:ss"));
                                    LocalTime orarioFine = orarioInizio.plusHours(hours).plusMinutes(minutes);
                                    for (int i = 0; i < cicliMattina; i++) {
                                        occupato = false; // Reset `occupato` to false for each cycle
                                        String sqlOccupato = "SELECT appuntamenti.ora, durata FROM impegno INNER JOIN appuntamenti ON impegno.id_appuntamento= appuntamenti.id WHERE impegno.id_parrucchiere="+id_parrucchiere+" AND appuntamenti.`data`='"+currentDate+"';";
                                        ResultSet rsOccupato = gestore.getFunzioni().select(sqlOccupato);
                                        while(rsOccupato.next()){
                                            LocalTime oraInizioAppuntamento = LocalTime.parse(rsOccupato.getTime("ora").toString());
                                            LocalTime oraFineAppuntamento = oraInizioAppuntamento.plusHours(rsOccupato.getTime("durata").getHours()).plusMinutes(rsOccupato.getTime("durata").getMinutes());

                                            // Check for overlapping intervals
                                            if((orarioInizio.isBefore(oraFineAppuntamento) && orarioFine.isAfter(oraInizioAppuntamento)) || 
                                               (oraInizioAppuntamento.isBefore(orarioFine) && oraFineAppuntamento.isAfter(orarioInizio)) || 
                                               (orarioInizio.equals(oraInizioAppuntamento) && orarioFine.equals(oraFineAppuntamento))) {
                                                occupato = true;
                                                break;
                                            }
                                        }
                                        if(!occupato) {
                                            if (!firstEvent) {
                                                out.print(",");
                                            }
                                            firstEvent = false;
                                            out.print("{");
                                            out.print("title: '" + cognome + "',");
                                            out.print("start: '"+currentDate+"T"+orarioInizio+"',");
                                            out.print("end: '"+currentDate+"T"+orarioFine+"',");
                                            out.print("id: '" + id_parrucchiere + "'");
                                            out.print("}");
                                        }
                                        orarioInizio = orarioInizio.plusHours(hours).plusMinutes(minutes);
                                        orarioFine = orarioFine.plusHours(hours).plusMinutes(minutes); 
                                    }
                                }
                                // Codice simile per il turno pomeridiano...
                                currentDate = currentDate.plusDays(1);
                                currentDayOfWeek = currentDate.getDayOfWeek();
                            }
                        }
                    %>
                ]
            });

            calendar.render();
        });
    </script>
    <div id="calendar"></div>
</body>
</html>
