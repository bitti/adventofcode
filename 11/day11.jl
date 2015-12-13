function rule1(str)
    if length(str)<3
        return false
    end
    a, b, c = str
    b+1 == c ? (a+1 == b || rule1(str[2:end])) : rule1(str[3:end])
end

const rule2 = str -> !ismatch(r"[iol]", str)
const rule3 = str -> length(unique(matchall(r"(.)\1", input))) >= 2

function increment(str)
    prefix = str[1:end-1]
    last = str[end]
    if last == 'z'
        increment(prefix)*"a"
    else
        prefix*string(last+1)
    end
end

input = increment(ARGS[1])
while !(rule1(input) && rule2(input) && rule3(input))
    input = increment(input)
end

println(input)
