;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Signatur: anhaltestrecke : number number number -> number

;; Zweck: Berechnung der Anhaltestrecke eines Autos bei einer
;; gegebenen Anfangsgeschwindigkeit (km/h) und Reaktionszeit (s)
;; sowie einer gegebenen Bremsbeschleunigung (m/s^2)

;; Beispiel: 
;; (anhaltestrecke 70 5 4) sollte 144.4830 mit Abweichung 0.1 ergeben.
;; (anhaltestrecke 90 2 7) sollte 94.6428 mit Abweichung 0.1 ergeben.
;; (anhaltestrecke 0 5 4) sollte 0 ergeben.
;; (anhaltestrecke 70 0 4) sollte 47.2608 mit Abweichung 0.1 ergeben.

;; Definition:
(define (anhaltestrecke zero-speed reaction-time brake-velocity)
  (+ (reaktionsweg zero-speed reaction-time)
  (bremsweg zero-speed brake-velocity)))

;; Tests
(check-within (anhaltestrecke 70 5 4) 144.4830 0.1)
(check-within (anhaltestrecke 90 2 7) 94.6428 0.1)
(check-expect (anhaltestrecke 0 5 4) 0)
(check-within (anhaltestrecke 70 0 4) 47.2608 0.1)

;; ---------------------------------------------------------------------

;; Signatur: geschw-umwandlung : number -> number

;; Zweck: Umrechnung der Anfangsgeschwindigkeit von km/h in m/s.

;; Beispiel: (geschw-umwandlung 60) sollte 16.66 m/s mit 0.1 Abweichung ergeben.
;; Beispiel: (geschw-umwandlung 0) sollte 0 m/s ergeben.
;; Beispiel: (geschw-umwandlung 1) sollte 0.277 m/s mit 0.1 Abweichung ergeben.

;; Definition:
(define (geschw-umwandlung zero-speed)
  (/(* zero-speed 1000) 3600))

;; Tests:
(check-within (geschw-umwandlung 60) 16.66 0.1)
(check-expect (geschw-umwandlung 0) 0)
(check-within (geschw-umwandlung 1) 0.277 0.1)



;; Signatur: reaktionsweg : number number -> number

;; Zweck: Berechnung des Reaktionwegs eines Autos in m bei einer
;; gegebenen Anfangsgeschwindigkeit (km/h) und Reaktionszeit (s).

;; Beispiel: (reaktionsweg 5 3600) sollte 5000 ergeben.
;; Beispiel: (reaktionsweg 5 0) sollte 0 ergeben.
;; Beispiel: (reaktionsweg 70 5) sollte 97.222 mit 0.1 Abweichung ergeben.

;; Definition:
(define (reaktionsweg zero-speed reaction-time)
  (* (geschw-umwandlung zero-speed) reaction-time))

;; Tests:
(check-expect (reaktionsweg 5 3600) 5000)
(check-expect (reaktionsweg 5 0) 0)
(check-within (reaktionsweg 70 5) 97.222 0.1)



;; Signatur: bremsweg : number number -> number

;; Zweck: Berechnung des Bremswegs eines Autos in m bei einer
;; gegebenen Anfangsgeschwindigkeit (km/h) sowie einer gegebenen Bremsbeschleunigung (m/s^2).

;; Beispiel: (bremsweg 70 4) sollte 47.2608 mit Abweichung 0.1 ergeben.
;; Beispiel: (bremsweg 70 7) sollte 27.0061 mit Abweichung 0.1 ergeben.
;; Beispiel: (bremsweg 0 4) sollte 0 ergeben.

;; Definition:
(define (bremsweg zero-speed brake-velocity)
  (/(* (geschw-umwandlung zero-speed) (geschw-umwandlung zero-speed))
    (* 2 brake-velocity)))

;; Tests:
(check-within (bremsweg 70 4) 47.2608 0.1)
(check-within (bremsweg 70 7) 27.0061 0.1)
(check-expect (bremsweg 0 4) 0)

;; ---------------------------------------------------------------------

