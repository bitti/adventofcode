# Fetch input
const bytes = readbytes(STDIN)

step = 1

function count_to_first_basement(a, b)
    global step
    
    # Somehow this solution makes me sad, but it's arguably more efficient and readable
    # then the 'functional' solution with closures
    if a == -1
        println(step)
        exit()
    end
    step += 1
    a + b
end

reduce(count_to_first_basement, int8(bytes&1 * -2 + 1))
