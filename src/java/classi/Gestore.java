package classi;


import classi.FunzioniDB;


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


public class Gestore {    
    private FunzioniDB funzioni = null;
    
    public void loadDatabase(){
        funzioni = new FunzioniDB("jdbc:mysql://localhost/parrucchieridb", "root", "");
    }
    // Metodo getter per ottenere l'oggetto funzioni
    public FunzioniDB getFunzioni() {
        return funzioni;
    }
    
    
    public void controlloCredenziali(){
        
    }
}

