
data Chico = Chico {
    nombre :: String,
    edad :: Float,
    habilidades :: [String],
    deseos :: [String] --me hace ruido este tipo de dato!!
}deriving (Show,Eq)
-- PARTE A
aprenderHabilidades :: Chico -> String -> Chico
aprenderHabilidades unChico habilidad = unChico{habilidades = habilidad : habilidades unChico}

serGrosoEnNeedForSpeed :: Chico -> a -> Chico
serGrosoEnNeedForSpeed unChico need4speed = foldl aprenderHabilidades unChico need4speed

serMayor :: Chico -> Chico
serMayor unChico = modificarEdad unChico (*(18/edad unChico))

wanda :: Chico -> Chico
wanda unChico = (modificarEdad unChico (+1)) {deseos = init (deseos unChico)}

cosmo :: Chico -> Chico
cosmo unChico = modificarEdad unChico (/2)

modificarEdad :: Chico -> (Float->Float) -> Chico
modificarEdad unChico modificador = unChico{edad = modificador (edad unChico)}

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldl aprenderHabilidades unChico (deseos unChico)

-- PARTE B
tieneHabilidad :: String -> Chico -> Bool
tieneHabilidad unaHabilidad unChico = unaHabilidad `elem` habilidades unChico

esSuperMaduro :: String -> Chico -> Bool
esSuperMaduro unaHabilidad unChico = edad unChico >= 18 && tieneHabilidad unaHabilidad unChico

-- para Trixie la única condición es que el chico no sea Timmy,

--ya que nunca saldría con él
--trixie = Chica “Trixie Tang” noEsTimmy
--vicky = Chica “Vicky” (tieneHabilidad “ser un supermodelo noruego”)
data Chica = Chica {
    nombreChica :: String,
    condicionChica :: String->Chico->Bool
}

noEsTimmy :: String -> Chico -> Bool
noEsTimmy "Timmy" _ = False
noEsTimmy _ _ = True

quienConquistaA :: Chica -> [String] -> [String]
quienConquistaA = undefined
