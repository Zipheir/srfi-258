;;; SPDX-FileCopyrightText: 2025 Wolfgang Corcoran-Mathe
;;; SPDX-License-Identifier: MIT

;;; SRFI 258: Uninterned symbols

;;; Wrapper implementation for ChezScheme.

(library (uninterned-symbols)
  (export string->uninterned-symbol symbol-interned?
          generate-uninterned-symbol)
  (import (rnrs base)
          (rnrs control)
          (only (chezscheme) uninterned-symbol?
                             string->uninterned-symbol
                             random))

  (define (symbol-interned? sym)
    (assert (symbol? sym))
    (not (uninterned-symbol? sym)))

  (define generate-uninterned-symbol
    (case-lambda
      (() (generate-uninterned-symbol ""))
      ((prefix)
       (assert (or (string? prefix) (symbol? prefix)))
       (let ((r (random (expt 2 128)))
             (p (if (symbol? prefix)
                    (symbol->string prefix)
                    prefix)))
         (string->uninterned-symbol
          (string-append p (number->string r)))))))
  )
