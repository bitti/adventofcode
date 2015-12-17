const containers = sort(map(parse, readlines(STDIN)))
const volume = parse(ARGS[1])

function fill(rest, volume, containers)
    if volume == 0
        produce(containers)
        return
    end
    for (i, c) in enumerate(rest)
        if c > volume
            return
        end
        newrest = copy(rest)
        deleteat!(newrest, 1:i)
        fill(newrest, volume - c, containers + 1)
    end
end

numbers = collect(Task(() -> fill(containers, volume, 0)))
min = minimum(numbers)
println(count(p -> p == min, numbers))
