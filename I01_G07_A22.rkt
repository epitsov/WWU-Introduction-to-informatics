;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname RangeDeepFilter-Learnweb) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------
;; Aufgabenteil (a)
;; ---------------------------------------------------------------------

;; Signatur: my-range : number number number -> list-of-numbers
;; Zweck: Erzeugt beginnend bei einer gegebenen Zahl a eine 
;;    Liste mit allen ganzen Zahlen der Schrittweite step in 
;;    einem vorgegeben ganzzahligen Intervall [a,b].
;;    Fehler, wenn a > b.
;; Beispiele:
;;    (my-range  2  2 1) sollte (range  2  2 1) ergeben.
;;    (my-range 13 37 4) sollte (range 13 37 4) ergeben.
;;    (my-range -9 -2 1) sollte (range -9 -2 1) ergeben.
;;    (my-range  4  2 1) sollte einen Fehler verursachen.
;;    (my-range  2  4 0) sollte einen Fehler verursachen.
;; Definition:
(define (my-range a b step)
  (cond [;;(or (and (number? a)
         ;;         (number? b))
         (not (<= a b));;)
         (error 'my-range "Ungueltige Intervallgrenzen angegeben.")]
        [(not (> step 0))
         (error 'my-range "Ungueltige Schrittweite angegeben.")]
        [else (i-my-range a b step empty)]))

;; Tests:
(check-expect (my-range  2  2 1) (range  2  2 1))
(check-expect (my-range 13 37 4) (range 13 37 4))
(check-expect (my-range -9 -2 1) (range -9 -2 1))
(check-error (my-range 4 2 1) "my-range: Ungueltige Intervallgrenzen angegeben.")
(check-error (my-range 2 4 0) "my-range: Ungueltige Schrittweite angegeben.")

;; Signatur: i-my-range : number number number list-of-numbers -> list-of-numbers
;; Zweck: Erzeugt beginnend bei einer gegebenen Zahl a eine 
;;    Liste mit allen ganzen Zahlen der Schrittweite step in 
;;    einem vorgegeben ganzzahligen Intervall [a,b] endrekursiv.
;; Schablone:
;;(define (process-lon a-lon)
;;  (cond [(empty? a-lon) ...]
;;        [(first a-lon) ...]
;;        [else (process-lon (rest a-lon) ...)]))
;; Beispiele:
;;    (i-my-range  2  2 1 empty) sollte (range  2  2 1) ergeben.
;;    (i-my-range 13 37 4 empty) sollte (range 13 37 4) ergeben.
;;    (i-my-range -9 -2 1 empty) sollte (range -9 -2 1) ergeben.
;; Definition:
(define (i-my-range a b step lst)
  (cond [(< b (+ step a)) (reverse lst)]
        [else (i-my-range (+ a step) b step
                          (cons a lst))]))
;; Tests:
(check-expect (i-my-range  2  2 1 empty) (range  2  2 1))
(check-expect (i-my-range 13 37 4 empty) (range 13 37 4))
(check-expect (i-my-range -9 -2 1 empty) (range -9 -2 1))

;; ---------------------------------------------------------------------
;; Aufgabenteil (b)
;; ---------------------------------------------------------------------

;; Signatur: my-filter : lambda list -> list
;; Zweck: Filtert die uebergebene Liste anhand des Praedikats p.
;; Beispiele:
;;    (my-filter number? (list 13 'a 37 'b 42)) sollte
;;       (filter number? (list 13 'a 37 'b 42)) ergeben.
;;    (my-filter symbol? (list 13 'a 37 'b 42)) sollte
;;       (filter symbol? (list 13 'a 37 'b 42)) ergeben.
;;    (my-filter list?   (list 13 'a 37 'b 42)) sollte
;;       (filter list?   (list 13 'a 37 'b 42)) ergeben.
;;    (my-filter even?   (range 1 9 1))         sollte
;;       (filter even?   (range 1 9 1))         ergeben.
;; Schablone:
;;(define (process-ls a-ls)
;;  (cond [(empty? a-ls) ...]
;;        [else ... (first a-ls) ...
;;              ... (process-ls (rest a-ls) ...)]))
;; Definition:
(define (my-filter p ls)
  (i-my-filter p ls empty))

(define (i-my-filter p ls akt)
  (cond [(empty? ls) (reverse akt)]
        [(p (first ls))
         (i-my-filter p (rest ls)
                      (cons (first ls) akt))]
        [else (i-my-filter p (rest ls) akt)]))

;; Tests:
(check-expect (my-filter number? (list 13 'a 37 'b 42)) (filter number? (list 13 'a 37 'b 42)))
(check-expect (my-filter symbol? (list 13 'a 37 'b 42)) (filter symbol? (list 13 'a 37 'b 42)))
(check-expect (my-filter list?   (list 13 'a 37 'b 42)) (filter list?   (list 13 'a 37 'b 42)))
(check-expect (my-filter even?   (range 1 9 1))         (filter even?   (range 1 9 1)))

;; Signatur: deep-filter : lambda list-of-lists -> list-of-lists
;; Zweck: Filtert die uebergebene verschachtelte Liste
;;    anhand des Praedikats p.
;; Beispiele:
;;    (deep-filter number? (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
;;       sollte (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9) ergeben.
;;    (deep-filter even?   (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
;;       sollte (list 2 (list (list 4) 6) (list (list 8)) empty) ergeben.
;;    (deep-filter symbol? (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
;;       sollte (list (list empty) (list empty) empty) ergeben.
;; Schablone:
;;(define (process-lol a-lol)
;;  (cond [(empty? a-lol) ...]
;;        [else ... (first a-lol) ...
;;              ... (process-lol (rest a-lol) ...)]))
;; Definition:
(define (deep-filter fun ls)
  (i-deep-filter fun (reverse ls) empty))

(define (i-deep-filter fun ls akt)
  (cond [(empty? ls) akt]
        [(list? (first ls))
         (i-deep-filter fun
                        (rest ls)
                        (cons (i-deep-filter fun
                                             (reverse (first ls))
                                             empty)
                              akt))]
        [(fun (first ls))
         (i-deep-filter fun
                        (rest ls)
                        (cons (first ls)
                              akt))]
        [else (i-deep-filter fun
                             (rest ls)
                             akt)]))

;; Tests:
(check-expect (deep-filter number? (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
              (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
(check-expect (deep-filter even?   (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
              (list 2 (list (list 4) 6) (list (list 8)) empty))
(check-expect (deep-filter symbol? (list 1 2 (list 3 (list 4 5) 6) 7 (list (list 8)) empty 9))
              (list (list empty) (list empty) empty))