import Text.Show.Functions

data Chico = Chico {
    nombre :: String,
    edad :: Float,
    habilidades :: [String],
    deseos :: [Chico -> Chico]
}

-- PARTE A
aprenderHabilidades :: Chico -> String -> Chico
aprenderHabilidades unChico habilidad = unChico{habilidades = habilidad : habilidades unChico}

serGrosoEnNeedForSpeed :: [String] -> Chico -> Chico
serGrosoEnNeedForSpeed unaString unChico = foldl aprenderHabilidades unChico unaString

serMayor :: Chico -> Chico
serMayor unChico = modificarEdad (*(18/edad unChico)) unChico

cumplirDeseo :: Chico -> (Chico -> Chico) -> Chico
cumplirDeseo unChico unDeseo = unDeseo unChico

wanda :: Chico -> Chico
wanda unChico = ((cumlpirPrimerDeseo.modificarEdad(+1))unChico) {deseos = init (deseos unChico)}
cumlpirPrimerDeseo :: Chico -> Chico
cumlpirPrimerDeseo unChico = cumplirDeseo unChico (head(deseos unChico))

cosmo :: Chico -> Chico
cosmo = modificarEdad (/2) 

modificarEdad :: (Float -> Float) -> Chico -> Chico
modificarEdad modificador unChico = unChico {edad = modificador (edad unChico)}

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldl cumplirDeseo unChico (deseos unChico)

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

tomaCinco :: Chico -> Chico
tomaCinco unChico = unChico{habilidades = take 5 (habilidades unChico)}

tieneAlgunaDeLasProhibidas :: Chico -> Bool
tieneAlgunaDeLasProhibidas unChico = (tieneHabilidad "enamorar".tomaCinco) unChico ||(tieneHabilidad "matar".tomaCinco) unChico ||(tieneHabilidad "Dominar el mundo".tomaCinco) unChico

todosLosDeseos :: [Chico] -> [Chico]
todosLosDeseos  =  map muffinMagico 

infractoresDeDaRules :: [Chico] -> [String]
infractoresDeDaRules losChicos = map nombre (filter tieneAlgunaDeLasProhibidas (todosLosDeseos losChicos))

{-Ejemplos-}

timmy :: Chico
timmy = Chico {
    nombre = "Timmy",
    edad = 15.5,
    habilidades = ["Programación", "Fútbol","matar"],
    deseos = [serMayor]
}

chico2 :: Chico
chico2 = Chico {
    nombre = "Maria",
    edad = 17,
    habilidades = ["Cocina", "Baile"],
    deseos = [serMayor, serGrosoEnNeedForSpeed ["Conducción"]]
}

chico3 :: Chico
chico3 = Chico {
    nombre = "Carlos",
    habilidades = ["Lectura", "Pintura"],
    deseos = [cumlpirPrimerDeseo, muffinMagico, serGrosoEnNeedForSpeed ["needForSpeed2"]]
}
