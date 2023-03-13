import Base.show

show(io::IO, z::QR{N}) where {N} = print(io, "[($(z.a)) + ($(z.b))*√$N]")
show(io::IO, ::MIME"text/plain", z::QR{N}) where {N} = show(io, z)