# In order to understand this you have to know the bit representation of the ASCII codes
# of '(' and ')'. But in case you forgot these you can ask julia:
#
# julia> bits(Int8('('))
# "00101000"
#
# julia> bits(Int8(')'))
# "00101001"
println(sum(brace_flag -> 1 - brace_flag, readbytes(STDIN)&1 * 2))
