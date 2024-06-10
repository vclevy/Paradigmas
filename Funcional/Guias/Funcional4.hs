sumarElementosDeLista :: [Int] -> Int
sumarElementosDeLista unaLista = sum unaLista

frecuenciaCardiaca :: [Int]
frecuenciaCardiaca = [80, 100, 120, 128, 130, 123, 125] 

promedioFrecuenciaCardiaca :: Fractional a => [Int] -> a
promedioFrecuenciaCardiaca listaDeFrecuencia = fromIntegral (sumarElementosDeLista listaDeFrecuencia) / fromIntegral (length listaDeFrecuencia)

frecuenciaCardiacaMinuto :: [Int] -> Int -> Int
frecuenciaCardiacaMinuto listaDeFrecuencia minuto = listaDeFrecuencia !! (minuto `div` 10)

frecuenciasHastaElMomento :: [Int] -> Int -> [Int]
frecuenciasHastaElMomento listaDeFrecuencia minutos = take (minutos `div` 10) listaDeFrecuencia


type EqList a = Eq a => [a]

esCapicua:: Eq a => [[a]] -> Bool
esCapicua listas = concat listas == (reverse.concat) listas

type DuracionLlamadas = [(String, [Int])]
duracionLlamadas :: DuracionLlamadas
duracionLlamadas = [("horarioReducido",[20,10,25,15]),("horarioNormal",[10,5,8,2,9,10])]

cuandoHabloMasMinutos :: DuracionLlamadas -> String
cuandoHabloMasMinutos llamadas 
    | sum (snd (head llamadas)) > sum (snd (head (tail llamadas))) = fst (head llamadas)
    | otherwise = fst (head (tail llamadas))

cuandoHizoMasLlamadas:: DuracionLlamadas -> String 
cuandoHizoMasLlamadas llamadas |llamadasDeHorarioReducido llamadas > llamadasDeHorarioNormal llamadas = "horarioReducido"
                                |otherwise = "horarioNormal"

llamadasDeHorarioReducido :: DuracionLlamadas -> Int
llamadasDeHorarioReducido llamadas = length (snd (head llamadas))
llamadasDeHorarioNormal :: DuracionLlamadas -> Int
llamadasDeHorarioNormal llamadas = length (snd (head (tail llamadas)))

type TresNum = (Int, Int, Int)

existsAny:: TresNum -> (Int -> Bool) -> Bool
existsAny (primerNum, segundoNum, tercerNum) funcion = funcion primerNum || funcion segundoNum || funcion tercerNum

mejor :: (Int -> Int) -> (Int -> Int) -> Int -> Int
mejor funcion1 funcion2 numero = max (funcion1 numero) (funcion2 numero)

type Par = (Int, Int)

aplicarPar :: (Int -> Int) -> Par -> Par
aplicarPar unaFuncion (primerNum, segundoNum) = (unaFuncion primerNum, unaFuncion segundoNum)

parDeFns :: (Int -> Int) -> (Int -> Int) -> Int -> Par
parDeFns funcion1 funcion2 unNumero = (funcion1 unNumero, funcion2 unNumero)

esMultiploDeAlguno :: Int -> [Int] -> Bool
esMultiploDeAlguno unNumero listaDeNumeros = any (esMultiploDe unNumero) listaDeNumeros

esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe unNumero otroNumero = mod otroNumero unNumero == 0

promedio :: [Int] -> Float
promedio lista = fromIntegral (sum lista) / fromIntegral(length lista)

promedios :: [[Int]] -> [Float] 
promedios listaDeListas = map promedio listaDeListas

promediosSinAplazo :: [[Int]] -> [Float]
promediosSinAplazo listaDeListas = filter (>4) (map promedio listaDeListas)

mejoresNotas :: [[Int]] -> [Int]
mejoresNotas listaDeListas = map maximum listaDeListas

aprobo :: [Int] -> Bool
aprobo notasDelAlumno = all (>=6) notasDelAlumno

aprobaron:: [[Int]] -> [[Int]]
aprobaron listaDeListas = filter aprobo listaDeListas

divisores :: Int -> [Int]
divisores unNumero = filter ((== 0) . mod unNumero) [1..unNumero]

exists :: Num a => (a->Bool) -> [a] -> Bool
exists funcionBooleana lista = any funcionBooleana lista

aplicarFunciones :: Num a => [(a -> a)] -> a -> [a]
aplicarFunciones funciones unValor = map ($ unValor) funciones -- DUDAS

sumarF :: Num a => [(a -> a)] -> a -> a
sumarF funciones unValor = (sum.aplicarFunciones funciones) unValor

subirHabilidad :: Int -> [Int] -> [Int]
subirHabilidad unNumero lista = map (agregarNumero unNumero) lista

agregarNumero :: Int -> Int -> Int
agregarNumero n x = min (x + n) 12

flimitada :: (Int->Int) -> Int -> Int
flimitada unaFuncion unNumero | unaFuncion unNumero <0 = 0
                                |otherwise = min (unaFuncion unNumero) 12

cambiarHabilidad :: (Int->Int) -> [Int] -> [Int]
cambiarHabilidad unaFuncion habilidades = map (flimitada unaFuncion) habilidades