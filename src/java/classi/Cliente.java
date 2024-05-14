/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classi;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

/**
 *
 * @author Francesco
 */
public class Cliente {
    private StringProperty id;
    private StringProperty nome;
    private StringProperty cognome;
    private StringProperty telefono;
    
    
    public Cliente(String id, String nome, String cognome, String telefono){
        this.id = new SimpleStringProperty(id);
        this.nome =  new SimpleStringProperty(nome);
        this.cognome =  new SimpleStringProperty(cognome);
        this.telefono =  new SimpleStringProperty(telefono);
    }

    public StringProperty getId() {
        return id;
    }

    public void setId(StringProperty id) {
        this.id = id;
    }

    public StringProperty getNome() {
        return nome;
    }

    public void setNome(StringProperty nome) {
        this.nome = nome;
    }

    public StringProperty getCognome() {
        return cognome;
    }

    public void setCognome(StringProperty cognome) {
        this.cognome = cognome;
    }

    public StringProperty getTelefono() {
        return telefono;
    }

    public void setTelefono(StringProperty telefono) {
        this.telefono = telefono;
    }
    
    
}