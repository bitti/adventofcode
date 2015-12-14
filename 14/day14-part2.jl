type Reeindeer
    name::AbstractString
    speed::UInt
    flytime::UInt
    resttime::UInt
    score::UInt
    distance::UInt
end

const format = r"^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+)"

function Reeindeer(name, speed, flytime, resttime)
    Reeindeer(name, map(parse, [speed flytime resttime])..., 0 , 0)
end

function distance(reeindeer::Reeindeer, time)
    phaselength = reeindeer.flytime + reeindeer.resttime
    (time÷phaselength) * reeindeer.speed * reeindeer.flytime +
        minimum((time%phaselength, reeindeer.flytime)) * reeindeer.speed
end

const reeindeers = map(readlines(STDIN)) do input
    Reeindeer(match(format, input).captures...)
end

map(1:parse(UInt, ARGS[1])) do time
    max = maximum(reeindeer -> reeindeer.distance = distance(reeindeer, time), reeindeers)
    map(reeindeer -> reeindeer.score += 1, filter(reeindeer -> reeindeer.distance == max, reeindeers)) |> first
end

map(reeindeer -> reeindeer.score, reeindeers) |> maximum |> println
