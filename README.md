# `QuadraticRationals`


This module extends the rational numbers to numbers of the form `a+b*√d` 
where `a` and `b` are rational and `d` is a square-free integer. In other words,
elements of `Q(√d)`.

The function `Sqrt` is the primary tool to create numbers of this form. 
```
julia> using QuadraticRationals

julia> z = Sqrt(7)
0 + √7

julia> w = Sqrt(-9)
0 + 3⋅√-1

julia> x = Sqrt(25)
5
```
Notice:
* `√(-9) = 3*√(-1)` so the number under the square root sign is square free.
* Applying `Sqrt` to a perfect square returns an `Int`.

## Operations and Functions

All the usual arithmetic operations are available. However, one cannot operate or
compare numbers with different values under the square root.
```
julia> a = 3 - Sqrt(5); b = 4 + 2*Sqrt(5);

julia> a+b
7 + √5

julia> a-b
-1 - 3⋅√5

julia> a*b
2 + 2⋅√5

julia> a/b
-11//2 + 5//2⋅√5

julia> a==b
false

julia> 2a+5
11 - 2⋅√5
```

The `value` function renders a quadratic rational number as either a floating 
point number or a complex floating point number:
```
julia> value(1+Sqrt(2))
2.414213562373095

julia> value(1+Sqrt(-2))
1.0 + 1.4142135623730951im
```

The function `isreal` may be applied as expected:
```
julia> isreal(1+Sqrt(2))
true

julia> isreal(1+Sqrt(-2))
false
```

Real quadratic rational numbers can be compared using the usual `<` sorts of order
relations:
```
julia> 3 + Sqrt(5) < 1 + 2*Sqrt(5)
true
```
Note that imaginary values cannot be compared with order relations.
```
julia> 3-Sqrt(-5) < 2*Sqrt(-5)
ERROR: Cannot compare 3 - √-5 and 0 + 2⋅√-5 because they are complex
```

## Inspection

For `x = a + b*Sqrt(d)`, calling `get_parts(x)` returns the triple `(a,b,d)`:
```
julia> z = 3 + 6*Sqrt(5)
3 + 6⋅√5

julia> get_parts(z)
(3//1, 6//1, 5)
```


## The `QuadraticRational` Type

Numbers created with `Sqrt` (if not integers) have type `QuadraticRational{d}` where `d`
is a square-free integer.
```
julia> z = 3 - Sqrt(-8)
3 - 2⋅√-2

julia> typeof(z)
QuadraticRational{-2}
```

This is useful to know when writing functions that take `QuadraticRational` numbers as 
arguments. However, *do not* create new numbers directly by typing 
`QuadraticRational{d}(a,b)` because no checking is done to ensure that `d` is 
square-free.

