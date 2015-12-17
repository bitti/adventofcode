const containers = sort(map(parse, readlines(STDIN)))
const volume = parse(ARGS[1])

function fill(rest, volume)
    if volume == 0
        produce(1)
        return
    end
    for (i, c) in enumerate(rest)
        if c > volume
            return
        end
        newrest = copy(rest)
        deleteat!(newrest, 1:i)
        fill(newrest, volume - c)
    end
end

println(sum(Task(() -> fill(containers, volume))))
