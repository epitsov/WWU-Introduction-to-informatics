;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Aufgabe 10_alternative|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; [Hier Hilfsfunktionen spezifizieren, definieren und testen.
;; **************************************************************************
;; **  Hilfsfunktionen
;; **************************************************************************
(define fehler "Ungueltiger Parameter uebergeben")

;; Signatur: abbildung: number number number -> number
;; Zweck: Bildet nach gegebenem Mittelwert my, gegebener Standardabweichung sigma und
;; gegebenen Punkten punkte, die Punkte auf einem notenähnlichen Wert ab, zur späteren
;; Weiterverarbeitung.

;; (define (abbildung my sigma punkte) ...)

;; Beispiele:
;; (abbildung 100 20  10) sollte 4.75 ergeben.
;; (abbildung  45 10  31) sollte 3.2 ergeben.
;; (abbildung  45 10  42) sollte 2.65 ergeben.
;; (abbildung  50 10  60) sollte 2 ergeben.
;; (abbildung 100 20 121) sollte 1.975 ergeben.
;; (abbildung 100 20 146) sollte 1.35 ergeben.
;; (abbildung  45 10 180) sollte -4.25 ergeben.

;; Definition:
(define (abbildung my sigma punkte)
(+ 2.5 (* -0.5
          (/ (- punkte my)
             sigma))))

;; Tests:
(check-expect (abbildung 100 20  10)   4.75) 
(check-expect (abbildung  45 10  31)   3.2) 
(check-expect (abbildung  45 10  42)   2.65) 
(check-expect (abbildung  50 10  60)   2) 
(check-expect (abbildung 100 20 121)   1.975)
(check-expect (abbildung 100 20 146)   1.35)
(check-expect (abbildung  45 10 180)   -4.25)



;; Signatur: notenberechnung: number number number -> number

;; Zweck: Berechnet mithilfe des notenähnlichen Werts der Funktion abbildung nach gegebenem Mittelwert
;; my, gegebener Standardabweichung sigma und gegebenen Punkten punkte, die genaue Note aus
;; {1,2,3,4,5} durch Fallunterscheidung und Runden.

;; (define (notenberechnung my sigma punkte) ...)

;; Beispiele:
;; (notenberechnung 100 20  10) sollte 5 ergeben. 
;; (notenberechnung  45 10  31) sollte 4 ergeben. 
;; (notenberechnung  45 10  42) sollte 3 ergeben. 
;; (notenberechnung  50 10  60) sollte 3 ergeben. 
;; (notenberechnung 100 20 121) sollte 2 ergeben. 
;; (notenberechnung 100 20 146) sollte 1 ergeben. 
;; (notenberechnung  45 10 180) sollte 1 ergeben.

;; Definition:
(define (notenberechnung my sigma punkte)
  (cond [(<= (abbildung my sigma punkte) 1.5)     ;; Note ist 1
         1]
        [(and (>= (abbildung my sigma punkte) 2)  ;; Note ist 3
              (< (abbildung my sigma punkte) 3))
              3]
        [else (ceiling (abbildung my sigma punkte))])) ;; Andere Noten durch Aufrunden von abbildung

;; Tests:
(check-expect (notenberechnung 100 20  10)   5) 
(check-expect (notenberechnung  45 10  31)   4) 
(check-expect (notenberechnung  45 10  42)   3) 
(check-expect (notenberechnung  50 10  60)   3) 
(check-expect (notenberechnung 100 20 121)   2)
(check-expect (notenberechnung 100 20 146)   1)
(check-expect (notenberechnung  45 10 180)   1)



;; **************************************************************************
;; **  Schnittstellenfunktion note 
;; **************************************************************************

;; Signatur: note: number number number number -> number

;; Zweck: Gegeben eine maximal erreichbare Punktzahl max, einen Mittelwert my,
;; eine Standardabweichung sigma und eine Punktzahl punkte, bestimmt die
;; gemaess der Aufgabenstellung zu berechnende Note bzw. melde einen Fehler.

;; (define (note max my sigma punkte) ...)

;; Beispiele:
;; - Ergebnisse
;; (note 180 100 20  10)  sollte 5 ergeben
;; (note  90  45 10  31)  sollte 4 ergeben
;; (note 180  45 10  42)  sollte 3 ergeben
;; (note  90  50 10  60)  sollte 3 ergeben
;; (note 180 100 20 121)  sollte 2 ergeben
;; (note 180 100 20 146)  sollte 1 ergeben
;; (note 180  45 10 180)  sollte 1 ergeben
;; - Fehlermeldungen
;; (note  0  5  1  5)  sollte einen Fehler ergeben
;; (note 25 15  0 15)  sollte einen Fehler ergeben
;; (note 20  5 -1  5)  sollte einen Fehler ergeben
;; (note 20 25  1  5)  sollte einen Fehler ergeben
;; (note 30 20  5  5)  sollte einen Fehler ergeben
;; (note 30 20 15 50)  sollte einen Fehler ergeben

;; Definition [Ausgestaltung der Signatur]:
(define (note max my sigma punkte)
  (cond [(< max 0)                          ;; max positiv?
         (error 'note fehler)]
        [(or (<= my 0)                      ;; Mittelwert in Intervall [0;max]?
             (>= my max))
         (error 'note fehler)]
        [(<= sigma 0)                       ;; sigma positiv?
         (error 'note fehler)]
        [(or (<= (- my (* 3 sigma)) 0)      ;; entsprechende Werte µ+-3σ im Intervall?
             (>= (- my (* 3 sigma)) max))
         (error 'note fehler)]
        [(or (<= (+ my (* 3 sigma)) 0)
             (>= (+ my (* 3 sigma)) max))
         (error 'note fehler)]
        [else (notenberechnung my sigma punkte)]) ;; Note kann berechnet werden!
  )
        
;; Tests: [Sowohl Fehlerueberpruefung als auch weitergereichte Ergebnisse]
;; - Ergebnisse
(check-expect (note 180 100 20  10)   5) 
(check-expect (note  90  45 10  31)   4) 
(check-expect (note 180  45 10  42)   3) 
(check-expect (note  90  50 10  60)   3) 
(check-expect (note 180 100 20 121)   2)
(check-expect (note 180 100 20 146)   1)
(check-expect (note 180  45 10 180)   1)
;; - Fehlermeldungen
(check-error (note  0  5  1  5) "note: Ungueltiger Parameter uebergeben")
(check-error (note 25 15  0 15) "note: Ungueltiger Parameter uebergeben")
(check-error (note 20  5 -1  5) "note: Ungueltiger Parameter uebergeben") 
(check-error (note 20 25  1  5) "note: Ungueltiger Parameter uebergeben") 
(check-error (note 30 20  5  5) "note: Ungueltiger Parameter uebergeben") 
(check-error (note 30 20 15 50) "note: Ungueltiger Parameter uebergeben") 