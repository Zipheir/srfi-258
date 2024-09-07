(define-library (gensym)
  (import (scheme base)
          (scheme case-lambda)
          (scheme time)
          (srfi 27))
  (export gensym)
  (begin
    (define eddington (expt 10 80))

    (define gensym
      (case-lambda
        (() (gensym ""))
        ((prefix)
         (let* ((p (if (not (equal? prefix ""))
                       (string-append prefix "-")
                       ""))
                (name (string-append
                       p
                       (number->string (current-jiffy))
                       "-"
                       (number->string (random-integer eddington)))))
           (string->symbol name)))))
  ))
