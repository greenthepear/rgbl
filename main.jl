import FileIO

include("instructions.jl")
include("directions.jl")

mutable struct RGB
    r::UInt8
    g::UInt8
    b::UInt8
end

inputpath = last(ARGS)

img = FileIO.load(inputpath)
width, height = size(img)

grid = map(x -> RGB(x.r.i, x.g.i, x.b.i), img)

println(img)
println(grid)

let
    head = Point(1, 1)
    v = 0
    m = 0
    
while true
    pixel = grid[head.y, head.x]
    println("($(head.x), $(head.y)): [$(pixel.r) $(pixel.g) $(pixel.b)]")

    if pixel.r == 0 
        break
    end
    nextdir = blue_directions[pixel.b % 8 + 1]
    println("Going $nextdir")

    head = add(head, direction_step_changes[nextdir])
end

end

