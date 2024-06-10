type TresNum = (Int, Int, Int)
type DuplaDeNumeros = (Int, Int)
fst3 :: TresNum -> Int
fst3 (primerNum, _ , _) = primerNum

snd3 :: TresNum -> Int
snd3 (_, segundoNum, _) = segundoNum

trd3 :: TresNum -> Int
trd3 (_, _, tercerNum) = tercerNum

doble :: Int -> Int
doble = (2*)

triple:: Int -> Int
triple = (3*)

type DuplaDeFunciones = (Int -> Int, Int -> Int)

aplicar :: DuplaDeFunciones -> Int -> (Int, Int)
aplicar (doble, triple) unNumero = (doble unNumero, triple unNumero)

cuentaBizarra :: DuplaDeNumeros -> Int
cuentaBizarra (unNumero, otroNumero) | unNumero > otroNumero = unNumero+otroNumero 
                                     | (otroNumero-10)>unNumero = otroNumero-unNumero
                                     | otherwise = unNumero*otroNumero

type Notas = (Int, Int)

esNotaBochazo :: Notas -> Bool
esNotaBochazo (primerNota, segundaNota) = primerNota < 6 || segundaNota < 6

aprobo:: Notas-> Bool
aprobo (primerNota, segundaNota) = not (esNotaBochazo (primerNota, segundaNota))

promociono:: Notas-> Bool
promociono (primerNota, segundaNota) = (primerNota >=7 && segundaNota >=7) && (primerNota+segundaNota) >= 15

aproboPrimerParcial :: Notas -> Bool
aproboPrimerParcial = not . esNotaBochazo . (\(primerNota, _) -> (primerNota, primerNota))