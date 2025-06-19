module rgbl

import FileIO

include("instructions.jl")
include("directions.jl")

mutable struct RGB
    r::UInt8
    g::UInt8
    b::UInt8
end

function run(inputpath)
    img = FileIO.load(inputpath)
    width, height = size(img)

    grid = map(x -> RGB(x.r.i, x.g.i, x.b.i), img)

    let
        head = Point(1, 1)
        v = 0
        m = 0
        
    while true
        pixel = grid[head.y, head.x]
        # println("($(head.x), $(head.y)): [$(pixel.r) $(pixel.g) $(pixel.b)]")

        v = pixel.g

        normalizedr = normalize_instruction(pixel.r)
        if normalizedr == 0
            break
        end
        instruction = instructions[normalizedr]

        # Draw
        grid[head.y, head.x] = RGB(pixel.r, instruction.draws(m, v), pixel.b)

        # Mem
        m = instruction.mems(m, v)

        nextdir = blue_directions[pixel.b % 8 + 1]
        # println("Going $nextdir")

        head = add(head, direction_step_changes[nextdir])
    end

    end

end

end # module rgbl
