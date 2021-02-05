;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname I01_G07_A14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------
;; Konstanten
;; ---------------------------------------------------------------------
(define PI 3.142)

;; ---------------------------------------------------------------------
;; Aufgabenteil (a)
;; ---------------------------------------------------------------------

;; Datendefinition [ergaenzen]
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

;; Ergaenzen Sie die nachfolgenden Definitionen der Beispieldaten
;; in Abhaengigkeit der Definitionen Ihrer Strukturen. Diese werden
;; fuer die vorgegebenen Tests verwendet.

;; qf1 ist ein Quaderfuss mit Breite  4, Hoehe 10 und Tiefe  4.
(define qf1 (make-quaderfuss   4 10 4))
;; qf2 ist ein Quaderfuss mit Breite 13, Hoehe  5 und Tiefe 11.
(define qf2 (make-quaderfuss   13 5 11))
;; qf3 ist ein Quaderfuss mit Breite  8, Hoehe  8 und Tiefe  8.
(define qf3 (make-quaderfuss   8 8 8))

;; zf1 ist ein Zylinderfuss mit Durchmesser  8 und Hoehe 15.
(define zf1 (make-zylinderfuss 8 15))
;; zf2 ist ein Zylinderfuss mit Durchmesser 12 und Hoehe 11.
(define zf2 (make-zylinderfuss 12 11))
;; zf3 ist ein Zylinderfuss mit Durchmesser 10 und Hoehe 10.
(define zf3 (make-zylinderfuss 10 10))

;; kf1 ist ein Kegelfuss mit Durchmesser 12 und Hoehe  7.
(define kf1 (make-kegelfuss 12 7))
;; kf2 ist ein Kegelfuss mit Durchmesser  9 und Hoehe 13.
(define kf2 (make-kegelfuss 9 13))
;; kf3 ist ein Kegelfuss mit Durchmesser  6 und Hoehe  6.
(define kf3 (make-kegelfuss 6 6))


;; ---------------------------------------------------------------------
;; Aufgabenteil (b)
;; ---------------------------------------------------------------------

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
;; ---------------------------------------------------------------------
;; Aufgabenteil (c)
;; ---------------------------------------------------------------------

;; Signatur: flaeche-fuss : regalfuss -> number
;; Zweck: Berechnet die Oberflaeche eines Regalfusses in cm^2 ohne Nachkommastellen.
;;    Fehler, wenn kein gueltiger Regalfuss uebergeben wurde.
;; Beispiele:
;;    (flaeche-fuss qf1) sollte  192 ergeben.
;;    (flaeche-fuss qf2) sollte  526 ergeben.
;;    (flaeche-fuss qf3) sollte  384 ergeben.
;;    (flaeche-fuss zf1) sollte  477 ergeben.
;;    (flaeche-fuss zf2) sollte  640 ergeben.
;;    (flaeche-fuss zf3) sollte  471 ergeben.
;;    (flaeche-fuss kf1) sollte  286 ergeben.
;;    (flaeche-fuss kf2) sollte  258 ergeben.
;;    (flaeche-fuss kf3) sollte   91 ergeben.
;;    (flaeche-fuss 'Hallo) sollte einen Fehler erzeugen.
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
(define (flaeche-fuss a-regalfuss)
  (cond
    [ (quaderfuss? a-regalfuss)
      (floor (flaeche-quaderfuss a-regalfuss))]
    [ (zylinderfuss? a-regalfuss)
      (floor (flaeche-zylinderfuss a-regalfuss))]
    [ (kegelfuss? a-regalfuss)
      (floor (flaeche-kegelfuss a-regalfuss))]
    [ else
      (error 'flaeche-fuss "Kein gueltiger Regalfuss uebergeben.")]
    ))
     
;; Tests: [siehe Hinweise in Aufgabenstellung zur Verwendung von check-within]
(check-within (flaeche-fuss qf1) 192 0.1)
(check-within (flaeche-fuss qf2) 526 0.1)
(check-within (flaeche-fuss qf3) 384 0.1)
(check-within (flaeche-fuss zf1) 477 0.1)
(check-within (flaeche-fuss zf2) 640 0.1)
(check-within (flaeche-fuss zf3) 471 0.1)
(check-within (flaeche-fuss kf1) 286 0.1)
(check-within (flaeche-fuss kf2) 258 0.1)
(check-within (flaeche-fuss kf3)  91 0.1)
(check-error  (flaeche-fuss 'Hallo) "flaeche-fuss: Kein gueltiger Regalfuss uebergeben.")

;; ---------------------------------------------------------------------

;; [Hier Hilfsfunktionen fuer (c) definieren]
;; Signatur: flaeche-quaderfuss : quaderfuss -> number
;; Zweck: Berechnet die Flaeche eines quaderfoermigen Fusses.

;; (define (flaeche-quaderfuss a-quaderfuss) ...)

;; Beispiele:
;; (flaeche-quaderfuss qf1) sollte 192 ergeben.
;; (flaeche-quaderfuss qf2) sollte 526 ergeben.
;; (flaeche-quaderfuss qf3) sollte 384 ergeben.

;; Definition:
(define (flaeche-quaderfuss a-quaderfuss)
  (* 2
     (+
      (* (quaderfuss-b a-quaderfuss)
         (quaderfuss-h a-quaderfuss))
      (* (quaderfuss-b a-quaderfuss)
         (quaderfuss-t a-quaderfuss))
      (* (quaderfuss-h a-quaderfuss)
         (quaderfuss-t a-quaderfuss))
      )))

;; Tests:
(check-within (flaeche-quaderfuss qf1) 192 0.1)
(check-within (flaeche-quaderfuss qf2) 526 0.1)
(check-within (flaeche-quaderfuss qf3) 384 0.1)


;; Signatur: flaeche-zylinderfuss : zylinderfuss -> number
;; Zweck: Berechnet die Flaeche eines zylinderfoermigen Fusses.

;; (define (flaeche-zylinderfuss a-quaderfuss) ...)

;; Beispiele:
;; (flaeche-zylinderfuss zf1) sollte 477 ergeben.
;; (flaeche-zylinderfuss zf2) sollte 640 ergeben.
;; (flaeche-zylinderfuss zf3) sollte 471 ergeben.

;; Definition:
(define (flaeche-zylinderfuss a-zylinderfuss)
  (+ (* 2
  ;; Grundflaeche
  (* PI
        (expt (/ (zylinderfuss-d a-zylinderfuss) 2)
              2)))
  ;; Mantelflaeche
  (* 2 PI
     (/ (zylinderfuss-d a-zylinderfuss) 2)
     (zylinderfuss-h a-zylinderfuss))
  )
)
;; Tests:
(check-within (flaeche-zylinderfuss zf1) 477 1)
(check-within (flaeche-zylinderfuss zf2) 640 1)
(check-within (flaeche-zylinderfuss zf3) 471 1)


;; Signatur: flaeche-kegelfuss : kegelfuss -> number
;; Zweck: Berechnet die Flaeche eines kegelfoermigen Fusses.

;; (define (flaeche-kegelfuss a-kegelfuss) ...)

;; Beispiele:
;; (flaeche-kegelfuss kf1) sollte 286 ergeben.
;; (flaeche-kegelfuss kf2) sollte 258 ergeben.
;; (flaeche-kegelfuss kf3) sollte  91 ergeben.

;; Definition:
(define (flaeche-kegelfuss a-kegelfuss)
  (+
  ;; Grundflaeche
  (* PI
        (expt (/ (kegelfuss-d a-kegelfuss) 2)
              2))
  ;; Mantelflaeche
  (* PI (/ (kegelfuss-d a-kegelfuss) 2)
     (sqrt (+ (expt (/ (kegelfuss-d a-kegelfuss) 2) 2)
              (expt (kegelfuss-h a-kegelfuss) 2))))
  ))
;; Tests:
(check-within (flaeche-kegelfuss kf1) 286 1)
(check-within (flaeche-kegelfuss kf2) 258 1)
(check-within (flaeche-kegelfuss kf3)  91 1)