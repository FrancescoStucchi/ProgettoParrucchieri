package ClassiJava;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ClassiJava.Utente;

public class UtenteManager {
    private Connection conn;

    public UtenteManager() {
        try {
            // Caricamento del driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connessione al database
            conn = DriverManager.getConnection("jdbc:mysql://localhost/itinerari", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Utente autenticaUtente(String username, String password) throws SQLException {
        String sql = "SELECT * FROM ciclista WHERE username=? AND password=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Utente utente = new Utente(rs.getString("username"),rs.getString("password"),rs.getString("cognome"),rs.getString("nome")
            );
            return utente;
        }
        }

        return null;
    }
    
//    public void aggiornaUtente(String username, String nuovoCognome, String nuovoNome, String nuovoLuogo, String nuovaDataNascita, String nuovaEmail) throws SQLException {
//        String sql = "UPDATE utenti SET cognome=?, nome=?, luogo=?, dataNascita=?, email=? WHERE username=?";
//        
//        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, nuovoCognome);
//            stmt.setString(2, nuovoNome);
//            stmt.setString(3, nuovoLuogo);
//            stmt.setString(4, nuovaDataNascita);
//            stmt.setString(5, nuovaEmail);
//            stmt.setString(6, username);
//
//            stmt.executeUpdate();
//        }
//    }
    

    public void chiudiConnessione() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }
}