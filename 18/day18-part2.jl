const lights = hcat([Bool[c == '#' for c in line] for line in map(chomp, readlines(STDIN))]...)

function reset_corners(lights)
    lights[1, 1] = lights[1, end] = lights[end, 1] = lights[end, end] = true
end

for i in 1:100
    reset_corners(lights)

    nc = zeros(UInt, size(lights))
    nc[2:end, 1:end] += lights[1:end-1,1:end]
    nc[1:end-1, 1:end] += lights[2:end,1:end]
    nc[1:end, 2:end] += lights[1:end,1:end-1]
    nc[1:end, 1:end-1] += lights[1:end,2:end]
    nc[2:end, 1:end-1] += lights[1:end-1,2:end]
    nc[1:end-1, 1:end-1] += lights[2:end,2:end]
    nc[1:end-1, 2:end] += lights[2:end,1:end-1]
    nc[2:end, 2:end] += lights[1:end-1,1:end-1]

    for e in enumerate(nc)
        j, v = e
        lights[j] = v == 3 || v == 2 && lights[j]
    end
end
reset_corners(lights)

println(sum(lights))
