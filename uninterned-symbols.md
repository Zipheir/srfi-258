# Uninterned symbols

Survey of forms provided by Scheme implementations for working with
uninterned symbols.


# ChezScheme

* gensym (returns an interned symbol)
* gensym-prefix (parameter)
* gensym-count (parameter)
* gensym->unique-string
* gensym?

Notes: Provided by the (chezscheme) library. No uninterned symbols.
Gensyms have "pretty" and "unique" names. The latter are created
immediately and the former are generated lazily using an internal
prefix and counter, which are accessible through parameter objects.
gensym->unique-string returns the unique name of a gensym.

gensym takes optional *pretty-name* and *unique-name* string arguments.


# CHICKEN

* gensym (result is uninterned)
* string->uninterned-symbol

Notes: Provided by (chicken base). gensym may take a string-or-symbol
prefix argument. No way to tell interned and uninterned objects apart.


# Cyclone

* gensym (?)

Notes: It's not clear from Cyclone's documentation whether gensym
creates an uninterned symbol.


# Gambit

* gensym (result is uninterned)
* string->uninterned-symbol
* uninterned-symbol?

Notes: gensym may take a symbol prefix argument.
string->uninterned-symbol may take a non-negative integer *hash*
argument.


# Guile

* gensym (creates an interned symbol)
* make-symbol (creates an uninterned symbol)
* symbol-interned?

Notes: make-symbol takes a (required) string prefix argument. gensym
(which creates an interned symbol that is "likely to be unique") may
also take a string prefix.


# Kawa

None.


# MIT/GNU Scheme

* generate-uninterned-symbol
* string->uninterned-symbol

Notes: generate-uninterned-symbol is functionally equivalent to the
gensym procedures of other implementations. It may take an *object*
argument which is used several ways. A string or symbol argument is
used as a prefix.


# Racket

* string->uninterned-symbol
* gensym (result is uninterned)
* symbol-interned?

Notes: gensym may take a symbol-or-string prefix argument.


# TinySCHEME

No uninterned symbols. gensym returns an interned symbol.
