using JuMP, GLPK, DataFrames

# Inserção dos Dados
dados = DataFrame(tipo_prod= ["verde","azul","comum"], pura=[0.22, 0.52, 0.74], octana = [0.5, 0.34, 0.2], aditivo = [0.28, 0.14, 0.06]);
dados = stack(dados, [:pura, :octana, :aditivo]);
rename!(dados, [:variable, :value] .=> [:mp, :comp]);
comp_dict = Dict();
for i =1:nrow(dados)
    push!(comp_dict, (dados.tipo_prod[i], dados.mp[i]) => dados.comp[i])
end
tipo_prod= ["verde","azul","comum"];                  
mp = ["pura", "octana", "aditivo"];
capacidades = Dict("pura" => 9600000, "octana" => 4800000, "aditivo" => 2200000);
lucros = Dict("verde" => 0.3, "azul" => 0.25, "comum" => 0.2);
capacidade_azul = 600000;

# Criando o modelo
M = Model(GLPK.Optimizer)
@variable(M, x[tipo_prod] >=0)
@constraint(M, R_capacidades[j in mp], sum(x[i] * comp_dict[i, j] for i in tipo_prod) <= capacidades[j])
@constraints(M, begin
                x["comum"] >= 16 * x["verde"]
                x["azul"] <= capacidade_azul
end)

@objective(M, Max, sum(x[i] * lucros[i] for i in tipo_prod))

println(M) # Imprimir o modelo na tela

optimize!(M);
z = objective_value(M); 
x_ = value.(x);

println("Valor alcançado na função objetivo: $z\nx=$x_")
