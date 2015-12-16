const format = r"^\w+: capacity ([-\d]+), durability ([-\d]+), flavor ([-\d]+), texture ([-\d]+)"
const ones4 = ones(Int, 4)

# Trick to use hcat to generate a matrix out of an array of arrays
m = hcat(map(input -> map(parse, match(format, input).captures), readlines(STDIN))...)

max_score = 0
for a in 0:100, b in 0:100-a, c in 0:100-a-b
    max_score = max(max_score, reduce(*, map(x -> max(x, 0), (m * diagm([a, b, c, 100-a-b-c])) * ones4)))
end

println(max_score)
