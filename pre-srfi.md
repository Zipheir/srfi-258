# SRFI ???: Uninterned Symbols

# Abstract

An uninterned symbol is not the same as any other symbol, even one
with the same name. These symbols are useful in macro programming and
in other situations where guaranteed-unique names are needed. A survey
of uninterned and uniquely-named symbol implementations in Scheme is
also provided.

# Issues

Should uninterned symbols be readable?

# Rationale

A characteristic property of symbols in Scheme is that "two symbols
are identical (in the sense of `eqv?`) if and only if their names are
spelled the same way" (R7RS section 6.5). Such symbols are
traditionally known as *interned* symbols. It is sometimes useful,
however, to create *uninterned* symbols that are different from all
other symbols, even those with the same name.

Many Scheme implementations provide uninterned symbols, and they
are also part of the ANSI Common Lisp standard. Their use was almost
mandatory with unhygienic macro systems (like that of Common Lisp),
where they were used as "hidden" names that could not be accidentally
captured. This issue is largely solved by Scheme's hygienic macro
systems, but uninterned symbols still have their uses in Scheme macro
programming. They can be used as unique keys shared between
communicating macros or procedures, since there is no possibility of
collision between uninterned and user-created symbols.

The traditional way to
create a unique symbol is through a
`gensym` procedure. The name of this procedure is ubiquitous: it dates
back to at least LISP 1.5, and a variant of `gensym` is provided by
almost every Scheme implementation.
Unsurprisingly, the behavior of `gensym` procedures varies widely; in
particular, many `gensym`s return interned symbols (see
the Prior Art section below for details). To increase compatibility with
existing implementations, this document specifies another constructor,
`string->uninterned-symbol`, which is consistent across the Scheme
implementations that provide it.

# Specification

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

(symbol-interned? symbol) -> boolean

Returns #t if *symbol* is an interned (ordinary) symbol, and #f if it
is uninterned.

(generate-uninterned-symbol [prefix]) -> uninterned-symbol

Returns an uninterned symbol with a name that is likely to be unique.
If the optional *prefix* argument is provided and is a string / symbol,
then *prefix* / the name of *prefix* is prepended to the resulting
symbol's name.

Rationale:

`generate-uninterned-symbol` duplicates the behavior of `gensym` in
Scheme implementations that provide uninterned symbols (and in which
`gensym` returns an uninterned symbol).


## Prior Art

The following table summarizes existing support for uninterned symbols
and related objects in Scheme.

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

### Guile

Guile provides uninterned symbols, but these are not created by
`gensym`, which returns an interned symbol. Uninterned symbols are
created with `make-symbol`, instead. Guile's `gensym` "creates a new
symbol with a name constructed from a prefix and a counter value" and
accepts an optional prefix argument.


### MIT/GNU Scheme

No way to tell interned and uninterned symbols apart.

Uninterned symbols are unreadable.


# Implementation

A portable implementation of uninterned symbols is impossible. See the
table above for a list of Scheme implementations that provide
uninterned symbols and `string->uninterned-symbol`.

# Acknowledgments

Thanks to Daphne Preston-Kendall for pushing for this SRFI and to
Marc Nieper-Wißkirchen for challenging almost everything in it.

# Copyright
