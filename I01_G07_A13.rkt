;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname I01_G07_A13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------
;; Vorlage für Aufgabe 13
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

;; Datenanalyse und -definition:
(define-struct firma (name target amount))
;; Ein firma ist eine Struktur: (make-firma name target amount).
;; Hierbei sind name und target Symbole und amount eine Zahl.

;; ---------------------------------------------------------------------

;; Hier ggfs. Hilfsfunktionen spezifizieren, implementieren und testen.

;; Signatur: auffassung : symbol number -> firma

;; Zweck: Auffassung eines Namens mit Zielnamen und Bonuspunkten als Firma.

;; (define (auffassung conversion amount) ...)

;; Beispiele:
;; (auffassung 'C->B 10) sollte (make-firma C 10) ergeben.
;; (auffassung 'A->B 20) sollte (make-firma A 20) ergeben.
;; (auffassung 'C->A 30) sollte (make-firma C 30) ergeben.
;; (auffassung 'A->C 20) sollte (make-firma A 20) ergeben.
;; (auffassung 'B->A 50) sollte (make-firma B 50) ergeben.
;; (auffassung 'B->C 90) sollte (make-firma B 90) ergeben.
;; (auffassung "Hans Meiser" 'XD) sollte einen Fehler ergeben.

;; Definition:
(define (auffassung conversion amount)
  (cond [(equal? conversion 'A->B)
         (make-firma 'A 'B amount)]
        [(equal? conversion 'A->C)
         (make-firma 'A 'C amount)]
        [(equal? conversion 'B->A)
         (make-firma 'B 'A amount)]
        [(equal? conversion 'B->C)
         (make-firma 'B 'C amount)]
        [(equal? conversion 'C->A)
         (make-firma 'C 'A amount)]
        [(equal? conversion 'C->B)
         (make-firma 'C 'B amount)]
        [else (error 'auffasung "Falsche Eingabe!")]))

;; Tests:
(check-expect (auffassung 'C->B 10) (make-firma 'C 'B 10))
(check-expect (auffassung 'A->B 20) (make-firma 'A 'B 20))
(check-expect (auffassung 'C->A 30) (make-firma 'C 'A 30))
(check-expect (auffassung 'A->C 20) (make-firma 'A 'C 20))
(check-expect (auffassung 'B->A 50) (make-firma 'B 'A 50))
(check-expect (auffassung 'B->C 90) (make-firma 'B 'C 90))
(check-error ((auffassung "Hans Meiser" 'XD) "auffassung: Falsche Eingabe!"))



;; Signatur: provision : number -> number

;; Zweck: Zieht die Provision von den Bonuspunkten ab und rundet ab.

;; (define (provision bonus-points) ...)

;; Beispiele:
;; (bonus-points 100) sollte 90 ergeben.
;; (bonus-points 200) sollte 180 ergeben.

;; Definition:
(define (provision bonus-points)
  (floor (* bonus-points 0.9)))
  
;; Tests:
(check-expect (provision 100.1) 90)
(check-expect (provision 200) 180)



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



;; Signatur: convert-firm : firma -> firma
;; Zweck: Wandelt ein firma firma mit den gegebenen Bonuspunkten zu deren Zielfirma
;; mit entsprechenden Bonuspunkten und Ziel um.

;; Schablone:
;;    Signatur: process-firma : firma -> ???
(define (process-firma a-firma)
  (... (firma-name a-firma)
   ... (firma-target a-firma)
   ... (firma-amount bonus-points)))

;; Beispiele:
;; (convert-firm (make-firma 'A 'A 200)) sollte (make-firma 'A 'A 200) ergeben.
;; (convert-firm (make-firma 'A 'B 200)) sollte (make-firma 'B 'B 189) ergeben.
;; (convert-firm (make-firma 'A 'C 200)) sollte (make-firma 'C 'C  17) ergeben.
;; (convert-firm (make-firma 'B 'A  50)) sollte (make-firma 'A 'A  42) ergeben.
;; (convert-firm (make-firma 'B 'C  50)) sollte (make-firma 'C 'C   4) ergeben.
;; (convert-firm (make-firma 'C 'A 100)) sollte (make-firma 'A 'A 897) ergeben.
;; (convert-firm (make-firma 'C 'B 100)) sollte (make-firma 'B 'B 945) ergeben.

;; Definition:
(define (convert-firm firma)
(cond   [(equal? (firma-name firma) (firma-target firma))
         firma]
        [else (make-firma (firma-target firma)
                          (firma-target firma)
                          (convert-amount
                              (firma-amount firma)
                              (firma-name firma)
                              (firma-target firma)))]))

;; Tests:
(check-expect (convert-firm (make-firma 'A 'A 200)) (make-firma 'A 'A 200))
(check-expect (convert-firm (make-firma 'A 'B 200)) (make-firma 'B 'B 189))
(check-expect (convert-firm (make-firma 'A 'C 200)) (make-firma 'C 'C  17))
(check-expect (convert-firm (make-firma 'B 'A  50)) (make-firma 'A 'A  42))
(check-expect (convert-firm (make-firma 'B 'C  50)) (make-firma 'C 'C   4))
(check-expect (convert-firm (make-firma 'C 'A 100)) (make-firma 'A 'A 897))
(check-expect (convert-firm (make-firma 'C 'B 100)) (make-firma 'B 'B 945))
;; ---------------------------------------------------------------------

;; Signatur: convert-bonus-points : symbol number -> number

;; Zweck: Umrechnung der angegebenen Bonuspunkte in der
;; angegebenen Richtung. 

;; Beispiele: 
;; (convert-bonus-points 'C->B 10) sollte  94 ergeben
;; (convert-bonus-points 'A->B 20) sollte  18 ergeben
;; (convert-bonus-points 'C->A 30) sollte   2 ergeben
;; (convert-bonus-points 'A->C 20) sollte 241 ergeben
;; (convert-bonus-points 'B->A 50) sollte  42 ergeben
;; (convert-bonus-points 'B->C 90) sollte   7 ergeben

;; Definition: 
(define (convert-bonus-points conversion amount)
  (firma-amount
   (convert-firm (auffassung conversion amount))))

;; Tests
(check-expect (convert-bonus-points 'C->B 10)  94)
(check-expect (convert-bonus-points 'A->B 20)  18)
(check-expect (convert-bonus-points 'C->A 30) 241) ;; alles moegliche m.d. TR durchprobiert :/
(check-expect (convert-bonus-points 'A->C 20)   1)
(check-expect (convert-bonus-points 'B->A 50)  42)
(check-expect (convert-bonus-points 'B->C 90)   7)
