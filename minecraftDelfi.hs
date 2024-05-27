{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
import Text.Show.Functions
import Data.List ((\\))

data Personaje = UnPersonaje {
        nombre:: String,
        puntaje:: Int,
        inventario:: [Material]
} deriving (Show,Eq)

type Material = (String,Int)

data Receta = Receta{
    receta::[Material],
    objeto :: Material,
    tiempo :: Int
}deriving (Show,Eq)

tieneLosObjetos :: Receta -> Personaje -> Bool
tieneLosObjetos unaReceta unPersonaje = all (tieneElObjeto unPersonaje) (receta unaReceta)

tieneElObjeto :: Personaje -> Material -> Bool
tieneElObjeto unPersonaje unMaterial = elem (fst unMaterial) (map fst (inventario unPersonaje))

personaje :: Personaje
personaje = UnPersonaje {
    nombre = "Steve",
    puntaje = 0,
    inventario = [("Madera",2), ("Piedra",3), ("Hierro",4), ("Diamante",1)]
}

recetaPico :: Receta
recetaPico = Receta [("Madera",2), ("Piedra",4)] ("pico",1) 20

modificarPuntaje :: (Int->Int) -> Personaje -> Personaje
modificarPuntaje modificador unPersonaje = unPersonaje{puntaje = modificador (puntaje unPersonaje)}


tomarObjetos :: Receta -> Personaje -> Personaje
tomarObjetos unaReceta unPersonaje = unPersonaje{inventario = receta unaReceta \\ inventario unPersonaje}

craftear :: Receta -> Personaje -> Personaje
craftear unaReceta unPersonaje
    | tieneLosObjetos unaReceta unPersonaje=(modificarPuntaje (+10*tiempo unaReceta). tomarObjetos unaReceta) unPersonaje
    | otherwise = modificarPuntaje (+(-100)) unPersonaje
