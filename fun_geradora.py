def conta_convencional (nome):
    conta = 0
    while True:
        conta +=1
        return conta
       
Cliente_1 = conta_convencional('Cliente_1')

print(Cliente_1)
print(Cliente_1)
print(Cliente_1)
print(Cliente_1)

print("---------------------")

def conta_geradora (nome):
    conta = 0
    while True:
        conta +=1
        yield conta
        
Cliente_1 = conta_geradora('Cliente_1')

print(next(Cliente_1))
print(next(Cliente_1))
print(next(Cliente_1))
print(next(Cliente_1))
