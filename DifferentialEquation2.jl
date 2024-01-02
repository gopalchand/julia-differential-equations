# example https://lewinb.net/posts/09_more_coupled_oscillators/

using DifferentialEquations
using Plots
using LaTeXStrings

# u = [x, dx/dt]
function harmosc!(du, u, p, t)ac
    du[1] = u[2]
    du[2] = -p[:ω]^2 * u[1] - p[:λ] * u[2]
end

# Initial conditions
u0 = [1.0, 0.0]         # Initial values for x-displacement and x-velocity respectively (in m and m/s)
tspan = (0.0, 25.0)     # in seconds

# Parameters
p = Dict(:ω => 1.0, :λ => 0.2)
# Workaround because of bug https://github.com/SciML/DifferentialEquations.jl/issues/922
p = NamedTuple([pair for pair in p])

prob = ODEProblem(harmosc!, u0, tspan, p)
solution = solve(prob)

# labels are a row matrix not a vector so there is no "," in the label
plot(solution, indxs = (0, 1, 1), label = [L"$x(t)$" L"$\dot{x}(t)$"] )
plot!(minorgrid=true)
title!(L"Solution of $\ddot{x} = -\omega^2 x - \lambda \dot{x}$ with $\dot{x}(0) = 0.0, x(0) = 1.0$")
xlabel!(L"$t$/s")
ylabel!(L"$x$/m")
gui()
readline()