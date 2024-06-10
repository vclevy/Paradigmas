import Text.Show.Functions

data Simpson = UnSimpson {
    nombre :: String,
    dinero :: Int,
    felicidad :: Int
} deriving Show

modificarNombre :: (String -> String) -> Simpson -> Simpson
modificarNombre unaFuncion unSimpson = unSimpson {nombre = unaFuncion.nombre $ unSimpson}

modificarDinero :: (Int -> Int) -> Simpson -> Simpson
modificarDinero unaFuncion unSimpson = unSimpson {dinero = unaFuncion.dinero $ unSimpson}

modificarFelicidad :: (Int -> Int) -> Simpson -> Simpson
modificarFelicidad unaFuncion unSimpson = unSimpson {felicidad = max 0.unaFuncion.felicidad $ unSimpson}


type Actividad = Simpson -> Simpson

irALaEscuela :: Actividad
irALaEscuela unSimpson 
 | es "Lisa" unSimpson = modificarFelicidad (+20) unSimpson
 |otherwise = modificarFelicidad (subtract 20) unSimpson

es :: String -> Simpson -> Bool
es unNombre unSimpson = nombre unSimpson == unNombre

comerDonas :: Int -> Actividad
comerDonas cantidadDeDonas unSimpson = modificarFelicidad (+(10*cantidadDeDonas)).modificarDinero (subtract 10) $ unSimpson

irATrabajar :: String -> Actividad
irATrabajar unTrabajo unSimpson = modificarDinero (+length unTrabajo) unSimpson

serDirector :: Actividad
serDirector unSimpson = irALaEscuela.irATrabajar "escuela elemental" $ unSimpson

homero :: Simpson
homero = UnSimpson "Homero" 30 100

srBurns :: Simpson
srBurns = UnSimpson "Sr Burns" 1000 100

bart :: Simpson
bart = UnSimpson "Bart" 6 1

-- inventar uno : usarCelular, aumenta feliciad en 10
-- skinner va a trabajar como director: serDirector skinner

type Logro = Simpson -> Bool

serMillonario :: Logro
serMillonario unSimpson = dinero unSimpson > dinero srBurns

alegrarse :: Int -> Logro
alegrarse unNivel unSimpson = felicidad unSimpson > unNivel

irAVerProgramaDeKrosti :: Logro
irAVerProgramaDeKrosti (UnSimpson _ dineroSimpson _) = dineroSimpson > 10 -- solo para usar pattern matching

-- inventar un logro

esDecisiva :: Actividad -> Simpson -> Logro -> Bool
esDecisiva unaActividad unSimpson unLogro = (unLogro.unaActividad) unSimpson || (not.unLogro) unSimpson

encontrarLaActivadadDecisivaParaLograrElLogro :: [Actividad] -> Logro -> Simpson -> Simpson
encontrarLaActivadadDecisivaParaLograrElLogro [] unLogro unSimpson = unSimpson
encontrarLaActivadadDecisivaParaLograrElLogro (actividad : actividades) unLogro personaje
    | esDecisiva actividad personaje unLogro = actividad personaje
    | otherwise = encontrarLaActivadadDecisivaParaLograrElLogro (drop 1 actividades) unLogro personaje

-- Definimos lista infita de actividades:

hacerActividadesInfinitas :: [Actividad] -> [Actividad]
hacerActividadesInfinitas actividades = actividades ++ hacerActividadesInfinitas actividades







