module rgbl

import FileIO

include("instructions.jl")
include("directions.jl")

mutable struct RGB
    r::UInt8
    g::UInt8
    b::UInt8
end

function run(inputpath, verbose=false)
    img = FileIO.load(inputpath)
    width, height = size(img)

    grid = map(x -> RGB(x.r.i, x.g.i, x.b.i), img)

    let
        head = Point(1, 1)
        v = 0
        m = 0

        while true
            pixel = grid[head.y, head.x]

            v = pixel.g
            if verbose
                print("[v: $(v) | m: $(m)]\t($(head.x), $(head.y)): [$(pixel.r) $(pixel.g) $(pixel.b)]")
            end
            normalizedr = pixel.r == 255 ? 255 : normalize_instruction(pixel.r)
            if normalizedr == 0
                break
            end
            instruction = instructions[normalizedr]
            if verbose
                println(" -> $(instruction.name)")
            end
            # Draw
            grid[head.y, head.x] = RGB(pixel.r, instruction.draws(m, v), pixel.b)

            # Mem
            m = instruction.mems(m, v)
            if instruction.name == "cross"
                nextdir = cross_directions[(m+pixel.b)%8+1]
            else
                nextdir = blue_directions[pixel.b%8+1]
            end
            # println("Going $nextdir")

            head = add(head, direction_step_changes[nextdir])
        end

    end

end

end # module rgbl
