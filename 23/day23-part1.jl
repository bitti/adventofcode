const format = r"(\w+) (\w|[+-]\d+)(?:, ([+-]\d+))?"

immutable Instruction
    op::Symbol
    r::Symbol
    off::Int
end

Instruction(op::Symbol, off::Int, _::Void) = Instruction(op, :nothing, off)
Instruction(op::Symbol, _::Void, off::Int) = Instruction(op, :nothing, off)
Instruction(op::Symbol, r::Symbol, _::Void) = Instruction(op, r, 0)

type Computer
    r::Dict
    pc::Int
    
    Computer() = new(Dict(:a => 0, :b => 0), 1)
end

function run!(c::Computer, instr::Array{Instruction})
    while c.pc >= 1 && c.pc <= length(instr)
        i = instr[c.pc]
        off = 1
        if i.op == :hlf
            c.r[i.r] >>= 1
        elseif i.op == :tpl
            c.r[i.r] *= 3
        elseif i.op == :inc
            c.r[i.r] += 1
        elseif i.op == :jmp
            off = i.off
        elseif i.op == :jie
            if c.r[i.r] & 1 == 0
                off = i.off
            end
        elseif i.op == :jio
            if c.r[i.r] == 1
                off = i.off
            end
        end
        c.pc += off
    end
end

function Base.parse(str::Void)
    nothing
end

const c = Computer()
run!(c, map(readlines(STDIN)) do line
    Instruction(map(parse, match(format, line).captures)...)
end)

println(c.r[:b])
