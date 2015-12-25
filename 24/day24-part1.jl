using Iterators

const weights = reverse(sort(map(parse, readlines(STDIN))))
const g = sum(weights)//3

function group(cw, g_weights, weights)
    cw == g && return g_weights

    for w in weights
        cw + w > g && continue
        ws = copy(weights)
        gw = copy(g_weights)
        push!(gw, w)
        ws = setdiff(ws, [w])
        gw = group(cw + w, gw, ws)
        gw != nothing && return gw
    end
end

# Since we pick biggest weights first we know that 'group' returns a solution with the
# smallest number of elements for a group of weight 'g'
candidate = group(0, [], weights)

# Now we have to figure out if there is another candidate of the same length with a lower
# quantum entanglement
qe = typemax(Int)

for s in subsets(weights, length(candidate))
    sqe = reduce(*, s)
    (sum(s) != g || sqe >= qe) && continue

    # Confirm that there is still a solution with this candidate for the other groups
    w = setdiff(weights, candidate)
    gw = group(0, [], w)
    gw == nothing && continue
    @assert sum(setdiff(w, gw)) == g

    canditate = s
    qe = sqe
end

println(qe)
