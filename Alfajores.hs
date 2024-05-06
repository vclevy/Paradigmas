import Text.Show.Functions
 
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

-- agregarCapa [last (relleno unAlfajor)] unAlfajor