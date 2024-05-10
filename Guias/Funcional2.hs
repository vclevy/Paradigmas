siguiente:: Int -> Int
siguiente = (+1)

mitad :: Int -> Int
mitad = (`div` 2)

triple:: Int -> Int
triple = (3*)

esNumeroPositivo :: Int -> Bool
esNumeroPositivo = (>0)

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe unNumero otroNumero = ((==0) . (`mod` unNumero)) otroNumero

inversa :: Fractional a => a -> a
inversa = (1 /)

inversaRaizCuadrada :: Floating a => a -> a
inversaRaizCuadrada = inversa . sqrt

incrementMCuadradoN:: Int->Int->Int
incrementMCuadradoN m n = ((+m).(^2))n

esResultadoPar:: Int->Int->Bool
esResultadoPar m n = (even.(^m)) n