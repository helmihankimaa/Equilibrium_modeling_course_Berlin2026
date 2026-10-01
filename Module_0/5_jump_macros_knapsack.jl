using JuMP, HiGHS

c, w, b = [1, 2], [0.5, 0.5], 1.25
n = length(c)
model = Model(HiGHS.Optimizer)
# set_silent(model)
@variable(model, x[1:n] >= 0, Int)
@objective(model, Max, sum(c[i] * x[i] for i = 1:n))
@constraint(model, sum(w[i] * x[i] for i = 1:n) <= b)
optimize!(model)
if termination_status(model) != OPTIMAL
    error("Not solved correctly")
end
value.(x)