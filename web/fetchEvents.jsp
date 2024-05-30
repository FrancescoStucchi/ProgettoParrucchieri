<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.sql.Time"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="classi.Gestore"%>
<%@page contentType="application/json" %>
<%
    LocalDate start = LocalDate.parse(request.getParameter("start").substring(0, 10));
    LocalDate end = LocalDate.parse(request.getParameter("end").substring(0, 10));

    Gestore gestore = new Gestore();
    gestore.loadDatabase();
    
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

    StringBuilder json = new StringBuilder("[");
    boolean firstEvent = true;

    while (rs.next()) {
        int id_parrucchiere = rs.getInt("id_parrucchiere");
        LocalDate currentDate = start;
        while (!currentDate.isAfter(end)) {
            DayOfWeek currentDayOfWeek = currentDate.getDayOfWeek();
            String sqlTurno = "SELECT turni.id, parrucchieri.cognome FROM turni INNER JOIN svolge ON turni.id=svolge.id_turno INNER JOIN parrucchieri ON svolge.id_parrucchiere=parrucchieri.id WHERE svolge.id_parrucchiere=" + rs.getInt("id_parrucchiere") + " AND ora_inizio='08:00:00' AND giorno='" + currentDayOfWeek + "'";
            ResultSet rsTurno = gestore.getFunzioni().select(sqlTurno);
            if (rsTurno.next()) {
                String cognome = rsTurno.getString("cognome");
                LocalTime orarioInizio = LocalTime.parse("08:00:00", DateTimeFormatter.ofPattern("HH:mm:ss"));
                LocalTime orarioFine = orarioInizio.plusHours(hours).plusMinutes(minutes);
                for (int i = 0; i < cicliMattina; i++) {
                    occupato = false;
                    String sqlOccupato = "SELECT appuntamenti.ora, durata FROM impegno INNER JOIN appuntamenti ON impegno.id_appuntamento= appuntamenti.id WHERE impegno.id_parrucchiere="+id_parrucchiere+" AND appuntamenti.`data`='"+currentDate+"';";
                    ResultSet rsOccupato = gestore.getFunzioni().select(sqlOccupato);
                    while(rsOccupato.next()){
                        LocalTime oraInizioAppuntamento = LocalTime.parse(rsOccupato.getTime("ora").toString());
                        LocalTime oraFineAppuntamento = oraInizioAppuntamento.plusHours(rsOccupato.getTime("durata").getHours()).plusMinutes(rsOccupato.getTime("durata").getMinutes());
                        if((orarioInizio.isBefore(oraFineAppuntamento) && orarioFine.isAfter(oraInizioAppuntamento)) || 
                           (oraInizioAppuntamento.isBefore(orarioFine) && oraFineAppuntamento.isAfter(orarioInizio)) || 
                           (orarioInizio.equals(oraInizioAppuntamento) && orarioFine.equals(oraFineAppuntamento))) {
                            occupato = true;
                            break;
                        }
                    }
                    if(!occupato) {
                        if (!firstEvent) {
                            json.append(",");
                        }
                        firstEvent = false;
                        json.append("{");
                        json.append("\"title\":\"").append(cognome).append("\",");
                        json.append("\"start\":\"").append(currentDate).append("T").append(orarioInizio).append("\",");
                        json.append("\"end\":\"").append(currentDate).append("T").append(orarioFine).append("\",");
                        json.append("\"id\":\"").append(id_parrucchiere).append("\"");
                        json.append("}");
                    }
                    orarioInizio = orarioInizio.plusHours(hours).plusMinutes(minutes);
                    orarioFine = orarioFine.plusHours(hours).plusMinutes(minutes); 
                }
            }
            sqlTurno = "SELECT turni.id, parrucchieri.cognome FROM turni INNER JOIN svolge ON turni.id=svolge.id_turno INNER JOIN parrucchieri ON svolge.id_parrucchiere=parrucchieri.id WHERE svolge.id_parrucchiere=" + rs.getInt("id_parrucchiere") + " AND ora_inizio='13:00:00' AND giorno='" + currentDayOfWeek + "'";
            rsTurno = gestore.getFunzioni().select(sqlTurno);
            if (rsTurno.next()) {
                String cognome = rsTurno.getString("cognome");
                LocalTime orarioInizio = LocalTime.parse("13:00:00", DateTimeFormatter.ofPattern("HH:mm:ss"));
                LocalTime orarioFine = orarioInizio.plusHours(hours).plusMinutes(minutes);
                for (int i = 0; i < cicliPomeriggio; i++) {
                    occupato = false;
                    String sqlOccupato = "SELECT appuntamenti.ora, durata FROM impegno INNER JOIN appuntamenti ON impegno.id_appuntamento= appuntamenti.id WHERE impegno.id_parrucchiere="+id_parrucchiere+" AND appuntamenti.`data`='"+currentDate+"';";
                    ResultSet rsOccupato = gestore.getFunzioni().select(sqlOccupato);
                    while(rsOccupato.next()){
                        LocalTime oraInizioAppuntamento = LocalTime.parse(rsOccupato.getTime("ora").toString());
                        LocalTime oraFineAppuntamento = oraInizioAppuntamento.plusHours(rsOccupato.getTime("durata").getHours()).plusMinutes(rsOccupato.getTime("durata").getMinutes());
                        if((orarioInizio.isBefore(oraFineAppuntamento) && orarioFine.isAfter(oraInizioAppuntamento)) || 
                           (oraInizioAppuntamento.isBefore(orarioFine) && oraFineAppuntamento.isAfter(orarioInizio)) || 
                           (orarioInizio.equals(oraInizioAppuntamento) && orarioFine.equals(oraFineAppuntamento))) {
                            occupato = true;
                            break;
                        }
                    }
                    if(!occupato) {
                        if (!firstEvent) {
                            json.append(",");
                        }
                        firstEvent = false;
                        json.append("{");
                        json.append("\"title\":\"").append(cognome).append("\",");
                        json.append("\"start\":\"").append(currentDate).append("T").append(orarioInizio).append("\",");
                        json.append("\"end\":\"").append(currentDate).append("T").append(orarioFine).append("\",");
                        json.append("\"id\":\"").append(id_parrucchiere).append("\"");
                        json.append("}");
                    }
                    orarioInizio = orarioInizio.plusHours(hours).plusMinutes(minutes);
                    orarioFine = orarioFine.plusHours(hours).plusMinutes(minutes); 
                }
            }
            currentDate = currentDate.plusDays(1);
        }
    }

    json.append("]");
    out.print(json.toString());
%>
