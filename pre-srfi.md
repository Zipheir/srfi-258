# SRFI ???: Uninterned Symbols

# Abstract


# Issues

# Rationale

[Briefly explain "internedness".]

Most Scheme implementations provide uninterned symbols, and they
are also part of the ANSI Common Lisp standard. The well-known
`gensym` procedure, which often creates a new uninterned symbol,
is ubiquitous (dating back to at least LISP 1.5), although its
behavior varies widely.

# Specification

The words “should not” are to be interpreted as described in RFC 2119.

An uninterned symbol is a symbol (in the sense of `symbol?`) which is
not identical (in the sense of `symbol=?`) with any other symbol, even
a symbol with the same name.

Uninterned symbols do not support the write/read invariance described
in R7RS section 6.5: if an uninterned symbol is written out with
`write` and then read back in, the resulting symbol is not identical
(in the sense of `symbol=?`) to the original symbol.

## Procedures

(string->uninterned-symbol string) -> uninterned-symbol

Returns an uninterned symbol with a name given by *string*.


## Prior Art

### ChezScheme

Chez provides interned gensyms which can be
distinguished by the `gensym?` predicate. Chez's gensyms
have "pretty" and "unique" names. The former are created
immediately and the latter are generated lazily using an internal
prefix and counter, which are accessible through parameter objects.
`gensym->unique-string` returns the unique name of a gensym.

Chez's `gensym` procedure takes optional *pretty-name* and
*unique-name* string arguments. The latter argument allows the unique
name of one gensym to be given to another; thus, distinct gensyms that
are equal in the sense of `symbol=?` can be created in Chez.


### CHICKEN

CHICKEN provides uninterned symbols, created by `gensym` or
`string->uninterned-symbol`. CHICKEN's `gensym` takes an
optional *prefix* argument, which may be a string or a symbol.


### Cyclone

Cyclone provides a (currently undocumented) `gensym` procedure.


### Gambit

Gambit provides uninterned symbols created by `gensym` or
`string->uninterned-symbol`. `gensym` accepts a symbol prefix argument.


### Guile

Guile provides uninterned symbols, but these are not created by
`gensym`, which returns an interned symbol. Uninterned symbols are
created with `make-symbol`, instead. Guile's `gensym` "creates a new
symbol with a name constructed from a prefix and a counter value" and
accepts an optional prefix argument.


### MIT/GNU Scheme

* generate-uninterned-symbol
* string->uninterned-symbol

Notes: generate-uninterned-symbol is functionally equivalent to the
gensym procedures of other implementations. It may take an *object*
argument which is used in several ways. A string or symbol argument is
used as a prefix. No way to tell interned and uninterned symbols
apart.


### Racket

Racket provides a `gensym` procedure which returns an uninterned
symbol. It accepts an optional prefix argument, which may be a string
or a symbol.


### TinySCHEME

TinySCHEME provides a `gensym` procedure which returns an interned
symbol.


# Implementation


# Acknowledgments

Thanks to Daphne Preston-Kendall for pushing for this SRFI and to
Marc Nieper-Wißkirchen for challenging almost everything in it.

# Copyright
