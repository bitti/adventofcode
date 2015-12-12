# Starting position
p = [0 0]

const directions = [
    '^' => [ 1  0],
    '>' => [ 0  1],
    'v' => [-1  0],
    '<' => [ 0 -1]]

# Starting house (wrap position inside a tuple to prevent destructuring)
const visited = Set((p,))

for d in readall(STDIN)    
    push!(visited, p += directions[d])
end

println(length(visited))
