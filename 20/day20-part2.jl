const presents = ceil(Int, parse(ARGS[1])/11)

using Iterators

n = round(Int, presents/exp(γ)log(log(presents) - γ))

while vcat([collect(repeated(k, v)) for (k, v) in factor(n)]...) |>
    subsets |> unique |> s -> sum(s) do p
        r = reduce(*, p)
        div(n, r) > 50 ? 0 : r
    end < presents
    n += 1
end

println(n)
