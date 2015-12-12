vowels = "aeiou"

rule1 = Regex("[$vowels].*"^3)
rule2 = r"(.)\1"
rule3 = r"ab|cd|pq|xy"

println(count(str -> match(rule1, str) != nothing &&
                     match(rule2, str) != nothing &&
                     match(rule3, str) == nothing, readlines(STDIN)))
