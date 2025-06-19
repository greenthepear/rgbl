Official interpreter for the [**rgbl**](https://esolangs.org/wiki/Rgbl) esoteric programming language, made in Julia.

# Usage

```bash
$ git clone https://github.com/greenthepear/rgbl.git
$ cd rgbl
$ julia
```

```julia
# Press ]
pkg> activate .

julia> import rgbl

julia> rgbl.run("examples/hello_world.ppm")
```

or
```bash
$ julia --project=. -e 'import rgbl; rgbl.run("examples/hello_world.ppm")'
```