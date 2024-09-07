# SRFI ???: Gensyms

# Abstract

Gensyms are symbols that are very likely to be unique. They
can be used in macro programming to allow interacting
macros to communicate through a hidden identifier, or
as lightweight, reliably-unique, named values. Gensyms subsume uninterned
symbols, which are provided by some Scheme implementations.

# Issues

# Rationale

[Briefly explain "internedness".]

Most Scheme implementations provide uninterned symbols, and they
are also part of the ANSI Common Lisp standard. The well-known
`gensym` procedure, which often creates a new uninterned symbol,
is ubiquitous (dating back to at least LISP 1.5), although its
behavior varies widely.

This SRFI is an attempt to reconcile the different strategies that
Scheme implementations use to create unique (or at least reliably
unique) symbols. We do not require gensyms to be “uninterned”, nor do
we specify a scheme for ensuring that each gensym has a “fresh”
name.

Gensyms are mainly useful in macro programming. In
languages without hygienic macro systems, they are used to create
local identifiers which are "invisible" to other code. With hygienic
systems, this is obsolete, but a related technique
is still relevant: the "invisible" identifiers created from gensyms
can be used to pass information between macros.

[Example...]

# Specification

The words “should not” are to be interpreted as described in RFC 2119.

## Procedures

(gensym [prefix]) -> symbol

Returns a symbol. *prefix* may be a string or a symbol. If *prefix* is
provided, it (or its name, as given by `symbol->string`) is prefixed
to the name of the returned symbol; the name is otherwise unspecified. The
resulting symbol is very likely to be unique; it should not be
the same (in the sense of 'symbol=?' and 'eq?') as any other symbol.

It is unspecified whether a symbol created by `gensym` preserves the
write/read invariance described in R7RS §6.5. A gensym may not “read
back in” as the same symbol, and portable code should not assume that it
will.

Example:

(gensym "foo-") =>
  |foo-6f1c286463b144ff864af5247a0df|


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

The portable sample implementation uses `random-integer` from
[SRFI 27](https://srfi.schemers.org/srfi-27/) combined with
`current-jiffy` from `(scheme time)` to create reliably-unique
gensym names. A portable implementation that produces
*guaranteed*-unique symbols is not possible.

# Acknowledgments

Thanks to Daphne Preston-Kendall for pushing for this SRFI and to
Marc Nieper-Wißkirchen for challenging almost everything in it.

# Copyright
