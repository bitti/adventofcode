const vowels = "aeiou"

const rule1 = Regex("[$vowels].*"^3)
const rule2 = r"(.)\1"
const rule3 = r"ab|cd|pq|xy"

println(count(str -> match(rule1, str) != nothing &&
                     match(rule2, str) != nothing &&
                     match(rule3, str) == nothing, readlines(STDIN)))
