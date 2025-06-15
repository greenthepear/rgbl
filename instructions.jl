category_ranges = [0:63, 64:127, 128:191, 192:254]

struct instruction 
    name::String
    draws::Function
    mems::Function
end

instructions = Dict(
    0 => instruction("exit", (m, v) -> m, (m, v) -> m),
    1 => instruction("draw", (m, v) -> m, (m, v) -> m),
    2 => instruction("mem",  (m, v) -> v, (m, v) -> v),
    3 => instruction("swap", (m, v) -> m, (m, v) -> v),

    64 => instruction("stdout", (m, v) -> begin print(Char(m)); m end, (m, v) -> v),
    65 => instruction("stdin",  (m, v) -> v, (m, v) -> Int(read(stdin, Char))),

    128 => instruction("add",  (m, v) -> v, (m, v) -> m + v),
    129 => instruction("sub",  (m, v) -> v, (m, v) -> m - v),
    130 => instruction("mult", (m, v) -> v, (m, v) -> m * v),
    131 => instruction("div",  (m, v) -> v, (m, v) -> m ÷ v),
    132 => instruction("mod",  (m, v) -> v, (m, v) -> m % v),

    192 => instruction("eq", (m, v) -> v, (m, v) -> Int(m == v)),
    193 => instruction("lt", (m, v) -> v, (m, v) -> Int(m < v)),
    194 => instruction("le", (m, v) -> v, (m, v) -> Int(m <= v)),
    195 => instruction("gt", (m, v) -> v, (m, v) -> Int(m > v)),
    196 => instruction("ge", (m, v) -> v, (m, v) -> Int(m >= v)),
)

category_ranges_numbers = Dict(map(
    x -> (x, count(in(x), instructions |> keys)), 
    category_ranges))

function normalize_instruction(i)
    range, range_count = filter(x -> i in x.first, category_ranges_numbers) |> first
    return (i - range.start) % range_count + range.start
end