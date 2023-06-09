import Base: show


function _rat_string(x::Rational{T}) where T<:Int_type
    if denominator(x) == 1
        return string(numerator(x))
    end
    return string(x)

end



function _string(z::_QR{k}) where {k}
    a, b, d = get_parts(z)
    mult = "⋅"

    if a != 0
        sym = b < 0 ? " - " : " + "
        b = abs(b)
        str_a = _rat_string(a)
        str_b = b == 1 ? "" : _rat_string(b) * mult
        return "$str_a" * sym * "$str_b√$d"
    end
    sym = b < 0 ? "-" : ""
    b = abs(b)
    str_b = b == 1 ? "" : _rat_string(b) * mult
    return sym * "$str_b√$d"

end

show(io::IO, z::_QR{N}) where {N} = print(io, _string(z))
show(io::IO, ::MIME"text/plain", z::_QR{N}) where {N} = show(io, z)