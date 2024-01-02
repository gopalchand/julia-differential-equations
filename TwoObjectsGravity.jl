# example https://lewinb.net/posts/09_more_coupled_oscillators/

using DifferentialEquations
using Plots
using LaTeXStrings
using Measures # https://goropikari.github.io/PlotsGallery.jl/src/two_y_axis.html
using DataFrames

# Constants
const G = 6.6743E-11                            # Universal Gravitational constant in Nm^2/kg^2
const initial_x = 1.0                           # initial distance between objects in m
const seconds_per_hour = 60*60                  # number of hours per day in s
const seconds_per_day = 60*60*24                # number of seconds per day in s
const seconds_per_year = 365.25*seconds_per_day # number of seconds per year in s
const μm = 1e-6                                 # number of metres in a μm

# u = [x, dx/dt]
function gravity!(du, u, p, t)
    du[1] = u[2]
    du[2] = -2*G*p[:m]*p[:m]/u[1]^2
end

# Initial conditions
u0 = [initial_x, 0.0]                 # Initial values for x-displacement and x-velocity respectively (in m and m/s)
tspan = (0.0, seconds_per_day*1.1125)     # time span in seconds

# Parameters
p = Dict(:m => 1.0, :r => 0.1)  # mass of objects in kg, radius of objects in m
# Workaround because of bug https://github.com/SciML/DifferentialEquations.jl/issues/922
p = NamedTuple([pair for pair in p])

prob = ODEProblem(gravity!, u0, tspan, p)
solution = solve(prob, RKO65(), dense=true, reltol=1e-12, abstol=1e-12, dt=0.1)
df = DataFrame(solution)

# labels are a row matrix not a vector so there is no "," in the label

#plot(solution, c=:blue, vars = [(0, 1)], xlabel="time/s", ylabel="Distance between objects/m", label = L"$x(t)$", leg=:bottomright)
plot(df[:,1]./seconds_per_hour, df[:,2], c=:blue, xlabel="time/hours", ylabel="Distance between objects/m", label = L"Distance $x(t)$", leg=:bottomright)
plot!(minorgrid=true)
ylabel!("Distance between objects/m")
title!("Distance and Speed changes over time")

#plot!(twinx(),solution, c=:red, vars = [(0,2)], xlabel="", ylabel="Speed/m/s", label = L"$\dot{x}(t)$", leg=:topright)
plot!(twinx(),df[:,1]./seconds_per_hour, df[:,3]./μm, c=:red, xlabel="", ylabel="Speed/μm/s", label = L"Speed $\dot{x}(t)$", leg=:topright)
gui()
readline()