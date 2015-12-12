# Starting positions
p1 = p2 = [0 0]

const directions = Dict(
    '^' => [ 1  0],
    '>' => [ 0  1],
    'v' => [-1  0],
    '<' => [ 0 -1])

# Starting house (wrap position inside a tuple to prevent destructuring)
const visited = Set((p1,))

for d in readall(STDIN)
    push!(visited, p1 += directions[d])

    # Swap roles
    p1, p2 = p2, p1
end

println(length(visited))
