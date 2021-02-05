package uebungen;

/**
 * Modellierung eines Rechners, der Anhaltewege ausrechnen kann.
 * Aufgabe 26, Blatt 09, Wintersemester 2020/21.
 * @author Übung I01 Gruppe G07
 */
public class BremswegRechner {

	/**
	 * Berechnet die Anhaltestrecke eines Autos in m
	 * @param geschwindigkeit Die Geschwindigkeit des Autos in km/h
	 * @param reaktionszeit Die reaktionszeit des Fahrers in s
	 * @param bremsbeschleunigung Die Bremsbeschleunigung (witterungsabhängig) in m/s^2
	 * @return Die Anhaltestrecke in m
	 */
	public double berechneAnhaltestrecke(double geschwindigkeit, 
			double reaktionszeit, double bremsbeschleunigung) {
		return berechneBremsweg(geschwindigkeit, bremsbeschleunigung)+
				berechneReaktionsweg(geschwindigkeit, reaktionszeit);
	}

	/**
	 * Berechnet den Bremsweg eines Autos in m
	 * @param geschwindigkeit Die Geschwindigkeit des Autos in km/h
	 * @param bremsbeschleunigung Die Bremsbeschleunigung (witterungsabhängig) in (m/s)^2
	 * @return Den Bremsweg in m
	 */
	public double berechneBremsweg(double geschwindigkeit, double bremsbeschleunigung) {
		double a = berechneMsAusKmH(geschwindigkeit);
		return (a * a) / (2 * bremsbeschleunigung);
	}

	/**
	 * Berechnet den Reaktionsweg eines Autos in m
	 * @param geschwindigkeit Die Geschwindigkeit des Autos in km/h
	 * @param reaktionszeit Die reaktionszeit des Fahrers in s
	 * @return Den Reaktionsweg in m
	 */
	public double berechneReaktionsweg(double geschwindigkeit, double reaktionszeit) {
		return berechneMsAusKmH(geschwindigkeit) * reaktionszeit;
	}

	/**
	 * Berechnet die Geschwindigkeit in m/s aus der Geschwindigkeit in km/h
	 * @param geschwindigkeit Die Geschwindigkeit des Autos in km/h
	 * @return Die Geschwindigkeit in m/s
	 */
	public double berechneMsAusKmH(double geschwindigkeit) {
		return geschwindigkeit / 3.6;
	}
}
