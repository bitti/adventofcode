# Fetch input
bytes = readbytes(STDIN)

function get_first_basement_counter()
    step = 1
    function get_counter()
        step
    end,
    function count_to_first_basement(a, b)
        if a == -1
            -1
        else
            step += 1
            a + b
        end
    end
end

step, counter = get_first_basement_counter()

# Surely not the most efficient way to iterate over everything, but a nice way to try out
# closures and keep the solution similar to part1
reduce(counter, int8(bytes&1 * -2 + 1))

println(step())
