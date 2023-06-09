module QuadraticRationals
using Primes

# export _magic_sqrt, _is_square_free, QZ_type

export Sqrt, QuadraticRational, get_parts, QZ_type
export rational_part, get_radical


Int_type = Union{Int,Int128}

"""
    QZ_type
Type that is either `Int` or `Rational{Int}`
"""
QZ_type = Union{Int,Int128,Rational{Int},Rational{Int128}}

struct QuadraticRational{k} <: Number
    a::Rational{Int128}
    b::Rational{Int128}
end

_QR = QuadraticRational

_QR{d}(a::QZ_type) where {d} = _QR{d}(a, 0)
_QR{d}(a::Bool) where {d} = _QR{d}(Int(a))

"""
    _is_square_free(n::Int_type)::Bool

Determine if `n` is square free.
"""
_is_square_free(n::Int_type)::Bool = n == radical(n)


"""
    Sqrt(n::Int_type)::Union{Int_type,_QR}

Compute the square root of an integer `n`. 

If `n` is a perfect square,
then an `Int` value is returned. Otherwise, the result is of the form
`0+b√d` where `b` and `d` are integers.
"""
function Sqrt(n::Int_type)::Union{Int_type,_QR}
    if n >= 0
        s = isqrt(n)
        if s * s == n
            return s
        end
    end

    b, d = _magic_sqrt(n)
    return _QR{d}(0, b)
end

"""
    _magic_sqrt(n::Int_type)::Tuple{Int_type,Int_type}

Return `(a,b)` such that `n = a * sqrt(b)` and `b`
is square-free. 

Examples 
* `_magic_sqrt(12)` → `(4,3)`
* `_magic_sqrt(-25)` → `(5,-1)`
"""
function _magic_sqrt(n::Int_type)::Tuple{Int_type,Int_type}
    s = n > 0 ? 1 : -1    # sign of n preserved
    n = abs(n)

    a = 1
    b = s

    F = factor(n).pe
    for pt in F
        p = pt[1]
        t = pt[2]

        p, t = pt
        a *= p^div(t, 2)
        b *= p^mod(t, 2)
    end
    return a, b
end


"""
    get_parts(x::_QR{d}) where d

If `x = a + b*√d`, return the 3-tuple `(a,b,d)`.
"""
function get_parts(x::_QR{d}) where {d}
    return x.a, x.b, d
end

get_parts(x::QZ_type) = (x, 0, 1)


function _integerize(a::QZ_type)::QZ_type
    isinteger(a) ? Int128(a) : a
end

"""
    rational_part(x::_QR)

If `x =a + b*√d`, return `a`.
"""
function rational_part(x::_QR)
    _integerize(x.a)
end
function rational_part(x::QZ_type)
    _integerize(x)
end



"""
    get_radical(::QuadraticRational{d}) 
    get_radical(::Int)
    get_radical(::Rational)

Return `d` if a quadratic rational, or `1` if integer/rational
"""
get_radical(::QuadraticRational{d}) where {d} = d
get_radical(::QZ_type) = 1

include("output.jl")
include("arithmetic.jl")


end # module QuadraticRationals