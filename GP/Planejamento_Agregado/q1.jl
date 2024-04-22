using JuMP, GLPK

M = Model(GLPK.Optimizer);

@variable(M, x[1:3] >=0)

@constraints(M, begin
                0.22 * x[1]+ 0.52 * x[2] + 0.74 * x[3] <= 9600000 
                0.5*x[1]+ 0.34 * x[2] + 0.2 * x[3] <= 4800000
                0.28*x[1]+ 0.14 * x[2] + 0.06*x[3] <= 2200000
                x[3] >= 16*x[1]
                x[2] <= 600000
                end
            )

@objective(M, Max, 0.3*x[1] + 0.25*x[2] + 0.2*x[3])

println(M) # Imprimir o modelo na tela

optimize!(M);
z = objective_value(M); x_ = value.(x);
println("Valor alcançado na função objetivo: $z\nx=$x_")

