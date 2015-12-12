function ribbon_length(str)
    dim = [parse(Int, s) for s = split(str, 'x')]

    (sum(dim) - maximum(dim)) * 2 + reduce(*, dim)
end

println(sum(map(ribbon_length, readlines(STDIN))))
