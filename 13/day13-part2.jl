const format = r"(\w+) would (\w+) (\w+) .* (\w+)"
const happiness = Dict{Pair,Int}()
const attendees = Set{AbstractString}()

for line in readlines(STDIN)
    name1, dir, diff, name2 = match(format, line).captures
    happiness[name1 => name2] = (dir == "gain" ? 1 : -1) * parse(Int, diff)
    push!(attendees, name1)
end

for attendee in attendees
    happiness[attendee => "me"] = happiness["me" => attendee] = 0
end
push!(attendees, "me")

const total = length(attendees)

println(maximum(permutations(collect(attendees))) do arrangement
    sum(1:total) do i
        happiness[arrangement[i] => arrangement[mod1(i + 1, total)]] +
        happiness[arrangement[i] => arrangement[mod1(i - 1, total)]]
    end
end)
