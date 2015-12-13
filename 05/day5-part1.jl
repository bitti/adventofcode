const vowels = "aeiou"

const rule1 = Regex("[$vowels].*"^3)
const rule2 = r"(.)\1"
const rule3 = r"ab|cd|pq|xy"

println(count(str -> ismatch(rule1, str) &&
                     ismatch(rule2, str) &&
                     !ismatch(rule3, str), readlines(STDIN)))
