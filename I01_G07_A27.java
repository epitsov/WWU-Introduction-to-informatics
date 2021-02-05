package uebungen;

/**
 * Modellierung eines Avengers mit Alter Ego.
 * Aufgabe 27, Blatt 09, Wintersemester 2020/21.
 * @author Übung I01 Gruppe G0
 */
public class Avenger {
	
	//Attribute
	private String superheldenName;
	private String alterEgoName;
	private boolean superheld;
	private float superheldenKraft = 100f;

	
	//set-a/get-a Methoden 
	
	/**
	 * Setzt den Namen des Avengers
	 * @param superheldenName Zu setzender Name
	 */
	public void setSuperheldenName(String superheldenName) {
		this.superheldenName = superheldenName;
	}

	/**
	 * Setzt den Namen des Alter Egos des Avengers
	 * @param alterEgoName Zu setzender Name
	 */
	public void setAlterEgoName(String alterEgoName) {
		this.alterEgoName = alterEgoName;
	}

	/**
	 * Gibt die Superheldenkraft des Avengers zurück
	 * @return die superheldenKraft
	 */
	public float getSuperheldenKraft() {
		return superheldenKraft;
	}

	/**
	 * Gibt zurück, ob der Avenger ein Superheld ist.
	 * @return ob superheld
	 */
	public boolean isSuperheld() {
		return superheld;
	}
	
	// restliche Methoden
	
	/**
	 * Der Avenger vollbringt eine Heldentat
	 * Sorgt dafür, dass der Wert des Attributs superheldenKraft
	 * halbiert wird.
	 */
	public void vollbringeHeldentat() {
		superheldenKraft = superheldenKraft / 2;
	}
	
	/**
	 * Lässt sich den Superhelden erholen
	 * Sorgt dafür, dass der Wert des Attributs superheldenKraft
	 * auf 100.0 gesetzt wird.
	 */
	public void erholeDich() {
		superheldenKraft = 100f;
	}
	
	/**
	 * Verwandelt den Avenger in einen Superhelden
	 * Setzt das Attribut superheld auf true.
	 */
	public void werdeSuperheld() {
		superheld = true;
	}
	
	/**
	 * Verwandelt den Avenger in einen Menschen
	 * Setzt das Attribut superheld auf false.
	 */
	public void werdeMensch() {
		superheld = false;
	}
	
	/**
	 * Gibt zurück, ob der Avenger Mensch oder Superheld ist
	 * Gibt Superheld zurück, wenn das Attribut superheld true ist.
	 * @return String “Superheld” oder “normaler Mensch”
	 */
	public String sageName() {
		if (superheld == true) {
			return "Superheld";
		}
		return "normaler Mensch";
	}
	
}
