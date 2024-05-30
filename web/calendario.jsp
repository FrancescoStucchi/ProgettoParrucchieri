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
        button {
            color: green;
        }
        .custom-event .fc-event-title {
            margin-top: 3px;
            margin-left: 10px;
            text-align: left;
            width: 100%;
            display: block;
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

            function fetchEvents(start, end, callback) {
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'fetchEvents.jsp?start=' + start.toISOString() + '&end=' + end.toISOString(), true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var events = JSON.parse(xhr.responseText);
                        callback(events);
                    }
                };
                xhr.send();
            }

            var calendar = new FullCalendar.Calendar(calendarEl, {
                displayEventTime: false,
                initialView: 'timeGridWeek',
                editable: false,
                slotMinTime: '08:00:00',
                slotMaxTime: '18:00:00',
                hiddenDays: [0],
                allDaySlot: false,
                events: function(info, successCallback, failureCallback) {
                    fetchEvents(info.start, info.end, function(events) {
                        events = events.map(event => {
                            event.classNames = ['custom-event'];
                            return event;
                        });
                        successCallback(events);
                    });
                },
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
                }
            });

            calendar.render();
        });
    </script>
    <div id="calendar"></div>
</body>
</html>
