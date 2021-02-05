;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Sets-Learnweb (1)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ---------------------------------------------------------------------

;; Datenanalyse und -definition:
;; Ein set ist eine Struktur (make-set elements). Hierbei
;; ist elements eine Liste von Elementen.

(define-struct set (elements))

;; Schablone:
;;     Signatur: process-set : set -> ???
;;(define (process-set set)
;;  (... (set-elements set) ...))

;; Beispiele:
(define set0 (make-set empty))
(define set1 (make-set (list 1 2 3)))
(define set2 (make-set (list 1 2 4 "a" "b")))
(define set3 (make-set (list "a" "b" "c" "d")))
(define set4 (make-set (list "a" "b" "c" "d" "a")))
(define set5 (make-set (list 1 2 3 3 4 4 1 1 1)))
(define set6 (make-set (list 1 2 4 "a" "b" 1 2 3 "a" "b")))
(define set7 (make-set 'quark))
;; fuer Teilmengen
(define set8 (make-set (list 1 2 3 4)))
(define set9 (make-set (list "a" "b")))


;; ---------------------------------------------------------------------
;; TEIL A

;; Signatur: valid-set? : set -> Boolean
;; Zweck: Ueberprueft, ob s ein gueltiges Set ist.

;; Beispiele:
;; (valid-set? set1) sollte true ergeben.
;; (valid-set? set2) sollte true ergeben.
;; (valid-set? set3) sollte true ergeben.
;; (valid-set? set4) sollte false ergeben.
;; (valid-set? set5) sollte false ergeben.
;; (valid-set? set6) sollte false ergeben.
;; (valid-set? set7) sollte den Fehler "Keine Liste!" ergeben.
;; (valid-set? 'quark) sollte den Fehler "Kein Set!" ergeben.
;; (valid-set? set0) sollte true ergeben.

;; Definition:
(define (valid-set? s)
  (cond [(not (set? s))
         (error "Kein Set!")]
        [(not (list? (set-elements s)))
         (error "Keine Liste!")]
        [else
         (valid-set?-internal (set-elements s))]))


;; Signatur: valid-set?-internal : list -> Boolean
;; Zweck: Ueberprueft, ob sich Elemente in der Liste s dopplen.

;; Schablone
;;      Signatur: process-list : list -> ???
;;(define (process-list a-list)
;;  (cond
;;    [(empty? a-list) ...]
;;    [else ... (first a-list) ...
;;          ... (rest a-list) ...]))

;; Definition:
(define (valid-set?-internal s)
  (cond [(empty? s) true]
        [(contains?-internal (first s) (rest s))
         false]
        [else
         (valid-set?-internal (rest s))]))

;; Tests:
(check-expect (valid-set? set1) true)
(check-expect (valid-set? set2) true)
(check-expect (valid-set? set3) true)
(check-expect (valid-set? set4) false)
(check-expect (valid-set? set5) false)
(check-expect (valid-set? set6) false)
(check-error (valid-set? set7) "Keine Liste!")
(check-error (valid-set? 'quark) "Kein Set!")
(check-expect (valid-set? set0) true)
        

;; ---------------------------------------------------------------------
;; TEIL B

;; Signatur: contains? : list-element* set -> Boolean
;;     *list-element ist jedes in einer Liste zulaessige Element
;; Zweck: Ueberprueft, ob das Element el in dem Set st enthalten ist.

;; Beispiele:
;; (contains? "b" set1) sollte false ergeben.
;; (contains? 2 set2) sollte true ergeben.
;; (contains? 'quark set2) sollte false ergeben.
;; (contains? "a" set4) "Kein gueltiges Set!")
;; (contains? "a" set7) "Keine Liste!")

;; Definition:
(define (contains? el st)
  (cond [(valid-set? st)
         (if(contains?-internal el (set-elements st))
            true
            false)]
        [else (error "Kein gueltiges Set!")]))


;; Signatur: contains?-internal : list-element* list -> Boolean.
;; Zweck: Ueberprueft, ob das Element el in der Liste st enthalten ist.

;; Definition:
(define (contains?-internal el st)
  (cond
    [(empty?  st) false]
    [else (if (equal? el (first st))
              true
              (contains?-internal el (rest st)))]
    ))

;; Tests:
(check-expect (contains? "b" set1) false)
(check-expect (contains? 2 set2) true)
(check-expect (contains? 'quark set2) false)
(check-error (contains? "a" set4) "Kein gueltiges Set!")
(check-error (contains? "a" set7) "Keine Liste!")

;; ---------------------------------------------------------------------
;; TEIL C
;; Signatur: subset? : set set -> Boolean
;; Zweck: Bestimmt, ob das set set1 in dem set set2 enthalten ist.

;; Beispiele:
;; (subset? 'quark 'quark) sollt den Fehler "Kein Set!" ergeben.
;; (subset? set1 set8) sollte true ergeben.
;; (subset? set8 set1) sollte false ergeben.
;; (subset? set1 set1) sollte true ergeben.
;; (subset? set0 set1) sollte true ergeben.
;; (subset? set9 set3) sollte true ergeben.
;; (subset? set3 set9) sollte false ergeben.

;; Definition:
(define (subset? set1 set2)
  (cond [(not (and (valid-set? set1)
                   (valid-set? set2)))
         (error 'subset? "Ungueltige Sets uebergeben!")]
        [else (subset?-internal (set-elements set1)
                                (set-elements set2))]))

;; Signatur: subset?-internal : list list -> Boolean
;; Zweck: Bestimmt, ob die Liste l1 in der List l2 enthalten ist.

;; Definition:
(define (subset?-internal l1 l2)
  (cond [(empty? l1)
         true]
        [(empty? l2)
         false]
        [(contains?-internal (first l1) l2)
         (subset?-internal (rest l1) l2)]
        [else
         false]))
         
;; Tests:
(check-error (subset? 'quark 'quark) "Kein Set!")
(check-expect (subset? set1 set8) true)
(check-expect (subset? set8 set1) false)
(check-expect (subset? set1 set1) true)
(check-expect (subset? set0 set1) true)
(check-expect (subset? set9 set3) true)
(check-expect (subset? set3 set9) false)


;; ---------------------------------------------------------------------
;; TEIL D
;; Signatur: equal-set? : set set -> Boolean
;; Zweck: Bestimmt, ob die sets set1 und set2 identisch sind.

;; Beispiele:
;; (equal-set? set1 set1) sollte true ergeben.
;; (equal-set? set1 set8) sollte false ergeben.

;; Definition:
(define (equal-set? set1 set2)
  (and (subset? set1 set2)
       (subset? set2 set1)))

;; Tests:
(check-expect (equal-set? set1 set1) true)
(check-expect (equal-set? set1 set8) false)