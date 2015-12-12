# Fetch input

const bytes = readbytes(STDIN)

# In order to understand this you have to know the bit representation of the ASCII codes
# of '(' and ')'. But in case you forgot these you can ask julia:
#
# julia> bits(int8('('))
# "00101000"
#
# julia> bits(int8(')'))
# "00101001"

println(sum(int8(bytes&1 * -2 + 1)))
