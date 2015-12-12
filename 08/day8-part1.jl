const memory_byte = r"\\\\|\\\"|\\x..|[^\"]"

println(sum(line -> length(line) - length(matchall(memory_byte, line)), readlines(STDIN)))
