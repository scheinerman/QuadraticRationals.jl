using Test, QuadraticRationals

x = 3 + Sqrt(-6)
@test x * inv(x) == 1
@test x - x == 0
@test 2x == x+x 

x = 12 - Sqrt(11)
@test x * inv(x) == 1
@test x - x == 0
@test 2x == x+x 