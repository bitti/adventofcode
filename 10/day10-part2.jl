const chunk = r"(.)\1*"
input = ARGS[1]

for i in 1:50
    input = reduce(*, map(m -> string(length(m))*m[1:1], matchall(chunk, input)))
end

println(length(input))
