import Text.Show.Functions

data Guantelete = Guantelete{
    material :: String,
    gemas :: [Gema]
}deriving (Show)

type Gema = Personaje -> Personaje

data Personaje = Personaje{
    edad :: Int,
    energia :: Int,
    habilidades :: [String],
    nombre :: String,
    planeta :: String
}deriving(Show,Eq)

type Universo = [Personaje]

-- Modificar datas

modificarEnergia :: (Int->Int) -> Personaje -> Personaje
modificarEnergia modificador personaje = personaje{energia = modificador (energia personaje)}

modificarGemaes :: ([String]->[String]) -> Personaje -> Personaje
modificarGemaes modificador personaje = personaje{habilidades = modificador (habilidades personaje)}

modificarPlaneta :: String -> Personaje -> Personaje
modificarPlaneta modificador personaje = personaje{planeta = modificador}

modificarEdad :: Int -> Personaje -> Personaje
modificarEdad modificador unPersonaje = unPersonaje{edad = modificador }

puedeChasquear :: Guantelete -> Bool
puedeChasquear unGuantelete = (length.gemas) unGuantelete == 6 && material unGuantelete == "uru"

chasquearUniverso :: Universo -> Guantelete -> Universo
chasquearUniverso unUniverso unGuantelete
    | puedeChasquear unGuantelete = take (div 2 (length unUniverso)) unUniverso
    | otherwise = unUniverso

paraPendex :: Universo -> Bool
paraPendex = any ((<45).edad)

tieneMasDeNGemaes :: Int -> Universo -> Universo
tieneMasDeNGemaes n = filter ((>n).length.habilidades)

energiaTotal :: Universo -> Int
energiaTotal unUniverso = sum (map energia (tieneMasDeNGemaes 1 unUniverso))

laMente :: Int -> Gema
laMente n = modificarEnergia (subtract n)

elAlma :: String -> Gema
elAlma unaGema = modificarEnergia (subtract 10). modificarGemaes (filter (/= unaGema))

elEspacio :: String -> Gema
elEspacio planetaDestino = modificarEnergia (subtract 20).modificarPlaneta planetaDestino

elPoder :: Gema
elPoder unPersonaje
    | ((>2).length.habilidades) unPersonaje = unPersonaje
    | otherwise = (modificarEnergia (subtract (energia unPersonaje)).modificarGemaes (take 0)) unPersonaje

elTiempo :: Gema
elTiempo unPersonaje = (modificarEnergia (subtract 50).modificarEdad (max 18 (div (edad unPersonaje) 2)) )unPersonaje

gemaLoca :: Gema -> Gema
gemaLoca unaGema = unaGema.unaGema

--Punto 4

goma :: Guantelete
goma = Guantelete "goma" [elTiempo,elAlma "usar Mjolnir", gemaLoca (elAlma "programación en Haskell")]

utilizar :: [Gema] -> Personaje -> Personaje
utilizar lasGemas unPersonaje = foldl (flip ($)) unPersonaje lasGemas

gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa (Guantelete _ []) _ = error "No hay gemas en el guantelete."
gemaMasPoderosa (Guantelete _ [p]) _ = p
gemaMasPoderosa (Guantelete _ (gema:gemas)) personaje = gemaMasPoderosa' gemas gema personaje

gemaMasPoderosa' :: [Gema] -> Gema -> Personaje -> Gema
gemaMasPoderosa' [] unaGema _ = unaGema
gemaMasPoderosa' (gema:gemas) unaGema personaje
  | (energia.gema) personaje < (energia.unaGema) personaje = gemaMasPoderosa' gemas gema personaje
  | otherwise = gemaMasPoderosa' gemas unaGema personaje

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:infinitasGemas gema

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" (infinitasGemas elTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas = utilizar . take 3. gemas

-- Por mas que sepamos nosotros que gemaMasPoderosa con elTiempo hace siempre el mismo dano, al usar
--una lista infinitasGemas jamas termina de analizar si esto es asin

--la otra funcion si se puede utilzar porque basta con que haya 3 elementos para que los pueda utilizar