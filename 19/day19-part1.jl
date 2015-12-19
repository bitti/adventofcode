const format = r"(\w+) => (\w+)"
const replacements = []
input = ""

for line in readlines(STDIN)
    m = match(format, line)
    if m == nothing
        if line != ""
            input = line
        end
    else
        o, r = m.captures
        push!(replacements, o => r)
    end
end

const s = []

for (k, v) in replacements
    splits = split(input, k)
    for i in 1:length(splits)-1
        push!(s, join(splits[1:i], k) * v * join(splits[i+1:end], k))
    end
end

println(length(unique(s)))
