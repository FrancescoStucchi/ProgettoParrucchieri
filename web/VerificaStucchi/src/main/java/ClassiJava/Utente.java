/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClassiJava;



/**
 *
 * @author 5binfo
 */
public class Utente {
    private String username;
    private String password;
    private String cognome;
    private String nome;
    
     public Utente(String username, String password, String cognome, String nome) {
        this.password = password;
        this.cognome = cognome;
        this.nome = nome;
    }

   

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
}
