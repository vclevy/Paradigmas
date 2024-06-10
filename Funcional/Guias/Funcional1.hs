esMultiploDeTres :: Integral a => a -> Bool
esMultiploDeTres unNumero = mod unNumero 3 == 0

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe unNumero otroNumero = mod otroNumero unNumero == 0

cubo:: Num a => a -> a
cubo unNumero = unNumero ^ 3

area:: Num a => a -> a -> a
area base altura = base * altura

esBisiesto:: Integral a => a -> Bool
esBisiesto unAnio = esMultiploDe 400 unAnio || (esMultiploDe 4 unAnio && not (esMultiploDe 100 unAnio))

celsiusToFahr:: Float -> Float
celsiusToFahr celsius = celsius * 9 / 5 + 32

fahrToCelsius:: Float -> Float
fahrToCelsius fahr = (fahr - 32) * 5 / 9

haceFrioF:: Float -> Bool
haceFrioF temperatura = (fahrToCelsius temperatura) < 8

mcm:: Int -> Int -> Int
mcm unNumero otroNumero = unNumero*otroNumero `div` (gcd unNumero otroNumero)

dispersion:: Int-> Int-> Int-> Int
dispersion primerValor segundoValor tercerValor = maximo primerValor segundoValor tercerValor - minimo primerValor segundoValor tercerValor

maximo:: Int-> Int-> Int-> Int
maximo primerValor segundoValor tercerValor = max primerValor (max segundoValor tercerValor)

minimo:: Int-> Int-> Int-> Int
minimo primerValor segundoValor tercerValor = min primerValor (min segundoValor tercerValor)

esDiaParejo:: Int-> Int-> Int-> Bool
esDiaParejo primerValor segundoValor tercerValor = dispersion primerValor segundoValor tercerValor < 30

esDiaLoco:: Int-> Int-> Int-> Bool
esDiaLoco primerValor segundoValor tercerValor = dispersion primerValor segundoValor tercerValor > 100

esDiaNormal:: Int-> Int-> Int-> Bool
esDiaNormal unValor otroValor tercerValor = not (esDiaParejo unValor otroValor tercerValor) && not (esDiaLoco unValor otroValor tercerValor)


pesoPino:: Int-> Int 
pesoPino alturaPino | (alturaPino <= 3) = (3*alturaPino)*100
                    | otherwise = (9 + (alturaPino - 3)*2)*100

esPesoUtil:: Int-> Bool
esPesoUtil unPeso = pesoPino unPeso > 400 && pesoPino unPeso < 1000

