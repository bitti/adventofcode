const format = r"(turn )?(on|off|toggle) (\d+),(\d+) \w+ (\d+),(\d+)"

lights = zeros(Uint, 1000, 1000)

for instruction in readlines(STDIN)
    _, action, x1, y1, x2, y2 = match(format, instruction).captures

    # 1-index based
    x1, x2, y1, y2 = map(x -> int(x) + 1, [x1 x2 y1 y2])

    lights[x1:x2, y1:y2] +=
        action == "toggle" ? 2 : action == "on" ? 1 : -sign(lights[x1:x2, y1:y2])
end

println(sum(lights))
