const chars_to_escape = r"\"|\\"

println(sum(line -> length(matchall(chars_to_escape, line)) + 2, readlines(STDIN)))
