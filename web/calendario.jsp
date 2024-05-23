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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'timeGridWeek', // Vista settimanale
                editable: true,
                slotMinTime: '08:00:00', // Inizio alle 8:00
                slotMaxTime: '18:00:00', // Fine alle 18:00
                hiddenDays: [0], // Nasconde la domenica (0 è domenica, 1 è lunedì, ecc.)
                allDaySlot: false, // Rimuove gli slot per eventi di tutta la giornata
                eventClick: function(info){
                    var startTime = info.event.start;
                    var endTime = info.event.end;
                        Swal.fire({
                        title: 'Conferma',
                        text: 'Confermare la prenotazione del ' + startTime.toLocaleDateString() + ' dalle ' + startTime.toLocaleTimeString(2) + ' alle ' + endTime.toLocaleTimeString() + '?',
                        showCancelButton: true,
                        confirmButtonText: 'Conferma',
                        cancelButtonText: 'Annulla'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'confermaAppuntamento.jsp?startTime='+encodeURIComponent(startTime.toString());
                        }
                    });
                },
                events: [
                    {
                        title: 'Evento 1',
                        start: '2024-05-23T10:00:00',
                        end: '2024-05-23T12:00:00'
                    },
                ]
            });

            calendar.render();
        });
    </script>
    <div id="calendar"></div>
</body>
</html>
