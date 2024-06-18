import Text.Show.Functions

data Guerrero = Guerrero{
    nombre:: String,
    nivelKi :: Float,
    raza :: String,
    cansancio :: Float,
    personalidad :: String
}deriving(Show)

gohan :: Guerrero
gohan = Guerrero "Gohan" 10000 "saiyajin" 0 "sacado"

esPoderoso :: Guerrero -> Bool
esPoderoso unGuerrero = nivelKi unGuerrero > 8000 || raza unGuerrero == "saiyajin"

type Ejercicio = Guerrero->Guerrero
pressDeBanca :: Ejercicio
pressDeBanca = modificarKiCondicional 90.modificarCansancioCondicional 100

modificarKi :: (Float->Float) -> Guerrero -> Guerrero
modificarKi modificador unGuerrero = unGuerrero {nivelKi = (modificador.nivelKi) unGuerrero }

modificarCansancio :: (Float ->Float) -> Guerrero -> Guerrero
modificarCansancio modificador unGuerrero = unGuerrero {cansancio = (modificador.cansancio) unGuerrero}

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = modificarCansancioCondicional 50

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon alturaCajon = modificarCansancioCondicional (alturaCajon / 5). modificarKiCondicional (alturaCajon / 10) 

snatch :: Ejercicio
snatch unGuerrero
    | esExperimentado unGuerrero = modificarCansancioCondicional (cansancio unGuerrero * 0.1) . modificarKiCondicional (nivelKi unGuerrero * 0.05) $ unGuerrero
    | otherwise = modificarCansancioCondicional 100 unGuerrero

esExperimentado :: Guerrero -> Bool
esExperimentado = (>22000).nivelKi

estaFresco ::  Guerrero -> Bool
estaFresco unGuerrero = (not.estaCansado) unGuerrero && (not.estaExhausto) unGuerrero

estaCansado :: Guerrero -> Bool
estaCansado  = cansancioMayorAl 44  

estaExhausto :: Guerrero -> Bool
estaExhausto = cansancioMayorAl 72 

cansancioMayorAl :: Float -> Guerrero -> Bool
cansancioMayorAl porcentaje unGuerrero = cansancio unGuerrero > (porcentaje/100) * nivelKi unGuerrero

modificarKiCondicional :: Float -> Guerrero -> Guerrero
modificarKiCondicional cantidad unGuerrero
    | estaCansado unGuerrero  = modificarKi (+cantidad * 2) unGuerrero
    | estaExhausto unGuerrero = modificarKi (subtract(0.02 * nivelKi unGuerrero)) unGuerrero    
    | otherwise = modificarKi (+cantidad) unGuerrero

modificarCansancioCondicional :: Float -> Guerrero -> Guerrero
modificarCansancioCondicional cantidad unGuerrero
    | estaCansado unGuerrero  = modificarCansancio (+cantidad * 4) unGuerrero
    | estaExhausto unGuerrero = modificarCansancio (+0) unGuerrero
    | otherwise = modificarCansancio (+cantidad) unGuerrero                  

realizarEjercicio :: Guerrero -> Ejercicio -> Guerrero
realizarEjercicio unGuerrero unEjercicio = unEjercicio unGuerrero

intercalar :: [a] -> [a] -> [a]
intercalar [] ys = ys
intercalar xs [] = xs
intercalar (x:xs) (y:ys) = x : y : intercalar xs ys

sumaAnteriores :: Float -> Float
sumaAnteriores 0 = 0
sumaAnteriores x = x + sumaAnteriores (x-1)

descansar :: Float -> Ejercicio
descansar mins = modificarCansancio (subtract (sumaAnteriores mins))

armarRutina :: [Ejercicio]-> Guerrero -> [Ejercicio]
armarRutina ejercicios unGuerrero
    |personalidad unGuerrero == "perezoso" = ejercicios
    |personalidad unGuerrero == "tramposo" = []
    |otherwise = intercalar ejercicios (replicate (length ejercicios) (descansar 5))

-- Unicamente no podriamos conocer la rutina resultante si nuestro guerrero es sacado

realizarRutina :: [Ejercicio] -> Guerrero -> Guerrero
realizarRutina ejercicios unGuerrero = foldl realizarEjercicio unGuerrero (armarRutina ejercicios unGuerrero)

ejerciciosinfinitos :: [Ejercicio]
ejerciciosinfinitos = repeat flexionesDeBrazo

cantidadOptimaDeMinutos :: Guerrero -> Float
cantidadOptimaDeMinutos unGuerrero 
    | not.estaCansado $ unGuerrero = 0
    | otherwise = ((+1).last.takeWhile (estaCansado . flip descansar unGuerrero)) [0..]