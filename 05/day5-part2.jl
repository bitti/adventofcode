const rule1 = r"(..).*\1"
const rule2 = r"(.).\1"

println(count(str -> ismatch(rule1, str) &&
                     ismatch(rule2, str), readlines(STDIN)))
