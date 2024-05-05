; Michael Soltys
; May 1, 2013
; Evaluate the next symbol in the Ehrenfeucht-Mycielski sequence
; Usage:
;        (em "01011001")
;

; computes length of string
; (length "01001") will be 5

; add some basic functions first
(load "simply.scm")

(define (length string)
    (if (empty? string)
        0
        (+ 1 (length (bf string)))))

; Obtain from string a new string' such that
; string' is string starting in pos i & ending in pos j
;
(define (substring string i j)
    ((repeated bf (- i 1))
        ((repeated bl (- (length string) j)) string)))

; Obtain from string a new string' such that
; string' is string with first i bits missing
; and last j bits missing
;
(define (substring-aux string i j)
    ((repeated bf i)
        ((repeated bl j) string)))

; Obtain suffix of string consisting of string with
; the first i symbols deleted:
;        (em-suffix "00011" 3) outputs "11"
;
(define (em-suffix string i)
    (let ((suffix ((repeated bf i) string)))
        suffix))

; Invoke always as (em-search "01101" i 1)
; that is, initially j=1
; it checks if there is a subword of string of length
; |string|-i that is equal to (em-suffix string i)
; note that if it exists it picks the one that occurs
; the latest - also note, that the suffix
; is not a candidate for such a subword
; Also note that recursion replaces a for-loop
; in general I found that in Scheme (since it is a
; functional language) for-loops are replaced with
; recursion.
;
(define (em-search string i j)
    (cond ((equal? (substring-aux string (- i j) j) (em-suffix string i))
                (let ((pos (+ (- (length string) j) 1))) (substring string pos pos)))
                ((< j i) (em-search string i (+ j 1)))
                (else 'notfound)))

; This function is meant to invoke the previous
; function em-search on suffixes of different
; length i - starting with i=1 (suffix consisting of
; the entire string except for the first symbol)
; ending with a suffix of length 1, i.e., just
; the last symbols of string
;
(define (em-prefix string i)
    (let ((next (em-search string i 1)))
        (if (and (< i (length string)) (equal? next 'notfound))
            (em-prefix string (+ i 1))
            next)))

; Invokes the entire procedure by initializing
; em-search with string and i=1
;
(define (em-mem string)
    (em-prefix string 1))

; Recall that in the Mycielski-Ehrenfeuch sequence
; we must invert (memory of primitive organism does
; not invert, but looks for the biggest earliest
; pattern and does the same - but in the M-E sequence
; we want a pseudo-random sequence, so we invert.
;
(define (em string)
    (if (equal? (em-mem string) "0")
        1
        0
        ))
