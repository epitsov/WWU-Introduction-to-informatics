package g07;
/**
 * Klasse zur Repräsentation eines gekürzten Dezimalbruchs.
 * Aufgabe 29, Blatt 10, Wintersemester 2020/21.
 * @author Übung I01 Gruppe G07
 */

public class Bruch {

	// Attributvereinbarungen
	private int nenner; //Der Nenner des Bruchs
	private int zaehler; //Der Zähler des Bruchs
	private double wert; //Der Dezimalwert des Bruchs

	// Konstruktoren

	/**
	 * Default-Konstrukor: erzeugt Bruch mit Wert 1.
	 * Nenner und Zaehler werden entsprechend gesetzt
	 */
	public Bruch() {
		this.zaehler = 1;
		this.nenner = 1;
		this.wert = berechneWert();	
		this.kuerzen();
	}

	/**
	 * Konstruktor für ganzzahliges Argument.
	 * Erzeugt Bruch mit Wert des Arguments.
	 * Nenner und Zaehler werden entsprechend gesetzt.
	 * @param x Der ganzzahlige Wert
	 */
	public Bruch(int x) {
		this.zaehler = x;
		this.nenner = 1;
		this.wert = berechneWert();
		this.kuerzen();
	}

	/**
	 * Konstruktor für zwei ganzzahlige Argumente.
	 * Erzeugt Bruch mit Wert des Nenners und Zaehlers.
	 * Zudem werden Nenner und Zaehler entsprechend gesetzt.
	 * @param x Der Zaehler
	 * @param y Der Nenner
	 */
	public Bruch(int x, int y) {
		if (y == 0) {
			throw new IllegalArgumentException("Nenner ist 0: Division durch 0 nicht möglich.");
		}
		this.zaehler = x;
		this.nenner = y;
		this.wert = berechneWert();
		
	}

	// Methoden

	/**
	 * Berechnet den Wert eines Bruchs.
	 * @return Wert des Bruchs.
	 */
	public double berechneWert() {
		return this.zaehler / (double)this.nenner;
	}

	//Rechenoperationen nach der "Schulmethode"

	/**
	 * Addition: Addiert zwei Brüche.
	 * Das Bruchobjekt wird zu Bruch b2 addiert.
	 * @param b2 Bruch Nr.2
	 * @return Ergebnis der Addition als Bruch
	 */
	public Bruch addition(Bruch b2) {
		//gemeinsamer Nenner
		int gemNen = this.nenner * b2.getNenner();
		Bruch b3 = new Bruch(gemNen);
		//erweiterte Brüche
		Bruch dieserErweitert = this.multiplikation(b3);
		Bruch b2Erweitert = b2.multiplikation(b3);
		//addierter Bruch
		int addiertZaehler = dieserErweitert.getZaehler() + b2Erweitert.getZaehler();
		int addiertNenner = dieserErweitert.getNenner() + b2Erweitert.getNenner();

		Bruch out = new Bruch(addiertZaehler, addiertNenner);
		return out.kuerzen();
	}

	/**
	 * TODO Subtraktion: Subtrahiert zwei Brüche.
	 * Bruch b2 wird von dem Bruchobjekt subtrahiert.
	 * @param b2 Bruch Nr.2
	 * @return Ergebnis der Subtraktion als Bruch
	 */
	public Bruch subtraktion(Bruch b2) {
		Bruch b3 = new Bruch(-1);
		Bruch out = this.addition(b2.multiplikation(b3));
		return out.kuerzen();
	}

	/**
	 * Multiplikation: Multipliziert zwei Brüche.
	 * Das Bruchobjekt wird mit Bruch b2 multipliziert
	 * @param b2 Bruch Nr.2
	 * @return Ergebnis der Multiplikation als Bruch
	 */
	public Bruch multiplikation(Bruch b2) {
		zaehler = this.zaehler * b2.getZaehler();
		nenner = this.nenner * b2.getNenner();
		Bruch out = new Bruch(zaehler, nenner);
		return out.kuerzen();
	}


	/**
	 * Division: Dividiert zwei Brüche.
	 * Das Bruchobjekt wird durch Bruch b2 dividiert.
	 * @param b2 Bruch Nr. 2
	 * @return Ergebnis der Division als Bruch
	 */
	public Bruch division(Bruch b2) {
		Bruch b2k = new Bruch(b2.getNenner(), b2.getZaehler()); // Kehrwert als Bruch
		return this.multiplikation(b2k);
	}

	/**
	 * Kürzen: Kürzt den Bruch.
	 * Das Bruchobjekt wird so modifiziert, dass Zähler und Nenner teilerfremd sind.
	 * @return Den gekürzten Bruch.
	 */
	public Bruch kuerzen() {
		int divisor = ggT(this.zaehler, this.nenner);
		return new Bruch(this.zaehler/divisor, this.nenner/divisor);
	}

	/**
	 * Berechnet größten gemeinsamen Teiler zweier ganzzahliger Werte
	 * @param a Wert Nr.1
	 * @param b Wert Nr.2
	 * @return größter gemeinsamer Teiler
	 */
	public int ggT(int a, int b) {
		if (b == 0) {
			return a;
		} else {
			return ggT(b, a%b);
		}
	}
	
	
	// Getter & Setter
	/**
	 * Rückgabe des Werts.
	 * @return Den Wert des Bruch
	 */
	public double getWert() {
		return wert;
	}

	/**
	 * Rückgabe des Zaehlers.
	 * @return Den Zaehler
	 */
	public int getZaehler() {
		return zaehler;
	}

	/**
	 * Rückgabe des Nenners.
	 * @return Den Nenner
	 */
	public int getNenner() {
		return nenner;
	}

	/**
	 * Setzt den Nenner des Bruchs und kürzt dann ggfs.
	 * @param Nenner Der neue Nenner des Bruchs.
	 */
	public void setNenner(int nenner) {
		// Beispiel zur Behandlung eines ungueltigen Parameters.
		if (nenner == 0) {
			throw new IllegalArgumentException("Nenner muss von Null verschieden sein.");
		}

		this.nenner = nenner;
		this.wert = berechneWert();
		this.kuerzen();
	}
	
	/**
	 * Setzt den Zähler des Bruchs und kürzt dann ggfs.
	 * @param Zähler Der neue Zähler des Bruchs.
	 */
	public void setZaehler(int zaehler) {
		// Beispiel zur Behandlung eines ungueltigen Parameters.
		if (nenner == 0) {
			throw new IllegalArgumentException("Zähler muss von Null verschieden sein.");
		}

		this.zaehler = zaehler;
		this.wert = berechneWert();
		this.kuerzen();
	}

}