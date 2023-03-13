# `QuadraticRationals`


This module extends the rational numbers to numbers of the form `a+b*√d` 
where `a` and `b` are rational and `d` is a square-free integer.

The function `Sqrt` is the primary means to create numbers of this form. 
```
julia> using QuadraticRationals

julia> z = Sqrt(7)
[(0//1) + (1//1)*√7]

julia> w = Sqrt(-9)
[(0//1) + (3//1)*√-1]

julia> x = Sqrt(25)
5
```
Notice:
* `√(-9) = 3*√(-1)` so the number under the square root sign is square free.
* `25` is a perfect square, so an `Int` value is returned. 


All the usual arithmetic operations are available. However, one cannot operate or
compare numbers with different values under the square root.
```
julia> a = 3 - Sqrt(5); b = 4 + 2*Sqrt(5);

julia> a+b
[(7//1) + (1//1)*√5]

julia> a-b
[(-1//1) + (-3//1)*√5]

julia> a*b
[(2//1) + (2//1)*√5]

julia> a/b
[(-11//2) + (5//2)*√5]

julia> a==b
false

julia> 2a+5
[(11//1) + (-2//1)*√5]
```

## Inspection

For `x = a + b*Sqrt(d)`, calling `get_parts(x)` returns the triple `(a,b,d)`:
```
julia> z = 3 + 6*Sqrt(5)
[(3//1) + (6//1)*√5]

julia> get_parts(z)
(3//1, 6//1, 5)
```


## The `QR` Type

Numbers created with `Sqrt` (if not integers) have type `QR{d}` where `d`
is a square-free integer.
```
julia> z = 3 - Sqrt(-8)
[(3//1) + (-2//1)*√-2]

julia> typeof(z)
QR{-2}
```

This is useful to know when writing functions that take `QR` numbers as 
arguments. However, *do not* create new numbers directly by typing 
`QR{d}(a,b)` because no checking is done to ensure that `d` is 
square-free.


## To Do

* The output format is rather ugly. `2-Sqrt(11)` renders as `[(2//1) + (-1//1)*√11]` 
but would be nicer as `2 - √11`. I should fix this, I suppose.
* Include absolute value function. This should be easy. 