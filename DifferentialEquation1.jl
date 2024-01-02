# winget install julia -s msstore
# run julia from the command line
#import Pkg
#Pkg.add("DifferentialEquations")
#Pkg.add("Symbolics")
#Pkg.add("ModelingToolkit")
#Pkg.add("Plots")
#Pkg.add("LaTeXStrings")
#run julia -i <filemname.jl>

using ModelingToolkit
using DifferentialEquations
using Plots
using LaTeXStrings

@variables t
D = Differential(t)

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

@mtkbuild fol = FOL()
equations(fol)

prob = ODEProblem(fol, [fol.N => 10.0], (0.0, 1), [fol.λ => 1.0])
plot(solve(prob))
plot!(minorgrid=true)
title!(L"Plot of $N = N_0 e^{-\lambda t}$")
xlabel!(L"Time")
ylabel!(L"Amount")
gui()
readline()