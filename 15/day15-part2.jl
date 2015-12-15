const format = r"^\w+: capacity ([-\d]+), durability ([-\d]+), flavor ([-\d]+), texture ([-\d]+), calories (\d+)"
const ones4 = ones(Int, 4)

# Trick to use hcat to generate a matrix out of an array of arrays
m = hcat(map(input -> map(parse, match(format, input).captures), readlines(STDIN))...)

maximum(0:100) do a
    maximum(0:(100-a)) do b
        maximum(0:(100-a-b)) do c
            sums = map(x -> max(x, 0), (m * diagm([a, b, c, 100-a-b-c])) * ones4)
            sums[5] == 500 ? reduce(*, sums[1:4]) : 0
        end
    end
end |> println
