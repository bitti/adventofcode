const format = r"(turn )?(on|off|toggle) (\d+),(\d+) \w+ (\d+),(\d+)"

const lights = falses(1000, 1000)

for instruction in readlines(STDIN)
    _, action, x1, y1, x2, y2 = match(format, instruction).captures

    # 1-index based
    x1, x2, y1, y2 = map(x -> parse(Int, x) + 1, [x1 x2 y1 y2])

    # NOTE: I also tried out flipbits! but that doesn't mutate subarrays
    lights[x1:x2, y1:y2] = action == "toggle" ? ~lights[x1:x2, y1:y2] : action == "on"
end

println(sum(lights))
