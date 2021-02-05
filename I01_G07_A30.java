package g07;
/**
 * Umrechnung einer Zahl im Bereich [0..99] in ihre textuelle
 * deutschsprachige Repräsentation.
 * Aufgabe 30, Blatt 10, Wintersemester 2020/21
 * @author Übung I01 Gruppe G07
 */
public class ZahlumwandlungDeutsch {

	/**
	 * Gegeben eine ganze Zahl im Bereich von 0..99, bestimme die
	 * textuelle Repräsentation dieser Zahl in der deutschen
	 * Sprache.
	 * @param zahl  Umzuwandelnde Zahl.
	 * @return Textuelle Repräsentation der Zahl.
	 */
	public String wandeleZahlUm(int zahl) {
		
		if (zahl < 0 || zahl > 99) {
			return ""; // Hier sollte eigentlich eine Exception ausgegeben werden, leider durften
			// wir die Signatur nicht verändern. \_(ツ)_/¯
		}
		
		// Initialisierung von Variablen
		String ausgabe = null; // Der String, der später ausgegeben wird.

		int einer = zahl % 10; // Die Einerstelle
		int zehner = (zahl - einer)/10; // Die Zehnerstelle
		//

		ausgabe = wandeleZifferUm(einer); // ausgabe ist jetzt textuelle Repräsentation der Einerstelle

		if (zehner >= 2 && einer != 0) {
			if (ausgabe == "eins") {ausgabe = "ein";}; // Ausnahme für zweistellige Zahlen
			ausgabe = ausgabe + "und"; // für zweistellige Zahlen außer den teens
		}

		ausgabe = ausgabe + wandeleZehnerUm(zehner); // textuelle Repräsentation der Zehnerstelle angehangen
		
		// Sonderfälle
		switch (zahl) {
		case 0 : ausgabe = "null"; break;
		case 11 : ausgabe = "elf"; break;
		case 12 : ausgabe = "zwoelf"; break;
		case 16 : ausgabe = "sechzehn"; break;
		case 17 : ausgabe = "siebzehn"; break;
		}
		return ausgabe; // Ausgabe
	}
	
	/**
	 * Wandelt eine Ziffer im Bereich 0..9 in deutschen Text um.
	 * Null ist hierbei ein leerer String.
	 * @param einer Die Ziffer
	 * @return Den deutschen Text
	 */
	public String wandeleZifferUm(int einer) {
		String[] einerStelle = {"", "eins", "zwei", "drei",
				"vier", "fuenf", "sechs",
				"sieben", "acht", "neun"};

		return einerStelle[einer];
	}
	
	/**
	 * Wandelt eine Zehnerstelle im Bereich 0..9 in deutschen Text um.
	 * Null ist hierbei ein leerer String.
	 * @param zehner Die Zehnerstelle
	 * @return Den deutschen Text
	 */
	public String wandeleZehnerUm(int zehner) {

		String[] zehnerStelle = {"", "zehn", "zwanzig", "dreissig",
				"vierzig", "fuenfzig", "sechzig",
				"siebzig", "achtzig", "neunzig"};

		return zehnerStelle[zehner];
	}
}
