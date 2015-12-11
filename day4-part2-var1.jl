key = ARGS[1]

nounce = 1

function md5(str)
    d = Array(Uint8, 16)
    ccall((:MD5, "libgnutls-openssl"), Ptr{Uint8}, (Ptr{Uint8}, Uint64, Ptr{Uint8}), str, sizeof(str), d)
    d
end

while !(d = md5(key*string(nounce)); reduce(|, d[1:3]) == 0)
    nounce += 1
end

println(nounce)
