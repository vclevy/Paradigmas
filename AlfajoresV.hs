import Text.Show.Functions
import Data.List
 
data Alfajor = UnAlfajor {
   relleno :: [String],
   peso :: Int, 
   dulzor :: Int,
   nombre :: String
} deriving (Show, Eq)

jorgito::Alfajor
jorgito = UnAlfajor ["Dulce de leche"] 80 8 "Jorgito"

havanna::Alfajor
havanna = UnAlfajor ["Mousse", "Mousse"] 60 12 "Havanna"

capitanDelEspacio::Alfajor
capitanDelEspacio = UnAlfajor ["Dulce de leche"] 4 12 "Capitan del espacio"

coeficienteDeDulzor :: Alfajor -> Float
coeficienteDeDulzor unAlfajor = fromIntegral (dulzor unAlfajor) / fromIntegral (peso unAlfajor)

precioDeAlfajor :: Alfajor -> Int
precioDeAlfajor unAlfajor = (peso unAlfajor * 2) + sum (map (preciosDeRellenos unAlfajor) (relleno unAlfajor))

preciosDeRellenos :: Alfajor -> String -> Int
preciosDeRellenos _ "Dulce de leche" = 12
preciosDeRellenos _ "Mousse" = 15
preciosDeRellenos _ "Fruta" = 12

esPotable :: Alfajor -> Bool
esPotable unAlfajor = not (null (relleno unAlfajor)) && coeficienteDeDulzor unAlfajor>=0.1 && sonDelMismoSabor unAlfajor

sonDelMismoSabor :: Alfajor -> Bool
sonDelMismoSabor unAlfajor = all (== head (relleno unAlfajor)) (tail (relleno unAlfajor))

abaratarAlfajor :: Alfajor -> Alfajor
abaratarAlfajor unAlfajor = modificarPeso (subtract 10).modificarDulzor(subtract 7) $ unAlfajor

modificarPeso :: (Int->Int)-> Alfajor -> Alfajor
modificarPeso funcion unAlfajor = unAlfajor {peso = funcion (peso unAlfajor)}
modificarDulzor :: (Int->Int)-> Alfajor -> Alfajor

modificarDulzor funcion unAlfajor = unAlfajor {dulzor = funcion (dulzor unAlfajor)}
modificarNombre :: String -> Alfajor -> Alfajor

modificarNombre nuevoNombre unAlfajor = unAlfajor {nombre = nuevoNombre}

renombrarAlfajor :: Alfajor -> String -> Alfajor
renombrarAlfajor unAlfajor nuevoNombre = modificarNombre nuevoNombre unAlfajor

agregarCapa :: [String] -> Alfajor -> Alfajor
agregarCapa unRelleno unAlfajor = unAlfajor { relleno = relleno unAlfajor ++ unRelleno } -- ++ para agregar un elem a una lista (concatenar)

hacerPremium :: Alfajor -> Alfajor
hacerPremium unAlfajor
    | esPotable unAlfajor = agregarCapa [last (relleno unAlfajor)] (renombrarAlfajor unAlfajor (nombre unAlfajor ++ " Premium"))
    | otherwise = unAlfajor

hacerPremiumGrado :: Int -> Alfajor -> Alfajor
hacerPremiumGrado 0 unAlfajor = unAlfajor
hacerPremiumGrado grado unAlfajor
    | esPotable unAlfajor = hacerPremiumGrado (grado - 1) (hacerPremium unAlfajor)
    | otherwise = unAlfajor

{- hacerPremiumGrado :: Alfajor -> Int -> Alfajor
hacerPremiumGrado unAlfajor grado
    | grado <= 0 = unAlfajor
    | esPotable unAlfajor = foldl (\alfajor _ -> hacerPremium alfajor) unAlfajor [1..grado]
    | otherwise = unAlfajor -} -- otra forma con fold y lamdba

jorgitito::Alfajor
jorgitito = abaratarAlfajor.modificarNombre "Jorgitito" $ jorgito

jorgelin::Alfajor
jorgelin = agregarCapa ["Dulce de leche"].modificarNombre "Jorgelin" $ jorgito

capitanDelEspacioCostaACosta :: Alfajor
capitanDelEspacioCostaACosta = modificarNombre "Capitan del espacio costa a costa" (hacerPremiumGrado 4.abaratarAlfajor $ capitanDelEspacio) 

data Cliente = UnCliente {
    nombreCliente::String,
    dinero::Int,
    criterio::Criterio,
    alfajoresComprados::[Alfajor]
} deriving Show

type Criterio = Alfajor->Bool

nombreCapitanDelEspacio:: Criterio
nombreCapitanDelEspacio unAlfajor = isInfixOf "Capitan del espacio" (nombre unAlfajor)

emi::Cliente
emi = UnCliente "Emi" 120 nombreCapitanDelEspacio []

criterioTomi::Criterio
criterioTomi unAlfajor = pretencioso unAlfajor && dulcero unAlfajor

pretencioso :: Criterio
pretencioso unAlfajor =  isInfixOf "Premium" (nombre unAlfajor)

dulcero :: Criterio
dulcero unAlfajor =  coeficienteDeDulzor unAlfajor > 0.15

tomi::Cliente
tomi = UnCliente "tomi" 100 criterioTomi []

dante::Cliente
dante = UnCliente "dante" 200 criterioDante []

criterioDante::Criterio
criterioDante unAlfajor = anti "Dulce de leche" unAlfajor && extranio unAlfajor

extranio::Criterio
extranio unAlfajor = not.esPotable $ unAlfajor

anti:: String -> Criterio
anti unRelleno unAlfajor = not.elem unRelleno $ (relleno unAlfajor)

juan::Cliente
juan = UnCliente "juan" 500 criterioJuan []

criterioJuan::Criterio
criterioJuan unAlfajor = criterioTomi unAlfajor && isInfixOf "jorgito" (nombre unAlfajor) && anti "Mousse" unAlfajor

alfajores::[Alfajor]
alfajores = [jorgito, havanna, capitanDelEspacio, jorgelin, hacerPremium havanna]

cualesLeGustan :: Cliente -> [Alfajor] -> [Alfajor]
cualesLeGustan unCliente alfajores = filter (criterio unCliente) alfajores

comprarAlfajor :: Cliente -> Alfajor -> Cliente
comprarAlfajor unCliente unAlfajor 
    | dinero unCliente >= precioDeAlfajor unAlfajor = unCliente { alfajoresComprados = unAlfajor : alfajoresComprados unCliente }
    | otherwise = unCliente

comprarLosQueLeGustan :: Cliente -> [Alfajor] -> Cliente
comprarLosQueLeGustan unCliente alfajores = foldl comprarAlfajor unCliente alfajores
