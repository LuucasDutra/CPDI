-- Variável Global. (Mais lenta que a variável local)(Deve ser evitado, usar variáveis locais) --
-- variavel global engloba todo o processamento do jogo, pode ser lida em qualquer script dentro do jogo, e depois que o jogo é finalizado ela precisa ser deletada
-- variavel local precisa declarar antes de colocar ela, e so vale dentro do script, automaticamente excluida quando finalizado o processo
-- print imprime a informação dentro do console
vidas = 2
vidas = 8
print (vidas)
print ("O valor de vidas: " .. vidas)
------------------
-- Variáveis locais (Só é lida dentro do script) --
-- (local) é utilizado somente na criação da variável.
-- .. -> Concatenação

local pontos = 10
print (pontos)
print ("O valor de pontos é: " .. pontos)

---------------- Operações ----------------
--  + -> Soma

local laranjas = 10

laranjas = laranjas + 5

print(laranjas)

local bananas = 5

-- Soma de variáveis
cesta = laranjas + bananas
print ("A soma entre as variáveis laranjas e banans é: " .. cesta)

-- Subtração de variáveis
cesta = laranjas - bananas

-- Multiplicação de variáveis

local carro = 8
carro = carro * 2
print ("Quantidade de carros: " .. carro)

-- A multiplicação é mais rapida que a divisao, entao quando for possivel, utilizar a multiplicação pra dividir

carro = carro * 0.5 
print (carro)

-- Divisão
local gato = 6
gato = gato / 2
print ("A divisão finalé :" .. gato)

-- nil -> nulo, ausencia de valor util
-- boolean -> true e false
-- number -> números reais
-- string -> representa matrizes de caracteres

-- operadores relacionais
-- == igual a
-- ~= diferente de 
-- < menor que
-- > maior que
-- <= menor ou igual a
-- >= maior ou igual a

-- operadores lógicos
-- and -> esse operador de conjunção retorna o primeiro argumento se esse valor fopr false ou nil; caso contrario, retorna o segundo argumento
-- or -> esse operador de conjunção retorna seu primeiro argumento se esse valor for diferente de nil ou false; caso contrario retorna o segundo.
-- not -> operador de negação, sempre retorna false ou true