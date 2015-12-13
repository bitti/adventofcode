const format = r"(\w+) to (\w+) = (\w+)"
const distances = Dict{Pair, UInt}()
const locations = Set{AbstractString}()

for line in readlines(STDIN)
    loc1, loc2, distance = match(format, line).captures
    distances[loc1 => loc2] = distances[loc2 => loc1] = parse(UInt, distance)
    distances[nothing => loc1] = distances[nothing => loc2] = 0
    push!(locations, loc1, loc2)
end

function find_min(location, remaining_locations, distance)
    if isempty(remaining_locations)
        return distance
    end

    maximum(map(remaining_locations) do next_loc
        remaining = copy(remaining_locations)
        pop!(remaining, next_loc)
        find_min(next_loc, remaining, distance + distances[location => next_loc])
    end)
end

println(find_min(nothing, locations, 0))
