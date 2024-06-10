import Text.Show.Functions

data Guantelete = UnGuantelete {
    material :: String,
   gemas :: [Gema]
} deriving (Show)

type Gema = Personaje -> Personaje 

data Personaje = UnPersonaje{
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    nombre :: String,
    planeta :: String
} deriving (Show)

punisher = UnPersonaje 19 30 ["comer"] "punisher" "oda"

modificarHabilidades :: ([String]->[String]) -> Personaje -> Personaje
modificarHabilidades unaFuncion personaje = personaje {habilidades = unaFuncion (habilidades personaje)}

modificarEnergia :: (Int->Int) -> Personaje -> Personaje
modificarEnergia unaFuncion personaje = personaje{energia = unaFuncion (energia personaje)}

modificarGemaes :: ([String]->[String]) -> Personaje -> Personaje
modificarGemaes unaFuncion personaje = personaje{habilidades = unaFuncion (habilidades personaje)}

modificarPlaneta :: (String->String) -> Personaje -> Personaje
modificarPlaneta unaFuncion personaje = personaje {planeta = unaFuncion (planeta personaje)}

modificarEdad :: (Int->Int) -> Personaje -> Personaje
modificarEdad unaFuncion personaje = personaje {edad = unaFuncion (edad personaje)}

type Universo = [Personaje]

estaCompleto:: Guantelete -> Bool
estaCompleto unGuantelete = length (gemas unGuantelete) == 6 && material unGuantelete == "uru"

xasquearUniverso :: Guantelete -> Universo -> Universo
xasquearUniverso unGuantelete unUniverso 
    |estaCompleto unGuantelete = take (div (length unUniverso) 2) unUniverso
    |otherwise = unUniverso

esAptoParaPendex :: Universo -> Bool
esAptoParaPendex unUniverso = any ((<45).edad) unUniverso

masDeUnaHabilidad :: Personaje -> Bool
masDeUnaHabilidad unPersonaje = length (habilidades unPersonaje) >1

energiaTotal :: Universo -> Int
energiaTotal unUniverso = sum.map energia $ (filter masDeUnaHabilidad unUniverso)

laMente :: Int -> Gema
laMente unValor unPersonaje =  modificarEnergia (subtract unValor) unPersonaje

elAlma :: String -> Gema
elAlma unaHabilidad unPersonaje = modificarHabilidades (filter (/=unaHabilidad)).modificarEnergia (subtract 10) $ unPersonaje

elEspacio :: String -> Gema
elEspacio unPlaneta unPersonaje = modificarPlaneta (const unPlaneta).modificarEnergia (subtract 20) $ unPersonaje

elPoder :: Gema
elPoder unPersonaje
 | (<2).length.habilidades $ unPersonaje = modificarHabilidades(take 0).modificarEnergia (const 0) $ unPersonaje
 |otherwise = modificarEnergia (const 0) unPersonaje

elTiempo :: Gema
elTiempo unPersonaje = modificarEdad (max 18.(`div` 2)) unPersonaje

laGemaLoca :: Gema-> Gema
laGemaLoca unaGema = unaGema.unaGema

papuGuantelete :: Guantelete
papuGuantelete = UnGuantelete "goma" [elTiempo, elAlma "usar Mjolnir", laGemaLoca (elAlma "programacion en Haskell")]

type Oponente = Personaje

utilizar :: [Gema] -> Oponente -> Oponente
utilizar unasGemas unOponente = foldr ($) unOponente unasGemas

gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa (UnGuantelete _ [unaGema]) _ = unaGema
gemaMasPoderosa (UnGuantelete _ (cabeza:cola)) personaje = gemaMasPoderosa' cola cabeza personaje

gemaMasPoderosa' :: [Gema] -> Gema -> Personaje -> Gema
gemaMasPoderosa' [] unaGema _ = unaGema
gemaMasPoderosa' (gema:gemas) unaGema personaje
  | (energia.gema) personaje < (energia.unaGema) personaje = gemaMasPoderosa' gemas gema personaje
  | otherwise = gemaMasPoderosa' gemas unaGema personaje

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3. gemas) guantelete

