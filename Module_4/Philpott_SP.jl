using JuMP
using Ipopt
using DataFrames

A = ["h", "t", "c"]

N = ["n$(i)" for i = 0:10]
root = ["n0"]
leaf = ["n$(i)" for i = 1:10]

K = ["k$(i)" for i = 1:10]

λ = 0.2

ω = Dict(
    "n0" => 4.0,
    "n1" => 1.0,
    "n2" => 2.0,
    "n3" => 3.0,
    "n4" => 4.0,
    "n5" => 5.0,
    "n6" => 6.0,
    "n7" => 7.0,
    "n8" => 8.0,
    "n9" => 9.0,
    "n10" => 10.0,
)

q = Dict{Tuple{String,String},Float64}()

for k in K
    q["n0", k] = 1.0
end

for (i, n) in enumerate(leaf)
    for (j, k) in enumerate(K)
        q[n, k] = (1 - λ) / 10 + λ * (i == j ? 1.0 : 0.0)
    end
end

# ============================================================
# MODEL
# ============================================================

model = Model(Ipopt.Optimizer)

@variable(model, theta)

@variable(model, u[a in A, n in N])
@variable(model, x[n in N])

for n in N
    set_lower_bound(u["h", n], 0.0)
    set_upper_bound(u["h", n], 10.0)

    set_lower_bound(u["t", n], 0.0)
    set_upper_bound(u["t", n], 12.0)

    set_upper_bound(u["c", n], 0.0)
end

@objective(model, Min, u["t", "n0"]^2 + 2 * u["c", "n0"]^2 + 40 * u["c", "n0"] + theta)

@constraint(model, initial_water_balance, x["n0"] == 10 - u["h", "n0"] + ω["n0"])

@constraint(model, leaf_water_balance[n in leaf], x[n] == x["n0"] - u["h", n] + ω[n])

@constraint(
    model,
    theta_con[k in K],
    theta >= sum(
        q[n, k] *
        (u["t", n]^2 + 2 * u["c", n]^2 + 40 * u["c", n] - 10 * log(0.1 * x[n] + 0.01)) for
        n in leaf
    )
)


@constraint(
    model,
    balance_con[n in N],
    1.5 * u["h", n] - 0.015 * u["h", n]^2 + u["t", n] + u["c", n] >= 0
)

optimize!(model)

termination_status(model)
@assert isapprox(objective_value(model), -3.9205249563e+02)
value(theta)

value.(x)
value.(u)

price = Dict(n => 40 + 4 * value(u["c", n]) for n in N)

profit_T = Dict(
    n =>
        price["n0"] * value(u["t", "n0"]) - value(u["t", "n0"])^2 +
        price[n] * value(u["t", n]) - value(u["t", n])^2

    for n in leaf
)

profit_H = Dict(
    n =>
        price["n0"] * (1.5 * value(u["h", "n0"]) - 0.015 * value(u["h", "n0"])^2) +
        price[n] * (1.5 * value(u["h", n]) - 0.015 * value(u["h", n])^2) +
        10 * log(0.1 * value(x[n]) + 0.01)

    for n in leaf
)


welfare_C = Dict(
    n =>
        price["n0"] * value(u["c", "n0"]) -
        (2 * value(u["c", "n0"])^2 + 40 * value(u["c", "n0"])) +
        price[n] * value(u["c", n]) - (2 * value(u["c", n])^2 + 40 * value(u["c", n]))

    for n in leaf
)

welfare_total = Dict(n => profit_T[n] + profit_H[n] + welfare_C[n]

                     for n in leaf)


results = DataFrame(
    Node = 0:10,
    Inflow = [ω[n] for n in N],
    Price = [price[n] for n in N],
    Storage_H = [value(x[n]) for n in N],
    Release_H = [value(u["h", n]) for n in N],
    Prod_T = [value(u["t", n]) for n in N],
)

results[!, "Profit(T)"] = [
    missing;
    [profit_T[n] for n in leaf]
]

results[!, "Profit(H)"] = [
    missing;
    [profit_H[n] for n in leaf]
]

results[!, "Welfare(C)"] = [
    missing;
    [welfare_C[n] for n in leaf]
]

results[!, "Welfare(total)"] = [
    missing;
    [welfare_total[n] for n in leaf]
]

@show results;
