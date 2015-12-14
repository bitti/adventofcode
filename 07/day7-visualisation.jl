const format = r"(\w+|NOT (\w+)|(\w+) (AND|OR|LSHIFT|RSHIFT) (\w+)) -> (\w+)"
const or_gates = Set()
const and_gates = Set()
const special_gates = Set()
const inv_gates = Set()
const wires = Set()
const sources = Set()
const connections = Set()

gate_count = 0
for instruction in readlines(STDIN)
    input, inv_input, input1, op, input2, output = match(format, instruction).captures

    if inv_input != nothing
        gate = "i$gate_count"
        push!(wires, "w$inv_input", "w$output")
        push!(inv_gates, "$gate")
        push!(connections,
              "w$inv_input -> $gate",
              "$gate -> w$output [label=$output arrowsize=0]")
        gate_count += 1
    elseif input1 != nothing
        push!(wires, "w$input1", "w$input2", "w$output")
        if op == "OR"
            gate = "o$gate_count"
            push!(or_gates, gate)
        elseif op == "AND"
            gate = "a$gate_count"
            # Wo only assume numeric inputs for first input of AND gates, but
            # we could make it more generic if wanted
            if isnumber(input1)
                push!(special_gates, "$gate [shape=square label=\"∧$input1\"]")
                input1 = nothing
            else
                push!(and_gates, gate)
            end
        elseif op == "LSHIFT"
            gate = "l$gate_count"
            push!(special_gates, "$gate [shape=square label=\"<<$input2\"]")
            input2 = nothing
        elseif op == "RSHIFT"
            gate = "r$gate_count"
            push!(special_gates, "$gate [shape=square label=\">>$input2\"]")
            input2 = nothing
        end
        gate_count += 1
        if input1 != nothing
            push!(connections, "w$input1 -> $gate")
        end
        if input2 != nothing
            push!(connections, "w$input2 -> $gate")
        end
        push!(connections, "$gate -> w$output [label=$output arrowsize=0]")
    else
        push!(wires, "w$output")
            if isnumber(input)
            push!(sources, "w$input [label=$input]")
        end
            push!(connections, "w$input -> w$output [label=$output arrowsize=0]")
    end
end

println("digraph {")
println(join(sources, "\n"))
println(join(or_gates, ","), " [shape=square label=\"∨\"]")
println(join(and_gates, ","), " [shape=square label=\"∧\"]")
println(join(inv_gates, ","), " [shape=square label=\"~\"]")
println(join(special_gates, "\n"))
println(join(wires, ","), " [shape=none style=invis label=\"\" fixedsize=false width=0 height=0]")
println(join(connections, "\n"))
println("}")
