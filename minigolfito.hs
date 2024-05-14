{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
import Text.Show.Functions

-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between :: (Eq a, Enum a) => a -> a -> a -> Bool
between n m x = elem x [n .. m]

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)
mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

type Palo = Jugador -> Tiro

putter :: Palo
putter unJugador = UnTiro{velocidad = 10, precision = 2* precisionJugador (habilidad unJugador), altura = 0 }

--madera :: Palo  
--madera unJugador = UnTiro{velocidad = 100 ,precision = 0.5*precisionJugador (habilidad unJugador),altura =5}

hierros :: Int-> Palo
hierros n unJugador = UnTiro{velocidad = n* fuerzaJugador (habilidad unJugador), precision = precisionJugador (habilidad unJugador)/n, altura=menorA3minimo0 n}

menorA3minimo0 :: Int->Int
menorA3minimo0 n 
    | n-3<0 = 0
    | otherwise 

--palos :: [Palo]
--palos = [putter] ++ [madera] ++ map hierros [1..10]

golpes :: Jugador -> Palo -> Tiro
golpes unJugador unPalo = unPalo unJugador



