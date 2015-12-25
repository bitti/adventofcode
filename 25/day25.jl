const first_code = 20151125
const factor = 252533
const m = 33554393

function get_code(column, row)
    mod(powermod(factor, (column + row - 1) * (column + row - 2) >> 1 + row - 1, m) * first_code, m)
end

println(get_code(3010, 3019))
