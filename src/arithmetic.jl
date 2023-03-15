import Base: (+), (-), (*), (/), (//), conj, inv, iszero, (==), isreal, isless

function (+)(x::_QR{d}, y::_QR{d})::_QR{d} where {d}
    _QR{d}(x.a + y.a, x.b + y.b)
end
function (+)(x::_QR{d}, y::QZ_type)::_QR{d} where {d}
    x + _QR{d}(y, 0)
end
function (+)(x::QZ_type, y::_QR{d})::_QR{d} where {d}
    y + _QR{d}(x, 0)
end



function (-)(x::_QR{d})::_QR{d} where {d}
    _QR{d}(-x.a, -x.b)
end
function (-)(x::_QR{d}, y::_QR{d})::_QR{d} where {d}
    _QR{d}(x.a - y.a, x.b - y.b)
end
function (-)(x::_QR{d}, y::QZ_type)::_QR{d} where {d}
    x - _QR{d}(y, 0)
end
function (-)(x::QZ_type, y::_QR{d})::_QR{d} where {d}
    _QR{d}(x, 0) - y
end



function (*)(x::_QR{d}, y::_QR{d}) where {d}
    aa = x.a * y.a + x.b * y.b * d
    bb = x.a * y.b + x.b * y.a
    _QR{d}(aa, bb)
end
function (*)(x::_QR{d}, y::QZ_type)::_QR{d} where {d}
    x * _QR{d}(y, 0)
end
function (*)(x::QZ_type, y::_QR{d})::_QR{d} where {d}
    _QR{d}(x, 0) * y
end




function conj(x::_QR{d})::_QR{d} where {d}
    return _QR{d}(x.a, -x.b)
end
function iszero(x::_QR{d})::Bool where {d}
    x.a == 0 && x.b == 0
end
function inv(x::_QR{d})::_QR{d} where {d}
    !iszero(x) || error("$x is not invertible")
    bottom = x.a * x.a - x.b * x.b * d
    _QR{d}(x.a // bottom, -x.b // bottom)
end


function (/)(x::_QR{d}, y::_QR{d})::_QR{d} where {d}
    return x * inv(y)
end
function (/)(x::_QR{d}, y::QZ_type)::_QR{d} where {d}
    return x / _QR{d}(y, 0)
end
function (/)(x::QZ_type, y::_QR{d})::_QR{d} where {d}
    return _QR{d}(x, 0) / y
end



function (//)(x::_QR{d}, y::_QR{d})::_QR{d} where {d}
    return x * inv(y)
end
function (//)(x::_QR{d}, y::QZ_type)::_QR{d} where {d}
    return x / _QR{d}(y, 0)
end
function (//)(x::QZ_type, y::_QR{d})::_QR{d} where {d}
    return _QR{d}(x, 0) / y
end



function (==)(x::_QR{d}, y::_QR{d}) where {d}
    return x.a == y.a && x.b == y.b
end
function (==)(x::_QR{d}, y::QZ_type) where {d}
    return x == _QR{d}(y, 0)
end
function (==)(x::QZ_type, y::_QR{d}) where {d}
    return _QR{d}(x, 0) == y
end

export value
"""
    value(x::_QR{d})::Union{Float64,ComplexF64} where {d}

Return the value of `x` as either floating point number 
(if `d` is positive) or as a complex floating point number 
(if `d` is negative).
"""
function value(x::_QR{d})::Union{Float64,ComplexF64} where {d}
    a, b, k = get_parts(x)

    if k ≥ 0
        return a + b * sqrt(k)
    end

    return a + b * sqrt(-k) * im
end

value(x::QZ_type)::Float64 = Float64(x)


function isreal(x::_QR{d})::Bool where {d}
    return d ≥ 0
end


function isless(x::_QR{d}, y::_QR{d})::Bool where {d}
    if d < 0
        error("Cannot compare $x and $y because they are complex")
    end

    return value(x) < value(y)
end

function isless(x::_QR{d}, y::QZ_type)::Bool where {d}
    isless(x, _QR{d}(y))
end

function isless(x::QZ_type, y::_QR{d})::Bool where {d}
    return isless(_QR{d}(x), y)
end
