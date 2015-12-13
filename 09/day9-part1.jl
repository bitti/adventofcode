const format = r"(\w+) to (\w+) = (\w+)"
const distances = Dict{Pair{SubString{UTF8String}, SubString{UTF8String}}, UInt}()
const locations = Set{AbstractString}()

for line in readlines(STDIN)
    loc1, loc2, distance = match(format, line).captures
    distances[loc1 => loc2] = distances[loc2 => loc1] = parse(UInt, distance)
    push!(locations, loc1, loc2)
end

function find_min(location, remaining_locations, distance)
    if isempty(remaining_locations)
        return distance
    end

    minimum(map(remaining_locations) do next_loc
        remaining = copy(remaining_locations)
        pop!(remaining, next_loc)
        if location == nothing
            find_min(next_loc, remaining, distance)
        else
            find_min(location, remaining, distance + distances[location => next_loc])
        end
    end)
end

println(find_min(nothing, locations, 0))
