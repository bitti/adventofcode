const rule1 = r"(..).*\1"
const rule2 = r"(.).\1"

println(count(str -> match(rule1, str) != nothing &&
                     match(rule2, str) != nothing, readlines(STDIN)))
