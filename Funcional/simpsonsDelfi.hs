{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions

data Personaje = Personaje{
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
}deriving(Show,Eq)

modificarFelicidad :: (Int->Int) -> Actividad
modificarFelicidad modificador unPersonaje = unPersonaje{felicidad = (max 0.modificador.felicidad) unPersonaje}

type Actividad = Personaje -> Personaje

irALaEscuela :: Actividad
irALaEscuela unPersonaje
    | nombre unPersonaje == "Lisa" = modificarFelicidad (+20) unPersonaje
    | otherwise = modificarFelicidad (subtract 20) unPersonaje

modificarDinero :: (Int->Int) -> Actividad
modificarDinero modificador unPersonaje = unPersonaje{dinero = (modificador.dinero) unPersonaje}

comerNDonas :: Int -> Actividad
comerNDonas n = modificarDinero (subtract (10*n)).modificarFelicidad (+10*n)

irATrabajar :: [Char] -> Actividad
irATrabajar trabajo = modificarDinero (+ length trabajo)

irATrabajarComoDirector :: Actividad
irATrabajarComoDirector = irATrabajar "escuela elemental".modificarFelicidad (subtract 20)

modificarNombre :: (String -> String) -> Actividad
modificarNombre modificador unPersonaje = unPersonaje{nombre= (modificador.nombre) unPersonaje}

tomarCerveza :: Int -> Actividad
tomarCerveza n = modificarNombre (++ " borracho").modificarDinero (subtract (20*n))

homero :: Personaje
homero = Personaje "Homero" 10 10

skinner :: Personaje
skinner = Personaje "Skinner" 0 0

lisa :: Personaje
lisa = Personaje "Lisa" 0 20

{-
ghci> comerNDonas 12 homero
Personaje {nombre = "Homero", dinero = -110, felicidad = 130}

ghci> irATrabajarComoDirector skinner
Personaje {nombre = "Skinner", dinero = 17, felicidad = 0}

ghci> (tomarCerveza 2.irALaEscuela) lisa
Personaje {nombre = "Lisa borracho", dinero = -40, felicidad = 40}
-}

type Logro = Personaje -> Bool

srBurns :: Personaje
srBurns = Personaje "Sr. Burns" 100 0

serMillonario ::  Logro
serMillonario unPersonaje = dinero unPersonaje > dinero srBurns

alegrarse :: Int ->  Logro
alegrarse deseada unPersonaje = felicidad unPersonaje > deseada

verKrosti ::  Logro
verKrosti unPersonaje = dinero unPersonaje >= 10

ahorcarABart ::  Logro
ahorcarABart unPersonaje = nombre unPersonaje == "Homero"

esDecisiva :: Logro -> Personaje -> Actividad -> Bool
esDecisiva unLogro unPersonaje unaActividad = (not.unLogro) unPersonaje && (unLogro.unaActividad) unPersonaje

laDecisiva :: Logro -> Personaje -> [Actividad] -> [Actividad]
laDecisiva  unLogro unPersonaje = filter (esDecisiva unLogro unPersonaje)

aplicarDecisiva :: [Actividad] -> Logro -> Personaje -> Personaje
aplicarDecisiva [] _ unPersonaje = unPersonaje
aplicarDecisiva actividades unLogro unPersonaje =  head (laDecisiva unLogro unPersonaje actividades) unPersonaje

algunaPermiteSerMillonario :: [Actividad] -> Personaje -> Bool
algunaPermiteSerMillonario actividades unPersonaje= any (esDecisiva serMillonario unPersonaje) actividades

aplicarPrimeras :: Int -> [Actividad] -> Actividad
aplicarPrimeras n actividades unPersonaje = foldl (flip($)) unPersonaje (take n actividades) 
