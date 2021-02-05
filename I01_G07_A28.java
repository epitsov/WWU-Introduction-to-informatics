package g07;

/**
 * Klasse zur Repräsentation eines Konsolenregals.
 * Aufgabe 28, Blatt 10, Wintersemester 2020/21.
 * @author Übung I01 Gruppe G07
 */
public class Regal {
    /**
     * Dichte von Gold. (Die Schlüsselwörter "static final" wurden in der
     * Vorlesung noch nicht besprochen, sind aber ein gängiger Weg, um in Java
     * Konstanten zu definieren.)
     */
    public static final double DICHTE_GOLD = 19.32;

    /**
     * Dichte des verwendeten Eichenholz. (Die Schlüsselwörter "static final" 
     * wurden in der Vorlesung noch nicht besprochen, sind aber ein gängiger
     * Weg, um in Java Konstanten zu definieren.)
     */
    public static final double DICHTE_HOLZ = 0.71;

    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Hier Attribute hinzufügen.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    // TODO: Attribute vereinbaren.
    
    private double breite;
    private double hoehe;
    private double tiefe;
    private double dicke;
    private double durchmesser;
    private boolean massiv;

    /**
     * Konstruktor für ein Konsolenregal. Der Konstruktor erwartet fünf Werte, die die Breite, Höhe und Tiefe, die Dicke
     * der verwendeten Holzplatten sowie den Durchmesser der Aussparungen beschreiben. Der sechste Parameter gibt an, ob
     * es sich um ein massives Regal handelt. Alle Werte müssen beim Erzeugen eines Regals übergeben werden und sind
     * danach nicht veränderbar (--> keine Setter). Als Einheit aller Maße wird "cm" angenommen.
     *
     * @param breite      Breite des Regals.
     * @param hoehe       Höhe des Regals.
     * @param tiefe       Tiefe des Regals.
     * @param dicke       Dicke der verwendeten Holzplatten.
     * @param durchmesser Durchmesser der Aussparungen in der Rückwand.
     * @param massiv      Gibt an, ob das Regal aus massivem Gold ist.
     */
    public Regal(double breite, double hoehe, double tiefe, double dicke, double durchmesser, boolean massiv) {
        this.breite = breite;
        this.hoehe = hoehe;
        this.tiefe = tiefe;
        this.dicke = dicke;
        this.durchmesser = durchmesser;
        this.massiv = massiv;
    }

    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Platz für Getter-Methoden.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Rückgabe der Breite.
	 * @return Die Breite
	 */
	public double getBreite() {
		return breite;
	}

	/**
	 * Rückgabe der Höhe.
	 * @return Die Höhe
	 */
	public double getHoehe() {
		return hoehe;
	}

	/**
	 * Rückgabe der Tiefe.
	 * @return Die Tiefe
	 */
	public double getTiefe() {
		return tiefe;
	}

	/**
	 * Rückgabe der Dicke.
	 * @return Die Dicke
	 */
	public double getDicke() {
		return dicke;
	}

	/**
	 * Rückgabe des Durchmessers.
	 * @return Den Durchmesser
	 */
	public double getDurchmesser() {
		return durchmesser;
	}

	/**
	 * Rückgabe, ob das Regal massiv ist.
	 * @return Obs massiv ist.
	 */
	public boolean isMassiv() {
		return massiv;
	}

    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Platz für Methoden zur Volumenberechnung.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    /**
     * Berechnet das Volumen des in einem fertigen Regal enthaltenen Materials in cm^3, abgerundet auf drei
     * Nachkommastellen.
     * @return Volumen des Materials, das in einem Regal enthalten ist.
     */
    public double volumen() {
    	int stellen = 3;
    	double zahl = volumenPlatten() + volumenRueckwand()
    				- volumenLoecher() ;
        return roundN(zahl, stellen);
    }

    // Hilfsmethoden

    /**
     * Rundet eine Zahl auf eine gegebene Zahl Nachkommastellen.
     * Es werden ggfs. überzählige Stellen abgeschnitten
     * @param zahl Die zu rundende Zahl
     * @param stellen Die Stellen, die die Zahl haben soll.
     * @return Die gerundete Zahl
     */
    private double roundN (double zahl, int stellen) {
    	double b = (Math.pow(10, stellen));
    	double a = (zahl * b);
    	return Math.floor(a) / b;
    }
    
    /**
     * Berechnet das Volumen der kreisförmigen Löcher des Regals.
     * Später kann dieses Volumen vom Gesamtvolumen abgezogen werden,
     * um die Löcher zu berücksichtigen.
     * @return Das Volumen der Löcher.
     */
    private double volumenLoecher () {
    	return (((this.durchmesser / 2) * (this.durchmesser / 2)) * Math.PI) * this.dicke * 3;
    }
    
    /**
     * Berechnet das Volumen der Regalrückwand.
     * Dies geschieht ohne Berücksichtigung der Löcher.
     * @return Das Volumen der Rückwand.
     */
    private double volumenRueckwand () {
    	return this.breite * (this.hoehe + 2 * this.dicke) * this.dicke;
    }
    
    /**
     * Berechnet das Volumen der Regalplatten.
     * @return Das Volumen der Regalplatten.
     */
    private double volumenPlatten () {
    	return (2 * this.breite * this.tiefe * this.dicke)
    			+ (2 * this.hoehe * this.tiefe * this.dicke);
    }
    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Platz für Methoden zur Oberflächenberechnung.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    /**
     * Berechnet die sichtbare Oberfläche des fertig aufgebauten Regals in cm^2, abgerundet auf zwei Nachkommastellen.
     *
     * @return Oberfläche des fertig aufgebauten Regals.
     */
    public double flaeche() {
    	int stellen = 2;
    	double zahl = flaecheLoecher() + flaecheRueckwand() + flaecheVorne() + flaechePlatten();
    	return roundN(zahl, stellen);
    }

    // Hilfsmethoden
    
    /**
     * Berechnet die Flächenveränderung durch die Löcher.
     * Addiert die durch die Aussparung entstehende neue Fläche zu der
     * wegfallenden Fläche an der Rückwand.
     * @return Flächenveränderung durch die Löcher.
     */
    private double flaecheLoecher() {
    	return (((2 * Math.PI) * (this.durchmesser / 2)) * this.dicke * 3) /
    	((volumenLoecher() / this.dicke) * 2);
    }
    
    /**
     * Berechnet die Fläche der Rückwand.
     * @return Fläche der Rückwand.
     */
    private double flaecheRueckwand() {
    	return ((this.dicke * 2) + this.hoehe) * 2 * this.breite;
    }
    
    /**
     * Berechnet die Fläche der Vorderseite.
     * Das ist nur der vordere Rand der Platten.
     * @return Fläche der Vorderseite
     */
    private double flaecheVorne() {
    	return (this.hoehe + this.breite) * this.dicke * 2;
    }
    
    /**
     * Berechnet die Fläche der Platten.
     * Sowohl die innere, als auch die äußere Oberfläche.
     * @return Fläche der Platten
     */
    private double flaechePlatten() {
    	return ((this.breite * this.tiefe) + (this.hoehe * this.tiefe)) * 4;
    }
    
    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Platz für Methoden zur Massenberechnung.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

    /**
     * Berechnet die Masse eines Regals in kg, abgerundet auf zwei Nachkommastellen.
     *
     * @return Masse eines Regals.
     */
    public double masse() {
    	int stellen = 2;
    	
    	if(this.massiv) {
        	double zahl_g = volumen() * DICHTE_GOLD;
        	double zahl = gInKg(zahl_g);
        	return roundN(zahl, stellen);
    	}
    	else {
        	double zahl_g = flaeche() * 0.2 * DICHTE_GOLD + volumen() * DICHTE_HOLZ;
        	double zahl = gInKg(zahl_g);
        	return roundN(zahl, stellen);
    	}
    	   	
    }

    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     * Platz für weitere Hilfsfunktionen.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    
    /**
     * Rechnet ein Gewicht in g in kg um.
     * @param gewicht Gewicht in g
     * @return Gewicht in kg
     */
    private double gInKg(double gewicht) {
    	return gewicht / 1000;
    }
    /**
     * Abrunden einer gegebenen Zahl auf eine gegebene Anzahl an Nachkommastellen.
     *
     * @param x Abzurundende Zahl.
     * @param n Anzahl der erwünschten Nachkommastellen.
     * @return Auf n Nachkommastellen abgerundeter Wert von x.
     */
    public double round(double x, int n) {
        // TODO: Implementieren.
        return 0;
    }

}