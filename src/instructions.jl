category_ranges = [0:63, 64:127, 128:191, 192:254]

struct Instruction 
    name::String
    draws::Function
    mems::Function
end

instructions = Dict(
    0 => Instruction("exit", (m, v) -> m, (m, v) -> m),
    1 => Instruction("draw", (m, v) -> m, (m, v) -> m),
    2 => Instruction("mem",  (m, v) -> v, (m, v) -> v),
    3 => Instruction("swap", (m, v) -> m, (m, v) -> v),

    64 => Instruction("stdout", (m, v) -> begin print(Char(m)); m end, (m, v) -> v),
    65 => Instruction("stdin",  (m, v) -> v, (m, v) -> Int(read(stdin, Char))),

    128 => Instruction("add",  (m, v) -> v, (m, v) -> m + v),
    129 => Instruction("sub",  (m, v) -> v, (m, v) -> m - v),
    130 => Instruction("mult", (m, v) -> v, (m, v) -> m * v),
    131 => Instruction("div",  (m, v) -> v, (m, v) -> m ÷ v),
    132 => Instruction("mod",  (m, v) -> v, (m, v) -> m % v),

    192 => Instruction("eq", (m, v) -> v, (m, v) -> Int(m == v)),
    193 => Instruction("lt", (m, v) -> v, (m, v) -> Int(m < v)),
    194 => Instruction("le", (m, v) -> v, (m, v) -> Int(m <= v)),
    195 => Instruction("gt", (m, v) -> v, (m, v) -> Int(m > v)),
    196 => Instruction("ge", (m, v) -> v, (m, v) -> Int(m >= v)),
)

category_ranges_numbers = Dict(map(
    x -> (x, count(in(x), instructions |> keys)), 
    category_ranges))

function normalize_instruction(i)
    range, range_count = filter(x -> i in x.first, category_ranges_numbers) |> first
    return (i - range.start) % range_count + range.start
end