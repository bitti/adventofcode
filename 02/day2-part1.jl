inf3 = diagm(fill(Inf, 3))

function wrapping_paper_area(str)
    dim = int(split(str, 'x'))

    # Get all pairwise products
    products = dim * transpose(dim)

    # We substract the trace because we don't want to include the products of dimensions
    # with themself
    sum(products) - trace(products) + int(minimum(products + inf3))
end

println(sum(map(wrapping_paper_area, readlines(STDIN))))
