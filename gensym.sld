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
        (() (gensym "g"))
        ((prefix)
         (let* ((p (cond ((symbol? prefix) (symbol->string prefix))
                         ((string? prefix) prefix)
                         (else (error "invalid argument" prefix))))
                (name (string-append
                       p
                       (number->string (current-jiffy))
                       "-"
                       (number->string (random-integer eddington)))))
           (string->symbol name)))))
  ))
