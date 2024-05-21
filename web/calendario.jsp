<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario con JSP</title>
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css' rel='stylesheet' />
    <!-- FullCalendar JS -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>
    <!-- Inizializzazione del calendario -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                editable: true,
                dateClick: function(info) {
                    var title = prompt('Inserisci il titolo dell\'evento:');
                    if (title) {
                        calendar.addEvent({
                            title: title,
                            start: info.dateStr,
                            allDay: true
                        });
                    }
                },
                events: [
                    {
                        title: 'Evento 1',
                        start: '2023-05-01'
                    },
                    {
                        title: 'Evento 2',
                        start: '2023-05-07',
                        end: '2023-05-10'
                    },
                    {
                        title: 'Evento 3',
                        start: '2023-05-09T16:00:00'
                    }
                ]
            });

            calendar.render();
        });
    </script>
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
            width: 700px;
            height: 600px;
            margin: 900px auto;
            padding: 0 10px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

    </style>
</head>
<body>
    <div id="calendar"></div>
</body>
</html>
