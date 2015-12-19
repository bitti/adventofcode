const format = r"(\w+) => (\w+)"
const replacements = []
const electrons = []
intput = ""

for line in readlines(STDIN)
    m = match(format, line)
    if m == nothing
        if line != ""
            input = line
        end
    else
        o, r = m.captures
        if o == "e"
            push!(electrons, r)
        else
            push!(replacements, Regex(r) => o)
        end
    end
end

# We can observe that the length of the left side of an replacement is always at most the
# length of the right side. Therefore we can conclude if we always apply the biggest
# replacement first and we find a solution this way, that there is no shorter way. (This
# also assumes that we don't have overlaps between patterns)
sort!(replacements, by = kv -> -length(first(kv).pattern))

function find_min(input)
    if input in electrons
        return 1
    end

    for (k, v) in replacements
        if ismatch(k, input)
            return length(matchall(k, input)) + find_min(replace(input, k, v))
        end
    end
end

println(find_min(input))
