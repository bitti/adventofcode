const key = ARGS[1]

nounce = 1

function md5(str)
    const d = Array(UInt8, 16)
    ccall((:MD5, "libgnutls-openssl"), Ptr{UInt8}, (Ptr{UInt8}, UInt64, Ptr{UInt8}), str, sizeof(str), d)
    d
end

while (d = md5(key*string(nounce)); reduce(|, d[1:2]) | (d[3] & 0xf0) != 0)
    nounce += 1
end

println(nounce)
