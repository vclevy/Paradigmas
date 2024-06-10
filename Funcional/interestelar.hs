{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
import Text.Show.Functions

data Planeta = UnPlaneta {
    nombre :: String,
    posicion :: Posicion,
    relacionTiempo :: Int -> Int
} deriving (Show)

palta :: Planeta
palta = UnPlaneta "Palta" (3.1, 4.3, 5.1) (+3)

fife :: Planeta
fife = UnPlaneta "Fife" (1.2, 2.6, 3.1) (*2)

type Posicion = (Float, Float, Float)

coordenadaX :: Posicion -> Float
coordenadaX (x, _, _) = x

coordenadaY :: Posicion -> Float
coordenadaY (_, y, _) = y

coordenadaZ :: Posicion -> Float
coordenadaZ (_, _, z) = z

data Astronauta = UnAstronauta {
    nombreAstro :: String,
    edadTerrestre :: Int,
    planeta :: Planeta
} deriving (Show)

deltaCoordenada :: Char -> Planeta -> Planeta -> Float
deltaCoordenada 'x' unPlaneta otroPlaneta = coordenadaX (posicion unPlaneta) - coordenadaX (posicion otroPlaneta)
deltaCoordenada 'y' unPlaneta otroPlaneta = coordenadaY (posicion unPlaneta) - coordenadaY (posicion otroPlaneta)
deltaCoordenada 'z' unPlaneta otroPlaneta = coordenadaZ (posicion unPlaneta) - coordenadaZ (posicion otroPlaneta)
deltaCoordenada _ _ _ = error "Invalid coordinate"

distanciaEntre2Planetas :: Planeta -> Planeta -> Float
distanciaEntre2Planetas unPlaneta otroPlaneta =
    sqrt (
        (deltaCoordenada 'x' unPlaneta otroPlaneta)^2 +
        (deltaCoordenada 'y' unPlaneta otroPlaneta)^2 +
        (deltaCoordenada 'z' unPlaneta otroPlaneta)^2
    )

    

