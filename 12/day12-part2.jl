using JSON

obj = JSON.parse(readall(STDIN))

function summarize(obj)
    if isa(obj, AbstractString)
        0
    elseif isa(obj, Number)
        obj
    elseif isa(obj, Array)
        sum(summarize, obj)
    else # Assume Only hashes left
        if "red" in values(obj)
            0
        else
            # Assume hash keys are always non-numeric strings
            sum(summarize, values(obj))
        end
    end
end

println(summarize(obj))

