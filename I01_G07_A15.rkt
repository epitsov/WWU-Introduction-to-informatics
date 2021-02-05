;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname I01_G07_A15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------
;; Vorlage für Aufgabe 15
;; ---------------------------------------------------------------------

;; B-Bonuspunkte pro A-Bonuspunkt
(define b-per-a 1.05)

;; A-Bonuspunkte pro B-Bonuspunkt
(define a-per-b 0.95)

;; B-Bonuspunkte pro C-Bonuspunkt
(define b-per-c 10.5)

;; C-Bonuspunkte pro B-Bonuspunkt
(define c-per-b 0.09)

;; **************************************************************************
;; **  Weitere Faktoren sollen nicht explizit definiert werden.
;; **  Aus ethischer Sicht ist dies nicht korrekt, aus Sicht der Gewinn-
;; **  maximierung und aus didaktischen Gruenden hier(!) schon.
;; **************************************************************************

;; Kommission als multiplikativer Faktor
(define commission-factor 0.10)

;; ---------------------------------------------------------------------

;; Hier Datendefinitionen vornehmen.
;; Insbesondere muss erklaert werden, was der Datentyp bonuspunkte ist,
;; der in der Funktion convert (s.u.) genutzt wird.

(define-struct bonuspunkte (amount firm))
;; Ein bonuspunkte ist eine Struktur (make-bonuspunkte (amount firm))
;; Hierbei ist amount eine Zahl und firm ein firma.

(define-struct alleslieferbar (premium-orders))
;; Ein alleslieferbar ist eine Struktur
;; (make-alleslieferbar ((make-bonuspunkte (amount firm)) premium-orders))
;; Hierbei ist premium-orders eine Zahl.

(define-struct bestellmal (free-desserts))
;; Ein alleslieferbar ist eine Struktur
;; (make-bestellmal ((make-bonuspunkte (amount firm)) premium-orders))
;; Hierbei ist free-desserts eine Zahl.

(define-struct caterfruehstueck (door-order))
;; Ein alleslieferbar ist eine Struktur
;; (make-alleslieferbar ((make-bonuspunkte (amount firm)) premium-orders))
;; Hierbei ist door-order ein Boolean.

;; Ein firma ist entweder:
;; (1) Ein alleslieferbar (s.o.) oder
;; (2) Ein bestellmal (s.o.) oder
;; (3) Ein caterfruehstueck.

;; ---------------------------------------------------------------------
;; Hilfsfunktionen
;; ---------------------------------------------------------------------

;; Hier Hilfsfunktionen definieren.

;; Signatur: provision : number -> number
;; Zweck: Zieht die Provision von den Bonuspunkten ab und rundet ab.

;; (define (provision amount) ...)

;; Beispiele:
;; (bonus-points 100) sollte 90 ergeben.
;; (bonus-points 200) sollte 180 ergeben.

;; Definition:
(define (provision amount)
  (floor (* amount (- 1 commission-factor))))
  
;; Tests:
(check-expect (provision 100.1) 90)
(check-expect (provision 200) 180)



;; Signatur: richtungsname : symbol -> symbol
;; Zweck: Auffassung einer Richtung als vergleichbares Firmensymbol aus {'A,'B,'C}.

;; (define (richtungsname direction) ...)

;; Beispiele:
;; (richtungsname '->A) sollte 'A ergeben.
;; (richtungsname '->B) sollte 'B ergeben.
;; (richtungsname '->C) sollte 'C ergeben.
;; (richtungsname '->D) sollte false ergeben.

;; Definition:
(define (richtungsname direction)
  (cond [(equal? '->A direction)
         'A]
        [(equal? '->B direction)
         'B]
        [(equal? '->C direction)
         'C]
        [else false]))

;; Tests
(check-expect (richtungsname '->A) 'A)
(check-expect (richtungsname '->B) 'B)
(check-expect (richtungsname '->C) 'C)
(check-expect (richtungsname '->D) false)


;; Signatur: firmenname : firma -> symbol
;; Zweck: Drückt ein firma als vergleichbares Firmensymbol aus {'A,'B,'C} aus.

;; (define (firmenname firm) ...)

;; Beispiele:
;; (firmenname (make-alleslieferbar 2)) sollte 'A ergeben.
;; (firmenname (make-bestellmal 2)) sollte 'B ergeben.
;; (firmenname (make-caterfruehstueck true)) sollte 'C ergeben.

;; Definition:
(define (firmenname firm)
  (cond [(alleslieferbar? firm)
         'A]
        [(bestellmal? firm)
         'B]
        [(caterfruehstueck? firm)
         'C]))

;; Tests
(check-expect (firmenname (make-alleslieferbar      2)) 'A)
(check-expect (firmenname (make-bestellmal          2)) 'B)
(check-expect (firmenname (make-caterfruehstueck true)) 'C)



;; Signatur: convert-amount : number symbol symbol -> number
;; Zweck: Wandelt die Anzahl an Bonuspunkten amount des Firmensymbols firm in die Anzahl
;; an Bonuspunkten des Firmensymbols dir um.

;; (define (convert-amount amount firm dir) ...)

;; Beispiele:
;; (convert-amount 200 'A 'B) sollte  189 ergeben.
;; (convert-amount 200 'A 'C) sollte   17 ergeben.
;; (convert-amount  50 'B 'A) sollte   42 ergeben.
;; (convert-amount  50 'B 'C) sollte    4 ergeben.
;; (convert-amount 100 'C 'A) sollte  897 ergeben.
;; (convert-amount 100 'C 'B) sollte  945 ergeben.

;; Definition:
(define (convert-amount amount firm dir)
  (provision (cond
      ;; Firma A
      [(and (equal? 'A firm)
            (equal? 'B dir))
       (* amount b-per-a)]
      [(and (equal? 'A firm)
            (equal? 'C dir))
       (* amount c-per-b b-per-a)]
      ;; Firma B
      [(and (equal? 'B firm)
            (equal? 'A dir))
       (* amount a-per-b)]
      [(and (equal? 'B firm)
            (equal? 'C dir))
       (* amount c-per-b)]
      ;; Firma C
      [(and (equal? 'C firm)
            (equal? 'A dir))
       (* amount a-per-b b-per-c)]
      [(and (equal? 'C firm)
            (equal? 'B dir))
       (* amount b-per-c)])))

;; Tests
(check-expect (convert-amount 200 'A 'B)  189)
(check-expect (convert-amount 200 'A 'C)   17)
(check-expect (convert-amount  50 'B 'A)   42)
(check-expect (convert-amount  50 'B 'C)    4)
(check-expect (convert-amount 100 'C 'A)  897)
(check-expect (convert-amount 100 'C 'B)  945)

;; ---------------------------------------------------------------------
;; Hauptfunktion
;; ---------------------------------------------------------------------

;; Signatur: convert : bonuspunkte symbol -> bonuspunkte
;; Zweck: Wandelt die angegebenen Bonuspunkte in die angegebene
;; Konvertierungsrichtung um.

;; Schablone:
;; Signatur: process-firma : firma -> ???
(define (process-firma a-firma)
  (cond [(alleslieferbar? a-firma)
         (... (alleslieferbar-premium-orders a-firma))]
        [(bestellmal? a-firma)
         (... (bestellmal-free-desserts a-firma))]
        [(caterfruehstueck? a-firma)
         (... (caterfruehstueck-door-order a-firma))]))

;; Datenbuendel fuer Tests:
;; [200 Bonuspunkte fuer AllesLieferbar mit 10 Premium-Bestellungen]
(define beispiel-a (make-bonuspunkte 200 (make-alleslieferbar 10)))
;; [ 50 Bonuspunkte fuer BestellMa(h)l mit 3 Gratis-Desserts]
(define beispiel-b (make-bonuspunkte 50 (make-bestellmal 3)))
;; [100 Bonuspunkte fuer CaterFruehstueck mit Klingel-Erlaubnis]
(define beispiel-c (make-bonuspunkte 100 (make-caterfruehstueck true)))

;; Beispiele:
;;
;; [Hier zu erwartende Ergebnisse ergaenzen.]
;;
;; (convert beispiel-a '->A) sollte beispiel-a ergeben
;; (convert beispiel-a '->B) sollte (make-bonuspunkte  189 (make-bestellmal 2)) ergeben
;; (convert beispiel-a '->C) sollte (make-bonuspunkte   17 (make-caterfruehstueck #true)) ergeben
;;
;; (convert beispiel-b '->A) sollte (make-bonuspunkte   42 (make-alleslieferbar 2)) ergeben
;; (convert beispiel-b '->B) sollte beispiel-b ergeben
;; (convert beispiel-b '->C) sollte (make-bonuspunkte    4 (make-caterfruehstueck #true)) ergeben
;;
;; (convert beispiel-c '->A) sollte (make-bonuspunkte  897 (make-alleslieferbar 2)) ergeben
;; (convert beispiel-c '->B) sollte (make-bonuspunkte  945 (make-bestellmal 2)) ergeben
;; (convert beispiel-c '->C) sollte beispiel-c ergeben
;;

;; Definition:
(define (convert a-bonuspunkte direction)
  (cond ;; Fehlermeldungen
        [(not (bonuspunkte? a-bonuspunkte))
         (error 'convert "Parameter vom Typ bonuspunkte erwartet.")]
        [(equal? false (richtungsname direction))
         (error 'convert "Ungueltige Konvertierungsrichtung uebergeben.")]
        ;; Firma ist schon Ziel
        [(equal? (firmenname (bonuspunkte-firm a-bonuspunkte))
                 (richtungsname direction))
         a-bonuspunkte]
        ;; restliche Ziele
        [(equal? 'A (richtungsname direction))
         (make-bonuspunkte (convert-amount (bonuspunkte-amount a-bonuspunkte)
                                            (firmenname (bonuspunkte-firm a-bonuspunkte))
                                            (richtungsname direction))
                           (make-alleslieferbar 2))]
        
        [(equal? 'B (richtungsname direction))
         (make-bonuspunkte (convert-amount (bonuspunkte-amount a-bonuspunkte)
                                            (firmenname (bonuspunkte-firm a-bonuspunkte))
                                            (richtungsname direction))
                           (make-bestellmal 2))]
        
        [(equal? 'C (richtungsname direction))
         (make-bonuspunkte (convert-amount (bonuspunkte-amount a-bonuspunkte)
                                            (firmenname (bonuspunkte-firm a-bonuspunkte))
                                            (richtungsname direction))
                           (make-caterfruehstueck true))]
        
        [else (error 'convert "Unbekannter Fehler.")]))

;; Tests
(check-expect (convert beispiel-a '->A) beispiel-a)
(check-expect (convert beispiel-a '->B) (make-bonuspunkte  189 (make-bestellmal 2)))
(check-expect (convert beispiel-a '->C) (make-bonuspunkte   17 (make-caterfruehstueck #true)))
(check-expect (convert beispiel-b '->A) (make-bonuspunkte   42 (make-alleslieferbar 2)))
(check-expect (convert beispiel-b '->B) beispiel-b)
(check-expect (convert beispiel-b '->C) (make-bonuspunkte    4 (make-caterfruehstueck #true)))
(check-expect (convert beispiel-c '->A) (make-bonuspunkte  897 (make-alleslieferbar 2)))
(check-expect (convert beispiel-c '->B) (make-bonuspunkte  945 (make-bestellmal 2)))
(check-expect (convert beispiel-c '->C) beispiel-c)
(check-error  (convert 'Beispiel  '->C) "convert: Parameter vom Typ bonuspunkte erwartet.")
(check-error  (convert beispiel-c '->D) "convert: Ungueltige Konvertierungsrichtung uebergeben.")
