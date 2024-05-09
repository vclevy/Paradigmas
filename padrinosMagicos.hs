
data Chico = Chico {
    nombre :: String,
    edad :: Float,
    habilidades :: [String],
    deseos :: [String] --me hace ruido este tipo de dato!!
}deriving (Show,Eq)
-- PARTE A
aprenderHabilidades :: Chico -> String -> Chico
aprenderHabilidades unChico habilidad = unChico{habilidades = habilidad : habilidades unChico}

serGrosoEnNeedForSpeed :: Chico -> [String] -> Chico
serGrosoEnNeedForSpeed = foldl aprenderHabilidades

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

data Chica = Chica {
    nombreChica :: String,
    condicionChica :: Chico -> Bool
}
trixie :: Chica
trixie = Chica "Trixie Tang" noEsTimmy
vicky :: Chica
vicky = Chica "Vicky" (tieneHabilidad "ser un supermodelo noruego")


noEsTimmy :: Chico -> Bool
noEsTimmy unChico = nombre unChico /= "Timmy"

quienConquistaA :: Chica -> [Chico] -> Chico
quienConquistaA unaChica pretendientes
    | (not.any (condicionChica unaChica)) pretendientes = last pretendientes
    | otherwise = (last.filter (condicionChica unaChica)) pretendientes

tootie :: Chica
tootie = Chica "Vicky's little sister" (tieneHabilidad "sabe cocinar")

-- PARTE C
habilidadesProhibidas :: [String]
habilidadesProhibidas = ["enamorar", "matar" , "dominar el mundo"]

tomaPrimeras5habilidades :: [String] -> [String]
tomaPrimeras5habilidades = take 5 

infractoresDeDaRules :: Chico -> [String]
infractoresDeDaRules unChico = tomaPrimeras5habilidades(filter )