struct Point
    x::Int
    y::Int
end

add(p1::Point, p2::Point) = Point(p1.x + p2.x, p1.y + p2.y)

@enum cardinal begin
    north
    south
    west
    east
    northwest
    northeast
    southwest
    southeast
end

direction_step_changes = Dict(
    north => Point(0, -1),
    south => Point(0, 1),
    west => Point(-1, 0),
    east => Point(1, 0),
    northwest => Point(-1, -1),
    northeast => Point(1, -1),
    southwest => Point(-1, 1),
    southeast => Point(1, 1)
)

blue_directions = [
    north, northeast,
    east, southeast,
    south, southwest,
    west, northwest]

cross_directions = [
    south, north, east, west,
    northeast, southwest, northwest, southeast]