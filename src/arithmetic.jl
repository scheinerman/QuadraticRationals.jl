import Base: (+), (-), (*), (/), (//), conj, inv, iszero, (==), isreal

function (+)(x::QR{d}, y::QR{d})::QR{d} where {d}
    QR{d}(x.a + y.a, x.b + y.b)
end
function (+)(x::QR{d}, y::QZ_type)::QR{d} where {d}
    x + QR{d}(y, 0)
end
function (+)(x::QZ_type, y::QR{d})::QR{d} where {d}
    y + QR{d}(x, 0)
end



function (-)(x::QR{d})::QR{d} where {d}
    QR{d}(-x.a, -x.b)
end
function (-)(x::QR{d}, y::QR{d})::QR{d} where {d}
    QR{d}(x.a - y.a, x.b - y.b)
end
function (-)(x::QR{d}, y::QZ_type)::QR{d} where {d}
    x - QR{d}(y, 0)
end
function (-)(x::QZ_type, y::QR{d})::QR{d} where {d}
    QR{d}(x, 0) - y
end



function (*)(x::QR{d}, y::QR{d}) where {d}
    aa = x.a * y.a + x.b * y.b * d
    bb = x.a * y.b + x.b * y.a
    QR{d}(aa, bb)
end
function (*)(x::QR{d}, y::QZ_type)::QR{d} where {d}
    x * QR{d}(y, 0)
end
function (*)(x::QZ_type, y::QR{d})::QR{d} where {d}
    QR{d}(x, 0) * y
end




function conj(x::QR{d})::QR{d} where {d}
    return QR{d}(x.a, -x.b)
end
function iszero(x::QR{d})::Bool where {d}
    x.a == 0 && x.b == 0
end
function inv(x::QR{d})::QR{d} where {d}
    !iszero(x) || error("$x is not invertible")
    bottom = x.a * x.a - x.b * x.b * d
    QR{d}(x.a // bottom, -x.b // bottom)
end


function (/)(x::QR{d}, y::QR{d})::QR{d} where {d}
    return x * inv(y)
end
function (/)(x::QR{d}, y::QZ_type)::QR{d} where {d}
    return x / QR{d}(y, 0)
end
function (/)(x::QZ_type, y::QR{d})::QR{d} where {d}
    return QR{d}(x, 0) / y
end



function (//)(x::QR{d}, y::QR{d})::QR{d} where {d}
    return x * inv(y)
end
function (//)(x::QR{d}, y::QZ_type)::QR{d} where {d}
    return x / QR{d}(y, 0)
end
function (//)(x::QZ_type, y::QR{d})::QR{d} where {d}
    return QR{d}(x, 0) / y
end



function (==)(x::QR{d}, y::QR{d}) where {d}
    return x.a == y.a && x.b == y.b
end
function (==)(x::QR{d}, y::QZ_type) where {d}
    return x == QR{d}(y, 0)
end
function (==)(x::QZ_type, y::QR{d}) where {d}
    return QR{d}(x, 0) == y
end

export value
"""
    value(x::QR{d})::Union{Float64,ComplexF64} where {d}

Return the value of `x` as either floating point number 
(if `d` is positive) or as a complex floating point number 
(if `d` is negative).
"""
function value(x::QR{d})::Union{Float64,ComplexF64} where {d}
    a, b, k = get_parts(x)

    if k ≥ 0
        return a + b * sqrt(k)
    end

    return a + b * sqrt(-k) * im
end

value(x::QZ_type)::Float64 = Float64(x)


function isreal(x::QR{d})::Bool where d
    return d ≥ 0 
end

