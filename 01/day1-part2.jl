left = right = 0

function first_basement_p(brace)
    global left, right
    
    if brace == ')'
        right += 1
    else
        left += 1
    end
    left < right
end

println(findfirst(first_basement_p, readbytes(STDIN)))
