import Text.Show.Functions

data Chico = UnChico {
    nombre :: String,
    edad :: Int,
    habilidades :: [String],
    deseos :: [Deseo] 
} deriving (Show)

type Deseo = Chico -> Chico

modificarHabilidades :: ([String]->[String]) -> Chico -> Chico
modificarHabilidades unaFuncion unChico = unChico {habilidades= unaFuncion.habilidades $ unChico}

modificarEdad :: (Int->Int) -> Chico -> Chico
modificarEdad unaFuncion unChico = unChico {edad = unaFuncion (edad unChico)}

aprenderHabilidades :: [String] -> Deseo
aprenderHabilidades listaDeHabilidades = modificarHabilidades ((++) listaDeHabilidades) -- point free

{- serGrosoEnNeedForSpeed :: Deseo
serGrosoEnNeedForSpeed = foldl aprenderHabilidades -}

serMayor :: Deseo
serMayor unChico = unChico {edad = 18}

type Padrino = Chico->Chico

wanda :: Padrino
wanda = cumplirPrimerDeseo.modificarEdad (+1) -- point free

cumplirPrimerDeseo :: Chico -> Chico
cumplirPrimerDeseo unChico = (head (deseos unChico)) unChico

cosmo :: Padrino
cosmo unChico = modificarEdad (div 2) unChico

muffinMagico :: Padrino
muffinMagico unChico = foldr ($) unChico (deseos unChico)

type Condicion = Chico -> Bool

tieneHabilidad :: String -> Condicion
tieneHabilidad unaHabilidad unChico = elem unaHabilidad (habilidades unChico)

esSuperMaduro :: Condicion
esSuperMaduro unChico = esMayor unChico && tieneHabilidad "manejar" unChico

esMayor :: Condicion
esMayor unChico = edad unChico >= 18

data Chica = UnaChica {
    nombreChica :: String,
    condicion :: Condicion
}

--trixie::Chica
--trixie = UnaChica "Trixie Tang" noEsTimmy

vicky::Chica
vicky = UnaChica "Vicky" (tieneHabilidad "ser un supermodelo noruego")

type Pretendiente = Chico

quienConquistaA :: Chica -> [Pretendiente] -> Pretendiente
quienConquistaA unaChica losPretendientes  
 | siUnoCumple (condicion unaChica) losPretendientes = head (filter (cumplenCondicion (condicion unaChica)) losPretendientes)
 | otherwise = last losPretendientes

cumplenCondicion :: Condicion -> Pretendiente -> Bool
cumplenCondicion unaCondicion unPretendiente = unaCondicion unPretendiente

siUnoCumple :: Condicion -> [Pretendiente] -> Bool
siUnoCumple unaCondicion = any unaCondicion -- point free

--EJEMPLO DE CONSULTA: quienConquistaA mariana [Timmy, Camilo, Juani]
--mariana = UnaChica "Mariana" (tieneHabilidad "cocinar")

infractoresDeDaRules :: [Chico] -> [Chico]
infractoresDeDaRules = filter (tieneDeseosProhibidos) 

tieneDeseosProhibidos :: Chico -> Bool
tieneDeseosProhibidos unChico = tieneHabilidadProhibida (muffinMagico unChico)

tieneHabilidadProhibida :: Chico -> Bool
tieneHabilidadProhibida unChico = tieneHabilidadEnLasPrimeras5 "enamorar" unChico 
 || tieneHabilidadEnLasPrimeras5 "matar" unChico || tieneHabilidadEnLasPrimeras5 "dominar el mundo" unChico

tieneHabilidadEnLasPrimeras5 :: String -> Condicion
tieneHabilidadEnLasPrimeras5 unaHabilidad unChico = elem unaHabilidad (take 5 (habilidades unChico))
