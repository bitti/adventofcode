const key = ARGS[1]

nounce = 1

function md5(str)
    const d = Array(UInt8, 16)
    ccall((:MD5, "libgnutls-openssl"), Ptr{UInt8}, (Ptr{UInt8}, UInt64, Ptr{UInt8}), str, sizeof(str), d)
    d
end

# NOTE: At least in Julia 0.3.6 and 0.4.1 "$key$nounce" seems to be much slower
while reduce(|, md5(key*string(nounce))[1:3]) != 0
    nounce += 1
end

println(nounce)
