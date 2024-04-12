/*
 * Created on 29-ott-2004
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package ClassiJava;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;



/**
 * @author depietro
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
/**
 * @author depietro
 *
 * Attenzione modificare i parametri di connessione.
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class FunzioniDB {

	private Connection cn;
	private String connectionString;

	public FunzioniDB(String connectionString, String user, String password){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            cn = DriverManager.getConnection(connectionString,user,password);

        } catch (SQLException ex) {
        	saveLogError("FunzioniDB.FunzioniDB", ex.getMessage());
        } catch (ClassNotFoundException ex) {
        	saveLogError("FunzioniDB.FunzioniDB", ex.getMessage());

        }

	}




	public String fc(String campo)
	{
		campo="'"+ campo.replaceAll("'","''")+ "'";
		return campo;
	}

	public String nn(String campo){
		if (campo==null) campo="";
	    if (campo.equals("null")) campo="";
	    return campo;
	}



	/**Funzione di conversione date.
	 * @param data Accetta una data nel formato gg/mm/aaaa. Accetta anche date nel formato gg-mmm-aaaa esempio 8-giu-2005
	 * @return Restituisce la data nel formato aaaa-mm-gg
	 */
	public String cvData(String data)
        {
            if (data.contains("-"))
            {
                String param[]=data.split("-");
                String mese="";
                if (param[0].length()==1) param[0]="0"+param[0];
                switch( param[1])
                {
                    case "gen":
                            mese="01";
                            break;
                    case "feb":
                            mese="02";
                            break;
                    case "mar":
                            mese="03";
                            break;
                    case "apr":
                            mese="04";
                            break;
                    case "mag":
                            mese="05";
                            break;
                    case "giu":
                            mese="06";
                            break;
                    case "lug":
                            mese="07";
                            break;
                    case "ago":
                            mese="08";
                            break;
                    case "set":
                            mese="09";
                            break;
                    case "ott":
                            mese="10";
                            break;
                    case "nov":
                            mese="11";
                            break;
                    case "dic":
                            mese="12";
                            break;
                }
                return param[2]+mese+param[0];
            }
            else
            {
                String param[]=data.split("/");
                //return param[2]+"-"+param[1]+"-"+param[0];
                if (param[1].length()==1) param[1]="0"+param[1];
                if (param[0].length()==1) param[0]="0"+param[0];
                return param[2]+param[1]+param[0];
            }

	}

	/**Funzione di conversione date.
	 * @param data Accetta una data nel formato aaaa-mm-gg
	 * @return Restituisce la data nel formato gg/mm/aaaa
	 */
	public String cvDataIta(String data){
	    //return data.substring(6)+"/"+data.substring(4,6)+"/"+data.substring(0,4);
	    String param[]=data.split("-");
            return param[2]+"/"+param[1]+"/"+param[0];
	}

        /**
         * Metodo che accetta un anno nel formato gg/mm/aa e lo restituisce nel formato gg/mm/aaaa
         * Il confronto viene fatto sulle due cifre, se superano 50 allora viene aggiunto 19 altrimenti 20
         * @param data
         * @return
         */
        public String anno2CifreToAnno4Cifre(String data)
        {
            if(data.length()==10)
                return data;

            int anno=Integer.parseInt(data.substring(data.lastIndexOf("/")+1));
            if (anno>50)
                anno=1900+anno;
            else
                anno=2000+anno;
            String dataModificata=data.substring(0, data.lastIndexOf("/")+1)+Integer.toString(anno);

            return dataModificata;
        }
        
        public void executeQuery(String sql)
        {
            Statement stmt;
            try {

                     stmt = cn.createStatement();
                     stmt.execute(sql);
                     stmt.close();
                     //pool.freeConnection(cn);
                    }
            catch (Exception e) {
                    // TODO Auto-generated catch block
                    saveLogError("FunzioniDB.select", e.getMessage());
            }
	}

	public ResultSet select(String sql)
        {
            ResultSet rs;
            Statement stmt;
            try {

                     stmt = cn.createStatement();
                     rs=stmt.executeQuery(sql);
                     //stmt.close();
                     //pool.freeConnection(cn);
                     return rs;
                    }
            catch (Exception e) {
                    // TODO Auto-generated catch block
                    saveLogError("FunzioniDB.select", e.getMessage());
                    return null;
            }

	}

	public void closeConnection() throws SQLException{
		cn.close();
	}

	public ResultSet selectDynamic(String sql)
        {
            ResultSet rs;
            Statement stmt;
            try {

                     stmt = cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                 ResultSet.CONCUR_UPDATABLE);
                     rs=stmt.executeQuery(sql);
                     //stmt.close();

                     return rs;
                    }
            catch (Exception e) {
                    // TODO Auto-generated catch block
                    saveLogError("FunzioniDB.selectDynamic", e.getMessage());
                    return null;
            }

	}

	public boolean update(String sql)
        {
            Statement stmt;
            try{
                    int righeModificate;
                //modifica i dati

                    stmt = cn.createStatement();
                    righeModificate=stmt.executeUpdate(sql);
                    stmt.close();

                    if (righeModificate==0) return false;
                    else return true;
            }
            catch (Exception e){
                    saveLogError("FunzioniDB.update", e.getMessage());
                    return false;
            }

	}

	/**Funzione di aggiornamento dati.
	 * @param campi Array di stringhe contenente tutti i nomi dei campi.
	 * @param valori Array di stringhe contenente tutti i valori dei campi.
	 * @param tabella Il nome della tabella interessata dalla query.
	 * @param inserimento Indicare true se si vuole eseguire una INSERT, false se si vuole eseguire un UPDATE.
	 * @param codiceAutoIncrement Valore booleano. Indicare true se la chiave primaria � autoincrementante e quindi non va inserita nella query sql di inserimento
	 * @return Restituisce un valore booleano che indica se l'operazione � andata a buon fine.
	 */
	public boolean update (String[] campi,String[] valori,String tabella,boolean inserimento,boolean codiceAutoIncrement)
        {
            String sql;
            byte i;
            byte inizio;

            if (codiceAutoIncrement)
            {
                inizio=1;
            }
            else
            {
                inizio=0;
            }

            if (inserimento)
            {
                //inserimento
                sql="INSERT INTO "+tabella+" (";
                for (i=inizio;i<(campi.length)-1;i++)
                {
                        sql+=campi[i]+",";
                }
                sql+=campi[i]+") VALUES (";

                for (i=inizio;i<(valori.length)-1;i++)
                {
                        sql+=valori[i]+",";
                }
                sql+=valori[i]+")";
            }

            else
            {
                //aggiornamento
                sql="UPDATE "+tabella+" SET ";
                for (i=1;i<(valori.length)-1;i++)
                {
                        sql+=campi[i]+"="+valori[i]+",";
                }
                sql+=campi[i]+"="+valori[i]+" WHERE "+campi[0]+"="+valori[0];
            }

            return update(sql);

	}


    public Connection getConnection() {
        return cn;
    }

    public String getConnectionString() {
        return connectionString;
    }




    /**
     *  *
     *
     * Metodo che verifica se un record � gi� presente.
     * @param sql Query di interrogazione. Preferibilmente con ricerca su chiave primaria
     * @return true se il record esiste altrimenti false
     */

	public boolean verificaEsistente(String sql)
        {
            ResultSet rs=select(sql);
            try {
                if (rs.next())
                    return true;
                else
                    return false;
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            return false;

	}

	public void saveLogError(String classeMetodo, String messaggio)
        {
            LocalDateTime data=LocalDateTime.now();
            messaggio.replace('\n', ' ');
            messaggio.replace('\n', ' ');
            DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
            String rigaLog="\n"+data.format(formatter)+" - "+ classeMetodo + " - "+ messaggio;
            try {
                    FileWriter file=new FileWriter(System.getProperty("user.dir")+"\\error.log",true);
                    file.append(rigaLog);
                    file.close();
            } catch (IOException e) {
                    // TODO Auto-generated catch block
                    System.out.println("Errore salvataggio su errorLog");
            }

	}

	public static void saveLogErrorStatic(String classeMetodo, String messaggio)
        {
            LocalDateTime data=LocalDateTime.now();
            messaggio.replace('\n', ' ');
            messaggio.replace('\n', ' ');
            DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
            String rigaLog="\n"+data.format(formatter)+" - "+ classeMetodo + " - "+ messaggio;
            try {
                    FileWriter file=new FileWriter(System.getProperty("user.dir")+"\\error.log",true);
                    file.append(rigaLog);
                    file.close();
            } catch (IOException e) {
                    // TODO Auto-generated catch block
                    System.out.println("Errore salvataggio su errorLog");
            }

	}








}
