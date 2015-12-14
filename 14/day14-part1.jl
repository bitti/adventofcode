const format = r"^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+)"

function distance(name, speed, flytime, resttime, time)
    distance(map(parse, [speed flytime resttime time])...)
end

function distance(speed::Int, flytime::Int, resttime::Int, time::Int)
    phaselength = flytime + resttime
    (time÷phaselength) * speed * flytime + minimum((time%phaselength, flytime)) * speed
end

map(readlines(STDIN)) do input
    distance(match(format, input).captures..., ARGS[1])
end |> maximum |> println
