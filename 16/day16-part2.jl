const format = r"Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)"
const detection = Dict(
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
)

for input in readlines(STDIN)
    n, f1, v1, f2, v2, f3, v3 = match(format, input).captures
    v1, v2, v3 = map(parse, [v1 v2 v3])
    if all(zip([f1 f2 f3], [v1 v2 v3])) do p
        f, v = p
        if f == "cat" || f == "trees"
            detection[f1] < 1
        elseif f == "pomeranians" || f == "goldfish"
            detection[f] > v
        else
            detection[f] == v
        end
    end
        println(n)
    end
end
