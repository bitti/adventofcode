key = ARGS[1]

nounce = 1

using Nettle

while !beginswith(hexdigest("MD5", key*string(nounce)), "0"^5)
    nounce += 1
end

println(nounce)
