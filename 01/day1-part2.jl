left = right = 0

function basement_p(brace)
    global left, right
    
    if brace == ')'
        right += 1
    else
        left += 1
    end
    left < right
end

println(findfirst(basement_p, readbytes(STDIN)))
