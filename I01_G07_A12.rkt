;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |aufgabe 12|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; **************************************************************************
;; **  Hilfsfunktionen 
;; **************************************************************************

;; [Hier Hilfsfunktionen spezifizieren, implementieren, testen]

;; Signatur: change-tax price old-tax new-tax

;; Zweck: Gegeben eine Zahl price, eine alte Mehrwertsteuer old-tax und eine
;; neue Mehrwertsteuer new-tax (jeweils in Prozent), bestimme den ungerundeten
;; Preis nach der Aenderung der Mehrwertsteuer von old-tax zu new-tax.

;; (define (change-tax price old-tax new-tax) ...)

;; Beispiele:
;; (change-tax  0.00 10.5 12.3) sollte 0.00 ergeben.
;; (change-tax 17.47 10.5 10.5) sollte 17.47 ergeben.
;; (change-tax 11.93 19   16  ) sollte ungefähr 11.63 ergeben.

;; Definition:
(define (change-tax price old-tax new-tax)
  (*
   (/ price (+ 1 (/ old-tax 100))) ;; alte Steuer abziehen
   (+ 1 (/ new-tax 100)            ;; neue Steuer addieren
  )))

;; Tests:
(check-expect (change-tax  0.00 10.5 12.3)   0.00)
(check-expect (change-tax 17.47 10.5 10.5)  17.47)
(check-within (change-tax 11.93 19   16  )  11.63 0.01)



;; Signatur: last_digit: number -> number

;; Zweck: Berechnet die letzte Nachkommastelle einer gegebenen Zahl n
;; mit zwei Nachkommastellen.

;; (define (last-digit n) ...)

;; Beispiele:
;; (last-digit 5.56) sollte 6 ergeben.
;; (last-digit 120.67) sollte 7 ergeben.
;; (last-digit 0.00) sollte 0 ergeben.
;; (last-digit 0.03) sollte 3 ergeben.

;; Definition:
(define (last-digit n)
  (*(- (round-n n 2) (round-n n 1)) 100))

;; Test:
(check-expect (last-digit 5.56) 6)
(check-expect (last-digit 120.67) 7)
(check-expect (last-digit 0.00) 0)
(check-expect (last-digit 0.03) 3)



;; Signatur: round-n: number number -> number

;; Zweck: Rundet eine gegebene Zahl x auf n Nachkommastellen, indem ggfs.
;;    überzählige Stellen abgeschnitten werden.

;; (define (round-n x n) ...)

;; Beispiele:
;;   (round-n 10.234 2) sollte 10.23  ergeben. [Mehr als n Nachkommastellen]
;;   (round-n 12.234 4) sollte 12.234 ergeben. [Weniger als n Nachkommastellen]
;;   (round-n 12.234 3) sollte 12.234 ergeben. [Genau n Nachkommastellen]
;;   (round-n 1 5)      sollte  1     ergeben. [Keine Nachkommastellen]
;;   (round-n 2.1234 0) sollte  2     ergeben. [Runden auf ganze Zahl]
;;   (round-n 0 0)      sollte  0     ergeben. [Eingabe und Ergebnis 0]
;;   (round-n 0 2)      sollte  0     ergeben. [Eingabe und Ergebnis 0]

;; Definition:
(define (round-n x n)
   (/ (floor(*  x (expt 10 n))) (expt 10 n)))

;; Tests:
(check-expect (round-n 10.234  2) 10.23)
(check-expect (round-n 12.234  4) 12.234)
(check-expect (round-n 12.234  3) 12.234)
(check-expect (round-n  1      5)  1)
(check-expect (round-n  2.1234 0)  2)
(check-expect (round-n  0      0)  0)
(check-expect (round-n  0      2)  0)

;; **************************************************************************
;; **  Funktion change-price 
;; **************************************************************************

;; Signatur: change-price: number -> number

;; Zweck: Gegeben eine Zahl price, eine alte Mehrwertsteuer old-tax und eine
;; neue Mehrwertsteuer new-tax (jeweils in Prozent), bestimme den exakten Preis
;; nach der Aenderung der Mehrwertsteuer von old-tax zu new-tax wobei 
;; gemaess der in Aufgabe 12 gegebenen Regeln auf Betraege in Einheiten
;; zu fuenf Cent gerechnet wird.

;; (define (change-price price old-tax new-tax) ...)

;; Beispiele:
;; (change-price  0.00 10.5 12.3)   sollte   0.00 ergeben. [Keine Rundung   ]
;; (change-price 17.45 10.5 10.5)   sollte  17.45 ergeben. [Keine Rundung   ]
;; (change-price 11.90 19   16  )   sollte  11.60 ergeben. [Keine Rundung   ]
;; (change-price 15.00 19   16  )   sollte  14.60 ergeben. [Abrunden  auf  0]
;; (change-price 10.24  7    9  )   sollte  10.45 ergeben. [Aufrunden auf  5]
;; (change-price  9.43  9    7  )   sollte   9.25 ergeben. [Keine Rundung   ]
;; (change-price 16.05 12.5 10.5)   sollte  15.75 ergeben. [Abrunden  auf  5]
;; (change-price 17.25 16   19  )   sollte  17.70 ergeben. [Aufrunden auf 10]

;; Definition [Ausgestaltung der Signatur]:
(define (change-price price old-tax new-tax)
  (cond [ (= (last-digit (round-n (change-tax price old-tax new-tax) 2)) 0)    
         (round-n (change-tax price old-tax new-tax) 2)]
        [(or (= (last-digit (round-n (change-tax price old-tax new-tax) 2)) 1)
             (= (last-digit (round-n (change-tax price old-tax new-tax) 2)) 2))
         (/ (floor (* (round-n (change-tax price old-tax new-tax) 2) 10)) 10)] ;; Zahl abrunden
        [(or (= (last-digit (round-n (change-tax price old-tax new-tax) 2)) 8)
             (= (last-digit (round-n (change-tax price old-tax new-tax) 2)) 9))
         (/ (ceiling (* (round-n (change-tax price old-tax new-tax) 2) 10)) 10)] ;; Zahl aufrunden
        [else
         (+ 0.05 (round-n (change-tax price old-tax new-tax) 1))] ;; Letzte Stelle 5
        ))

;; Tests:
(check-expect (change-price  0.00 10.5 12.3)   0.00)
(check-expect (change-price 17.45 10.5 10.5)  17.45)
(check-expect (change-price 11.90 19   16  )  11.60)
(check-expect (change-price 15.00 19   16  )  14.60)
(check-expect (change-price 10.24  7    9  )  10.45)
(check-expect (change-price  9.43  9    7  )   9.25)
(check-expect (change-price 16.05 12.5 10.5)  15.75)
(check-expect (change-price 17.25 16   19  )  17.70)
