const containers = sort(map(parse, readlines(STDIN)))
const volume = parse(ARGS[1])
const max = findlast(s -> s <= volume, cumsum(containers))
const min = findfirst(s -> s >= volume, cumsum(reverse(containers)))

function fill()
    for i in min:max, comb in combinations(containers, i)
        if sum(comb) == volume
            produce(1)
        end
    end
end

println(sum(Task(fill)))
