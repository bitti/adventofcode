const format = r"Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)"
const detection = Dict(
    "children" => "3",
    "cats" => "7",
    "samoyeds" => "2",
    "pomeranians" => "3",
    "akitas" => "0",
    "vizslas" => "0",
    "goldfish" => "5",
    "trees" => "3",
    "cars" => "2",
    "perfumes" => "1"
)

for input in readlines(STDIN)
    n, f1, v1, f2, v2, f3, v3 = match(format, input).captures
    if detection[f1] == v1 && detection[f2] == v2 && detection[f3] == v3
        println(n)
    end    
end
