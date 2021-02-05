;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname I01_G07_A18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------
;; Konstanten
;; ---------------------------------------------------------------------
(define PI 3.142)


;; ---------------------------------------------------------------------
;; Datendefinitionen
;; ---------------------------------------------------------------------

;; Datendefinition
;; Ein frachtgut ist entweder ein regal oder ein regalfuss.

;; Datendefinition
(define-struct regal (breite hoehe tiefe dicke durchmesser))
;; Ein regal ist eine Struktur (make-regal breite hoehe tiefe dicke durchmesser)
;; zur Repraesentation eines Regals aus Aufgabe 9.
;; Hierbei sind breite, hoehe, tiefe, dicke und durchmesser (positive) Zahlenwerte in cm.

;; Datendefinition
;; Eine regalfuss ist entweder ein quaderfuss, ein zylinderfuss oder ein
;; kegelfuss.


;; Ein regalfuss ist entweder
;; (1) ein quaderfuss (s.u.) oder
;; (2) ein zylinderfuss (s.u.) oder
;; ein kegelfuss (s.u.).

;; Datendefinition [ergaenzen]
(define-struct quaderfuss (b h t))
;; Ein quaderfuss ist eine Struktur (make-quaderfuss b h t).
;; Hierbei sind b, h und t Zahlen.

;; Datendefinition [ergaenzen]
(define-struct zylinderfuss (d h))
;; Ein zylinderfuss ist eine Struktur (make-zylinderfuss d h)
;; Hierbei sind d und h Zahlen.

;; Datendefinition [ergaenzen]
(define-struct kegelfuss (d h))
;; Ein kegelfuass ist eine Struktur (make-kegelfuss d h)
;; Hierbei sind d und h Zahlen.



;; ---------------------------------------------------------------------
;; Beispiel-Datenbuendel fuer Tests
;; ---------------------------------------------------------------------
(define reg1 (make-regal 33.2 40 28 1   5))  ;; Volumen:  5434
(define reg2 (make-regal 40   50 30 1.5 7))  ;; Volumen: 11106
(define reg3 (make-regal 20   30 20 2   3))  ;; Volumen:  5317

(define qf1 (make-quaderfuss  4 10  4))      ;; Volumen: 160
(define qf2 (make-quaderfuss 13  5 11))      ;; Volumen: 715
(define qf3 (make-quaderfuss  8  8  8))      ;; Volumen: 512

(define zf1 (make-zylinderfuss  8 15))       ;; Volumen:  754
(define zf2 (make-zylinderfuss 12 11))       ;; Volumen: 1244
(define zf3 (make-zylinderfuss 10 10))       ;; Volumen:  785

(define kf1 (make-kegelfuss 12  7))          ;; Volumen: 263
(define kf2 (make-kegelfuss  9 13))          ;; Volumen: 275
(define kf3 (make-kegelfuss  6  6))          ;; Volumen:  56

(define order1   (list reg3 qf1 qf1 zf1 zf1))                                      ;; aufbaubar; Volumen: 7145
(define order2   (list reg1 kf1 reg2 kf1 kf1 kf1 kf2 kf2 kf2 kf2 qf3 qf3 zf3 zf3)) ;; aufbaubar; Volumen: 21286 
(define order3   (list kf1 kf1 kf2 kf2 qf3 qf3 zf3 reg1 reg2))                     ;; nicht aufbaubar; Volumen: 19425
(define no-order (list "Regal"))                                                   ;; ungueltig



;; ---------------------------------------------------------------------
;; Aufgabenteil (a)
;; ---------------------------------------------------------------------

;; Signatur: aufbaubar? : [ergaenzen]
;; Zweck: Berechnet, ob eine als Liste lof uebergebene Bestellung mindestens vier
;;    Mal so viele Fuesse enthaelt wie Regale.
;; Beispiele:
;;    (aufbaubar? order1)   sollte  true ergeben.
;;    (aufbaubar? order2)   sollte  true ergeben.
;;    (aufbaubar? order3)   sollte false ergeben.
;;    (aufbaubar? empty)    sollte einen Fehler verursachen.
;;    (aufbaubar? zf1)      sollte einen Fehler verursachen.
;;    (aufbaubar? no-order) sollte einen Fehler verursachen.
;; Schablone: [ergaenzen]
;;      Signatur: process-lof : list -> ???
;;(define (process-lof a-lof)
;;  (cond
;;    [(empty? a-lof) ...]
;;    [else ... (first a-lof) ...
;;          ... (rest a-lof) ...]))

;; Definition:
(define (aufbaubar? lof)
  (cond [ (or (not (list? lof)) (empty? lof))
          (error 'aufbaubar? "Ungueltige Bestellung.")]
        [else (if (<= ( * 4 (num-regal lof)) (num-legs lof))
                  true
                  false)]))
 
;; Tests:
(check-expect (aufbaubar? order1)   true)
(check-expect (aufbaubar? order2)   true)
(check-expect (aufbaubar? order3)   false)
(check-error  (aufbaubar? empty)    "aufbaubar?: Ungueltige Bestellung.")
(check-error  (aufbaubar? zf1)      "aufbaubar?: Ungueltige Bestellung.")
(check-error  (aufbaubar? no-order) "aufbaubar?: Ungueltige Bestellung.")

;; ---------------------------------------------------------------------

;; [Platz fuer Hilfsfunktionen fuer (a)]

;; Signatur: correct-elem: list-element* -> boolean
;;    *list-element ist jedes in einer Liste zulaessige Element
;; Zweck: Gibt an ob das Element in der Liste gueltig sind

;; Beispiele:
;; (correct-elem reg1) sollte true ergeben.
;; (correct-elem no-order) sollte false ergeben.

;; Definition:
(define (correct-elem el)
  (if (or (regal? el)
          (or (quaderfuss? el)
              (or (zylinderfuss? el)
                  (kegelfuss? el))))
      true
      false))

;; Tests:
(check-expect (correct-elem reg1) true)
(check-expect (correct-elem no-order) false)



;; Signatur: num-regal: list -> num
;; Zweck: Berechnet wie viele Regale es in einer Bestellung gibt.

;; Beispiele:
;; (num-regal order1) sollte 1 ergeben.
;; (num-regal order2) sollte 2 ergeben.
;; (num-regal order3) sollte 2 ergeben.

;; Definition:
(define (num-regal lst)
  (cond [(empty? lst) 0]
        [(not (correct-elem (first lst))) (error 'aufbaubar? "Ungueltige Bestellung.")]
        [else (if (regal?(first lst) )
                  (+ 1 (num-regal (rest lst)))
                  (num-regal (rest lst)))]))
;; Tests:
(check-expect (num-regal order1) 1)
(check-expect (num-regal order2) 2)
(check-expect (num-regal order3) 2)



;; Signatur: num-legs: list-> num
;; Zweck: Berechnet wie viele Fuesse es in einer Bestellung gibt.
;; Beispiele:
;; (num-legs order1) sollte 4 ergeben.
;; (num-legs order2) sollte 12 ergeben.
;; (num-legs order3) sollte 7 ergeben.

;; Definition:
(define (num-legs lst)
  (cond [(empty? lst) 0]
        [(not (correct-elem (first lst)))
         (error 'aufbaubar? "Ungueltige Bestellung.")]
        [else (if (not (regal? (first lst)))
                  (+ 1 (num-legs (rest lst)))
                  (num-legs (rest lst)))]))
;; Tests:
(check-expect (num-legs order1) 4)
(check-expect (num-legs order2) 12)
(check-expect (num-legs order3) 7)


;; ---------------------------------------------------------------------
;; Aufgabenteil (b)
;; ---------------------------------------------------------------------

;; Signatur: gesamtvolumen : liste-> number
;; Zweck: Berechnet das gesamte Nettovolumen einer als Liste lof uebergebene Bestellung.
;; Beispiele:
;;    (gesamtvolumen order1)   sollte  7145 ergeben.
;;    (gesamtvolumen order2)   sollte 21286 ergeben.
;;    (gesamtvolumen order3)   sollte 19425 ergeben.
;;    (gesamtvolumen empty)    sollte einen Fehler verursachen.
;;    (gesamtvolumen zf1)      sollte einen Fehler verursachen.
;;    (gesamtvolumen no-order) sollte einen Fehler verursachen.

;; Definition:
(define (gesamtvolumen lof)
  (cond [ (or (not (list? lof)) (empty? lof))
          (error 'gesamtvolumen "Ungueltige Bestellung.")]
        [else (gesamtvolumen-internal lof)]))

;; interne Funktion:
(define (gesamtvolumen-internal lof)
  (cond [(empty? lof) 0]
        [(not (correct-elem (first lof)))
         (error 'gesamtvolumen "Ungueltige Bestellung.")]
        [else (if (regal? (first lof))
                  (+ (regalvolumen (first lof)) (gesamtvolumen-internal (rest lof)))
                  (+ (volumen-fuss (first lof)) (gesamtvolumen-internal (rest lof))))]))

;; Tests:
(check-expect (gesamtvolumen order1)  7145)
(check-expect (gesamtvolumen order2) 21286)
(check-expect (gesamtvolumen order3) 19425)
(check-error  (gesamtvolumen empty)    "gesamtvolumen: Ungueltige Bestellung.")
(check-error  (gesamtvolumen zf1)      "gesamtvolumen: Ungueltige Bestellung.")
(check-error  (gesamtvolumen no-order) "gesamtvolumen: Ungueltige Bestellung.")


;; ---------------------------------------------------------------------

;; Wrapper-Funktion fuer volumen-regal. In Teil (b) aufrufen.

;; Signatur: regalvolumen : regal -> number
;; Zweck: Uebergibt die Abmessungen des uebergebenen Regals an die alte
;;    Loesung von Aufgabe 9.
;; Beispiele:
;;   (regalvolumen reg1)   sollte  5434 ergeben.
;;   (regalvolumen reg2)   sollte 11106 ergeben.
;;   (regalvolumen reg3)   sollte  5317 ergeben.
;; Schablone:
;;   Signatur: process-regal : regal -> ???
;;     (define (process-regal a-regal)
;;       (... (regal-breite       a-regal) ... 
;;        ... (regal-hoehe        a-regal) ...
;;        ... (regal-tiefe        a-regal) ...))
;;        ... (regal-dicke        a-regal) ...))
;;        ... (regal-durchmesser  a-regal) ...))
;; Definition: [interne, nicht abgesicherte Funktion]

(define (regalvolumen r)
  (floor (volumen-regal (regal-breite r) (regal-hoehe r) (regal-tiefe r) (regal-dicke r) (regal-durchmesser r))))

;; Tests:
(check-expect (regalvolumen reg1)  5434)
(check-expect (regalvolumen reg2) 11106)
(check-expect (regalvolumen reg3)  5317)


;; ---------------------------------------------------------------------

;; [Platz fuer weitere Hilfsfunktionen fuer (b)]



;; ---------------------------------------------------------------------
;; Platz fuer wiederverwertete Aufgabe 9 und 14
;; Ab hier wird nichts korrigiert und bewertet.
;; ---------------------------------------------------------------------

;; Signatur: volumen-regal : number number number number number -> number
;; Zweck: Berechnet das Volumen des Regals, gerundet auf drei Nachkommastellen
;;   in cm^3, in Abhängigkeit von Breite b, Höhe h, Tiefe t, Dicke d und
;;   Durchmesser c (jeweils in cm).
;; Beispiele:
;;   (volumen-regal 33.2 40 28 1   5) sollte etwa  5434.6875  ergeben.
;;   (volumen-regal 40   50 30 1.5 7) sollte etwa 11106.79725 ergeben.
;;   (volumen-regal 20   30 20 2   3) sollte etwa  5317.583   ergeben.
;; Definition:
(define (volumen-regal b h t d c)
  (round-n (+ (volumen-rueckwand h b c d) (volum-platten b h t d)) 3))
;; Tests:
(check-within (volumen-regal 33.2 40 28 1   5)  5434.6875  0.001)
(check-within (volumen-regal 40   50 30 1.5 7) 11106.79725 0.001)
(check-within (volumen-regal 20   30 20 2   3)  5317.583   0.001)


;; Hilfsfunktionen:

;; Signatur volumen-kreise: number number-> number
;; Zweck: Berechnet das Volumen, das die kreisfoermigen Loecher haben in Abhängigkeit von
;; Durchmesser c, Dicke d.
;;Beispiele:
;; (volumen-kreise 2 1) sollte 9.426 ergeben
;; (volumen-kreise 0 0) sollte 0 ergeben
;; (volumen-kreise 2 3) sollte 28.278 ergeben
;; (volumen-kreise 4 1) sollte 37.704 ergeben
;; Definition:
(define (volumen-kreise c d)
  (* (* (* (* (/ c 2) (/ c 2)) PI) d) 3))
;; Tests:
(check-within (volumen-kreise 2 1) 9.426 0.001)
(check-within (volumen-kreise 2 3) 28.278 0.001)
(check-within (volumen-kreise 4 1) 37.704 0.001)

;; Signatur volumen-rueckwand  number number number number-> number
;; Zweck: Berechnet das Volumen der Rueckwand in Abhängigkeit von Breite b,
;;   Höhe h, Durchmesser c, Dicke d.
;; Beispiele:
;; (volumen-rueckwand 8 10 2 1) sollte 81.148 ergeben
;; (volumen-rueckwand 10 10 2 1) sollte 101.148 ergeben
;; (volumen-rueckwand 10 10 2 3) sollte 103.444 ergeben
;; Definition:
(define (volumen-rueckwand h b c d)
  (- (* (* b (+  h (* 2 d))) d) (volumen-kreise c d)))
;; Tests:
(check-within (volumen-rueckwand 8 10 2 1) 90.574 0.001)
(check-within (volumen-rueckwand 10 10 2 1) 110.574 0.001)
(check-within (volumen-rueckwand 10 10 2 3) 451.722 0.001)

;; Signatur volum-platten number number number number-> number
;; Zweck: Berechnet das Volumen der Platten in Abhängigkeit von Breite b,
;;   Höhe h, Tiefe t, Dicke d.
;; Beispiele:
;; (volum-platten 1 1 1 1) sollte 4 ergeben
;; (volum-platten 2 1 1 1) sollte 6 ergeben
;; (volum-platten 1 1 1 3) sollte 12 ergeben
;; Definition:
(define (volum-platten b h t d)
  (+ (* 2 b t d) (* 2 h t d)))
;; Tests:
(check-expect (volum-platten 1 1 1 1) 4)
(check-expect (volum-platten 2 1 1 1) 6)
(check-expect (volum-platten 1 1 1 3) 12)


;; Signatur: volumen-fuss : regalfuss -> number
;; Zweck: Berechnet das Volumen eines Regalfusses in cm^3 ohne Nachkommastellen.
;;    Fehler, wenn kein gueltiger Regalfuss uebergeben wurde.
;; Beispiele:
;;    (volumen-fuss qf1) sollte  160 ergeben.
;;    (volumen-fuss qf2) sollte  715 ergeben.
;;    (volumen-fuss qf3) sollte  512 ergeben.
;;    (volumen-fuss zf1) sollte  754 ergeben.
;;    (volumen-fuss zf2) sollte 1244 ergeben.
;;    (volumen-fuss zf3) sollte  785 ergeben.
;;    (volumen-fuss kf1) sollte  263 ergeben.
;;    (volumen-fuss kf2) sollte  275 ergeben.
;;    (volumen-fuss kf3) sollte   56 ergeben.
;;    (volumen-fuss 'Hallo) sollte einen Fehler erzeugen.

;; Schablone: 
;;   [ergaenzen]
;; Signatur: process-regalfuss : regalfuss -> ???
;;(define (process-regalfuss a-regalfuss)
;;  (cond
;;    [ (quaderfuss? a-regalfuss)
;;      ... (quaderfuss-b a-regalfuss)
;;      ... (quaderfuss-h a-regalfuss)
;;      ... (quaderfuss-t a-regalfuss)
;;      ...  ]
;;    [ (zylinderfuss? a-regalfuss)
;;      ... (zylinderfuss-d a-regalfuss)
;;      ... (zylinderfuss-h a-regalfuss)
;;      ...  ]
;;    [ (kegelfuss? a-regalfuss)
;;      ... (kegelfuss-d a-regalfuss)
;;      ... (kegelfuss-h a-regalfuss)
;;      ...  ]
;;    ))
    
;; Definition:
(define (volumen-fuss a-regalfuss)
  (cond
    [ (quaderfuss? a-regalfuss)
      (floor (volumen-quaderfuss a-regalfuss))]
    [ (zylinderfuss? a-regalfuss)
      (floor (volumen-zylinderfuss a-regalfuss))]
    [ (kegelfuss? a-regalfuss)
      (floor (volumen-kegelfuss a-regalfuss))]
    [ else
      (error 'volumen-fuss "Kein gueltiger Regalfuss uebergeben.")]
    ))
     
;; Tests: [siehe Hinweise in Aufgabenstellung zur Verwendung von check-within]
(check-within (volumen-fuss qf1)  160 0.1)
(check-within (volumen-fuss qf2)  715 0.1)
(check-within (volumen-fuss qf3)  512 0.1)
(check-within (volumen-fuss zf1)  754 0.1)
(check-within (volumen-fuss zf2) 1244 0.1)
(check-within (volumen-fuss zf3)  785 0.1)
(check-within (volumen-fuss kf1)  263 0.1)
(check-within (volumen-fuss kf2)  275 0.1)
(check-within (volumen-fuss kf3)   56 0.1)
(check-error  (volumen-fuss 'Hallo) "volumen-fuss: Kein gueltiger Regalfuss uebergeben.")

;; ---------------------------------------------------------------------

;; [Hier Hilfsfunktionen fuer (b) definieren]

;; Signatur: volumen-quaderfuss : quaderfuss -> number
;; Zweck: Berechnet das Volumen eines quaderfoermigen Fusses.

;; (define (volumen-quaderfuss a-quaderfuss) ...)

;; Beispiele:
;; (volumen-quaderfuss qf1) sollte 160 ergeben.
;; (volumen-quaderfuss qf2) sollte 715 ergeben.
;; (volumen-quaderfuss qf3) sollte 512 ergeben.

;; Definition:
(define (volumen-quaderfuss a-quaderfuss)
  (*  (quaderfuss-b a-quaderfuss)
      (quaderfuss-h a-quaderfuss)
      (quaderfuss-t a-quaderfuss)
      ))

;; Tests:
(check-within (volumen-quaderfuss qf1)  160 0.1)
(check-within (volumen-quaderfuss qf2)  715 0.1)
(check-within (volumen-quaderfuss qf3)  512 0.1)


;; Signatur: volumen-zylinderfuss : zylinderfuss -> number
;; Zweck: Berechnet das Volumen eines zylinderfoermigen Fusses.

;; (define (volumen-zylinderfuss a-quaderfuss) ...)

;; Beispiele:
;; (volumen-zylinderfuss zf1) sollte 754 ergeben.
;; (volumen-zylinderfuss zf2) sollte 1244 ergeben.
;; (volumen-zylinderfuss zf3) sollte 785 ergeben.

;; Definition:
(define (volumen-zylinderfuss a-zylinderfuss)
  (* (* PI
        (expt (/ (zylinderfuss-d a-zylinderfuss) 2)
              2))
     (zylinderfuss-h a-zylinderfuss))
  )
;; Tests:
(check-within (volumen-zylinderfuss zf1)  754 1)
(check-within (volumen-zylinderfuss zf2) 1244 1)
(check-within (volumen-zylinderfuss zf3)  785 1)


;; Signatur: volumen-kegelfuss : kegelfuss -> number
;; Zweck: Berechnet das Volumen eines kegelfoermigen Fusses.

;; (define (volumen-kegelfuss a-kegelfuss) ...)

;; Beispiele:
;; (volumen-kegelfuss kf1) sollte 263 ergeben.
;; (volumen-kegelfuss kf2) sollte 275 ergeben.
;; (volumen-kegelfuss kf3) sollte  56 ergeben.

;; Definition:
(define (volumen-kegelfuss a-kegelfuss)
  (* (* (/ PI 3)
        (expt (/ (kegelfuss-d a-kegelfuss) 2)
              2))
     (kegelfuss-h a-kegelfuss))
  )
;; Tests:
(check-within (volumen-kegelfuss kf1)  263 1)
(check-within (volumen-kegelfuss kf2)  275 1)
(check-within (volumen-kegelfuss kf3)   56 1)

;; Signatur: round-n: number number -> number
;; Zweck: Rundet eine gegebene Zahl x auf n Nachkommastellen, indem ggfs.
;;    überzählige Stellen abgeschnitten werden.
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
  (/ (floor(* x (expt 10 n))) (expt 10 n)))
;; Tests:
(check-expect (round-n 10.234  2) 10.23)
(check-expect (round-n 12.234  4) 12.234)
(check-expect (round-n 12.234  3) 12.234)
(check-expect (round-n  1      5)  1)
(check-expect (round-n  2.1234 0)  2)
(check-expect (round-n  0      0)  0)
(check-expect (round-n  0      2)  0)