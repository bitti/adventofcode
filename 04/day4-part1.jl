using Nettle

const key = ARGS[1]

nounce = 1

while !startswith(hexdigest("MD5", key*string(nounce)), "0"^5)
    nounce += 1
end

println(nounce)
