{-# OPTIONS_GHC -Wno-missing-fields #-}
import Data.Char (toUpper,isUpper)
import Text.Show.Functions
import Data.List (intersect)


data Barbaro = Barbaro{
    nombre :: String,
    fuerza :: Int,
    habilidades :: [String],
    objetos :: [Objetos]
}deriving(Show)

type Objetos = Barbaro->Barbaro
dave :: Barbaro
dave = Barbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla, varitasDefectuosas]

--PUNTO 1

espada :: Int -> Objetos
espada kilos unBarbaro = Barbaro {fuerza = fuerza unBarbaro + 2*kilos}

amuletosMisticos :: String -> Objetos
amuletosMisticos habilidad unBarbaro = Barbaro{habilidades = habilidad : habilidades unBarbaro}

varitasDefectuosas :: Objetos
varitasDefectuosas unBarbaro = (amuletosMisticos "hacer magia" unBarbaro){objetos = []}

ardilla :: Objetos
ardilla unBarbaro = unBarbaro

cuerda :: Objetos -> Objetos -> Objetos
cuerda unObjeto otroObjeto = unObjeto.otroObjeto

--PUNTO 2
megafono :: Objetos
megafono unBarbaro = Barbaro {habilidades = [concatMap (map toUpper) (habilidades unBarbaro)]}

megafonoBarbarico :: Objetos
megafonoBarbarico = cuerda megafono ardilla

--PUNTO 3

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes = elem "Escribir Poesía Atroz".habilidades

cremalleraDelTiempo :: Evento
cremalleraDelTiempo unBarbaro = nombre unBarbaro == "Faffy" || nombre unBarbaro == "Astro"

totalLength :: [String] -> Int
totalLength list = length (concat list) --Cuando desarrolle megafono quizas se puede reemplazar

saqueo :: Evento
saqueo unBarbaro = fuerza unBarbaro>80 && elem "robar" (habilidades unBarbaro)

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = 4* (length.objetos) unBarbaro == (totalLength.habilidades) unBarbaro

caligrafia :: Evento
caligrafia unBarbaro = masDe3Vocales unBarbaro && comienzanConMayuscula unBarbaro

masDe3Vocales :: Evento
masDe3Vocales unBarbaro = ((3<).length.filter (`elem` vocales)) (concat (habilidades unBarbaro))
vocales :: [Char]
vocales = "aáAÁeéEÉiíÍIoOóÓuúÚU"

comienzanConMayuscula :: Evento
comienzanConMayuscula unBarbaro = all (isUpper . head) (habilidades unBarbaro)

type Evento = Barbaro -> Bool
type Aventura = [Evento]

ritualDeFechorias :: Evento
ritualDeFechorias unBarbaro = saqueo unBarbaro || gritoDeGuerra unBarbaro || caligrafia unBarbaro

aventuraEscribirA4dedos :: [Evento]
aventuraEscribirA4dedos = [invasionDeSuciosDuendes, cremalleraDelTiempo]

aventuraTodoPoderoso :: [Evento]
aventuraTodoPoderoso = [ritualDeFechorias]

sobrevivientes :: Aventura -> [Barbaro] -> [Barbaro]
sobrevivientes unaAventura  = filter (sobreviveAventura unaAventura) 

sobreviveAventura :: Aventura -> Barbaro -> Bool
sobreviveAventura aventura barbaro = all (\evento -> evento barbaro) aventura

--PUNTO 4

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs)
    | x `elem` xs = sinRepetidos xs
    | otherwise   = x : sinRepetidos xs

asteriscosInfinitos :: [String]
asteriscosInfinitos = map (`replicate` '*') [1..]

descendientes :: Barbaro -> [Barbaro]
descendientes = undefined
