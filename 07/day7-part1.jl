const format = r"(\w+|NOT (\w+)|(\w+) (AND|OR|LSHIFT|RSHIFT) (\w+)) -> (\w+)"

const connections = Dict()

const binary_operations = Dict(
    "AND" => (x, y) -> x & y,
    "OR" => (x, y) -> x | y,
    "RSHIFT" => (x, y) -> x >>> y,
    "LSHIFT" => (x, y) -> x << y)

function signal(input)
    if isdigit(input)
        () -> parse(UInt16, input)
    else
        () -> begin
            m = connections[input]()

            # Memoize the result
            connections[input] = () -> m
            m
        end
    end
end

for instruction in readlines(STDIN)
    input, inv_input, input1, op, input2, output = match(format, instruction).captures

    connections[output] =
        if inv_input != nothing
            () -> ~signal(inv_input)()
        elseif input1 != nothing
            () -> binary_operations[op](signal(input1)(), signal(input2)())
        else
            signal(input)
        end
end

println(signal("a")())
