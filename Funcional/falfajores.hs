import Data.List (isInfixOf)

--import Text.Show.Functions

type Capa = (String, Float)

data Alfajor = Alfajor{
    relleno :: [Capa],
    peso :: Float,
    dulzor :: Float,
    nombre :: String
}deriving (Show)

jorgito :: Alfajor
jorgito = Alfajor {
    relleno = [("Dulce de leche", 10)],
    peso = 80,
    dulzor = 8,
    nombre = "Jorgito"
}

havanna :: Alfajor
havanna = Alfajor {
    relleno = [("Mouse", 5), ("Mouse", 5)],
    peso = 60,
    dulzor = 12,
    nombre = "Havanna"
}

capitan :: Alfajor
capitan = Alfajor {
    relleno = [("Dulce de leche",15)],
    peso = 40,
    dulzor = 12,
    nombre = "Capitan del Espacio"
}

coeficienteDulzor :: Alfajor -> Float
coeficienteDulzor unAlfajor = dulzor unAlfajor / peso unAlfajor

precioAlfajor :: Alfajor -> Float
precioAlfajor unAlfajor = 2 * peso unAlfajor + (sum. map snd . relleno) unAlfajor

esPotable :: Alfajor -> Bool
esPotable unAlfajor = (not.null) (relleno unAlfajor) && todasCapasIguales (relleno unAlfajor) && coeficienteDulzor unAlfajor >=0.1

todasCapasIguales :: [Capa] -> Bool
todasCapasIguales capas = all (==head capas) capas

-- PARTE 2

abaratarUnAlfajor :: Alfajor -> Alfajor
abaratarUnAlfajor unAlfajor = unAlfajor {peso = peso unAlfajor - 10, dulzor = dulzor unAlfajor -7}

renombrar :: String -> Alfajor -> Alfajor
renombrar nuevoNombre unAlfajor = unAlfajor {nombre = nuevoNombre} 

agregarCapa :: Capa -> Alfajor -> Alfajor
agregarCapa nuevaCapa unAlfajor = unAlfajor {relleno = nuevaCapa : relleno unAlfajor}

hacerPremium :: Alfajor -> Alfajor
hacerPremium unAlfajor 
    | esPotable unAlfajor = unAlfajor { nombre = nombre unAlfajor ++ " premium", relleno = relleno (agregarCapa (head (relleno unAlfajor)) unAlfajor) }
    | otherwise = unAlfajor

hacerPremiumVariasVeces :: Int -> Alfajor -> Alfajor
hacerPremiumVariasVeces veces unAlfajor = foldl (\alfajor premium -> premium alfajor) unAlfajor (replicate veces hacerPremium)

jorgitito :: Alfajor
jorgitito = (abaratarUnAlfajor jorgito){nombre= "Jorgitito"}

jorgelin :: Alfajor
jorgelin = (agregarCapa ("Dulce de leche", 10) jorgito){nombre = "Jorgelin"}

capitanCostaACosta :: Alfajor
capitanCostaACosta = (renombrar "Capitán del espacio de costa a costa". hacerPremiumVariasVeces 4 . abaratarUnAlfajor) capitan

-- PARTE 3

data Cliente = Cliente{
    nombreCliente :: String,
    plata :: Float,
    gustos :: Alfajor -> Bool,
    alfajores :: [Alfajor]
}

emi :: Cliente
emi = Cliente "Emi" 120 (isInfixOf "Capitan del Espacio" . nombre) []

tomi :: Cliente
tomi = Cliente "Tomi" 100 gustosTomi []

gustosTomi :: Alfajor -> Bool
gustosTomi unAlfajor = esPretencioso unAlfajor && esDulcero unAlfajor

esPretencioso :: Alfajor -> Bool
esPretencioso = isInfixOf "Premium" . nombre

esDulcero :: Alfajor -> Bool 
esDulcero unAlfajor = coeficienteDulzor unAlfajor > 0.15

dante :: Cliente
dante = Cliente "Dante" 200 gustosDante []

gustosDante :: Alfajor -> Bool
gustosDante unAlfajor = not (tieneUnRelleno "Dulce de Leche" unAlfajor) && not (esPotable unAlfajor)

juan :: Cliente
juan = Cliente "Juan" 500 gustosJuan []

gustosJuan :: Alfajor -> Bool
gustosJuan unAlfajor = (isInfixOf "Jorgito" . nombre) unAlfajor && esPretencioso unAlfajor && not (tieneUnRelleno "Mousse" unAlfajor) && esPretencioso unAlfajor

tieneUnRelleno :: String -> Alfajor -> Bool
tieneUnRelleno unRelleno unAlfajor = elem unRelleno (map fst (relleno unAlfajor))

clientes :: [Cliente]
clientes = [emi,tomi,dante,juan]

leGustanA :: Cliente -> [Alfajor] -> [Alfajor]
leGustanA unCliente = filter (gustos unCliente)


comprarUnAlfajor :: Cliente -> Alfajor -> Cliente
comprarUnAlfajor unCliente unAlfajor  
    | plata unCliente >= precioAlfajor unAlfajor = unCliente {plata = plata unCliente - precioAlfajor unAlfajor, alfajores = unAlfajor: alfajores unCliente}
    | otherwise = unCliente

compreTodos :: Cliente -> [Alfajor] -> Cliente
compreTodos unCliente losAlfajores = foldl comprarUnAlfajor unCliente (leGustanA unCliente losAlfajores)