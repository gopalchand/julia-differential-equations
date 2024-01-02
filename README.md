# Getting started in Juliia using Differential Equations

# Installation of Julia
Windows:
```
winget install julia -s msstore
```
Linux: 
```
curl -fsSL https://install.julialang.org | sh
```

# Running and setting up
From the command line:
```
julia
```

# Packages to get started

Install packages using the following in Julia (this will take some time):
```
import Pkg
Pkg.add("DifferentialEquations")
Pkg.add("Symbolics")
Pkg.add("ModelingToolkit")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
```

Ctrl-D to exit Julia

# Run example
From the command line:
```
julia -i DifferentialEquation1.jl
```

This solves a $\frac{dN}{dt}=\lambda N$ by using the ModelingTookit:

```
@mtkmodel FOL begin
    @parameters begin
        λ # parameters
    end
    @variables begin
        N(t) # dependent variables
    end
    @equations begin
        D(N) ~ -λ*N
    end
end
```

Initial conditions are set here:

```
prob = ODEProblem(fol, [fol.N => 10.0], (0.0, 1.0), [fol.λ => 1.0])
```

N starts with value 10.0 units

t is in the range 0.0 to 1.0 seconds

and ${\lambda}$ is set to 1.0 per second

The resulting plot is:

![image](https://github.com/gopalchand/julia-differential-equations/assets/45721890/bb5fd6ca-6e16-43c8-8f82-9dfec79cc330)

The 'L' prefix is ued for LaTeX strings.
