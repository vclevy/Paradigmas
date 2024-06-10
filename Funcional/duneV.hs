import Text.Show.Functions

data Fremen = UnFremen{
    nombre:: String,
    toleranciaEspecia:: Int,
    titulos :: [String],
    reconocimientos :: Int
} deriving (Show,Eq)

type Tribu = [Fremen]

modificarReconocimiento :: (Int->Int) -> Fremen -> Fremen
modificarReconocimiento unaFuncion unFremen = unFremen {reconocimientos= unaFuncion.reconocimientos $ unFremen}
modificarTitulos :: ([String]->[String]) -> Fremen -> Fremen
modificarTitulos unaFuncion unFremen = unFremen {titulos= unaFuncion.titulos $ unFremen}
modificarTolerencia :: (Int->Int) -> Fremen -> Fremen
modificarTolerencia unaFuncion unFremen = unFremen {toleranciaEspecia= unaFuncion.toleranciaEspecia $ unFremen}

recibirReconocimiento :: Fremen -> Fremen
recibirReconocimiento = modificarReconocimiento (+1)

algunCandidato :: Tribu -> Bool
algunCandidato unaTribu = any (esCandidato) unaTribu

esCandidato :: Fremen -> Bool
esCandidato unFremen = elem "Domador" (titulos unFremen) && toleranciaEspecia unFremen > 100

candidatos :: Tribu -> Tribu
candidatos unaTribu = filter esCandidato unaTribu

hallarElegido :: Tribu -> Fremen
hallarElegido unaTribu = masReconocimientos (candidatos unaTribu)

masReconocimientos :: Tribu -> Fremen
masReconocimientos unaTribu = foldr1 (compararReconocimientos) unaTribu

compararReconocimientos :: Fremen -> Fremen -> Fremen
compararReconocimientos unFremen otroFremen
 | reconocimientos unFremen > reconocimientos otroFremen = unFremen
 | otherwise = otroFremen

data Gusano = UnGusano{
    longitud :: Float,
    nivelDeHidratacion :: Int,
    descripcion :: String
} deriving Show

pepe = UnGusano 10 5 "rojo con lunares"
bibi = UnGusano 8 1 "dientes puntiagudos"

type Gusanito = Gusano

reproducir :: Gusano -> Gusano -> Gusanito
reproducir unGusano otroGusano = UnGusano {longitud= longitudCria unGusano otroGusano, nivelDeHidratacion=0, descripcion= descripcion unGusano ++ " - " ++ descripcion otroGusano}

longitudCria :: Gusano -> Gusano -> Float
longitudCria unGusano otroGusano = (max (longitud unGusano) (longitud otroGusano))*0.1

apareo :: [Gusano] -> [Gusano] -> [Gusano]
apareo unosGusanos otrosGusanos = zipWith reproducir unosGusanos otrosGusanos
-- apareo sin utilizar zipWith
apareo' :: [Gusano] -> [Gusano] -> [Gusano]
apareo' unosGusanos otrosGusanos = map (uncurry reproducir) (zip unosGusanos otrosGusanos)

{- domarGusano :: Mision
domarGusano unFremen unGusano
 | toleranciaEspecia unFremen >= (longitud unGusano)*0.5 = modificarTitulos ("domador":).modificarTolerencia (+100) $ unFremen
 -- | otherwise = modificarTolerencia (subtract (0.2*(toleranciaEspecia unFremen))) unFremen
 |otherwise = unFremen -- lo hago por los tipos de dato nada más -}

type Mision = Gusano -> Fremen -> Fremen

misionColectiva :: Gusano -> Tribu -> Mision -> Tribu
misionColectiva unGusano unaTribu unaMision = map (unaMision unGusano) unaTribu

diferenteElegido :: Tribu ->Mision -> Gusano -> Bool
diferenteElegido unaTribu unaMision unGusano = hallarElegido unaTribu /= hallarElegido (misionColectiva unGusano unaTribu unaMision)
