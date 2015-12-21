const presents = ceil(Int, parse(ARGS[1])/10)

using Iterators

# See "Robin's inequality" at https://en.wikipedia.org/wiki/Divisor_function
# 'log(presents/exp(γ))=log(presents)-γ' is used here as a first approximation for log(n)
n = round(Int, presents/exp(γ)log(log(presents) - γ))

# 'factor' gives a Dict of prime factor => cardinality pairs, so the purpose of the
# [collect ...] call is to get an array of all prime factors
while vcat([collect(repeated(k, v)) for (k, v) in factor(n)]...) |>
    subsets |> unique |> s -> sum(p -> reduce(*, p), s) < presents
    n += 1
end

println(n)
