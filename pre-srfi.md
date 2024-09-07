# SRFI ???: Gensyms

# Abstract

Gensyms are symbols that are very likely to be unique. They have several uses
in macro programming. For example, they can be used to allow interacting
macros to communicate through a hidden identifier, or
as lightweight, unique, named values. Gensyms subsume uninterned
symbols, which are provided by some Scheme implementations.

# Issues

# Rationale

Most Scheme implementations provide uninterned symbols, and they
are also part of the ANSI Common Lisp standard. The well-known
`gensym` procedure, which often creates a new uninterned symbol,
is ubiquitous (dating back to at least LISP 1.5), although its
behavior varies widely.

Gensyms are mainly useful in macro programming. In
languages without hygienic macro systems, they are used to create
local identifiers which are "invisible" to other code. With hygienic
systems, this is obsolete, but a related technique
is still relevant: the "invisible" identifiers created from uninterned
symbols can be used to pass information between macros.

[Example...]

# Specification

The words “should not” are to be interpreted as described in RFC 2119.

## Procedures

(gensym [string]) -> symbol

Returns a symbol. If *string* is provided, the symbol's name is
prefixed with *string*; the name is otherwise unspecified. The
resulting symbol is very likely to be unique; it should not be
the same (in the sense of 'symbol=?' and 'eq?') as any other symbol.

Example:

(generate-uninterned-symbol "foo-") =>
  |foo-6f1c286463b144ff864af5247a0df|


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
