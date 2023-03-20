using Test, QuadraticRationals

x = 3 + Sqrt(-6)
@test x * inv(x) == 1
@test x - x == 0
@test 2x == x + x

x = 12 - Sqrt(11)
@test x * inv(x) == 1
@test x - x == 0
@test 2x == x + x
@test (2x) // 2 == x
@test (2x) // x == 2

@test Sqrt(8) == 2Sqrt(2)

@test value(Sqrt(2)) == sqrt(2)
@test !isreal(Sqrt(-3))

f = (Sqrt(5) + 1) / 2  # golden mean

@test f * f - f - 1 == 0

@test 1 + Sqrt(2) > 1 - Sqrt(2)

x = 3 + Sqrt(5)
@test get_parts(x) == (3, 1, 5)

x = 2 // 3
@test get_parts(x) == (2//3, 0, 1)
