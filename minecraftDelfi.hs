{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions
import Data.List (intersect,(\\))

data Personaje = UnPersonaje {
        nombre:: String,
        puntaje:: Int,
        inventario:: [Material]
} deriving (Show,Eq)

type Material = (String, Int)

data Receta = Receta {
    ingredientes :: [Material],
    producto :: Material,
    tiempo :: Int
}

tieneLosObjetos :: Receta -> Personaje -> Bool
tieneLosObjetos unaReceta unPersonaje = all (`elem` inventario unPersonaje) (ingredientes unaReceta)

quitarUno :: Material -> Material
quitarUno (nombre, cantidad) = (nombre, cantidad-1)

materialesUsados :: [Material] -> [Material]
materialesUsados losMateriales = map quitarUno losMateriales
listaMaterialesUsados :: Receta -> Personaje -> [Material]
listaMaterialesUsados unaReceta unPersonaje= materialesUsados(intersect (ingredientes unaReceta) (inventario unPersonaje))

listaMaterialesSinUsar :: Receta -> Personaje -> [Material]
listaMaterialesSinUsar unaReceta unPersonaje = inventario unPersonaje \\ ingredientes unaReceta 

tomarObjetos :: Receta -> Personaje -> Personaje
tomarObjetos unaReceta unPersonaje = unPersonaje { inventario = listaMaterialesUsados unaReceta unPersonaje ++ listaMaterialesSinUsar unaReceta unPersonaje}
agregarObjetoAlInventario :: Receta -> Personaje -> Personaje
agregarObjetoAlInventario unaReceta unPersonaje = unPersonaje { inventario = producto unaReceta : inventario unPersonaje }

modificarPuntaje :: (Int->Int) -> Personaje -> Personaje
modificarPuntaje modificador unPersonaje = unPersonaje { puntaje = modificador (puntaje unPersonaje) }

craftear :: Receta -> Personaje -> Personaje
craftear unaReceta unPersonaje
    | tieneLosObjetos unaReceta unPersonaje = (agregarObjetoAlInventario unaReceta . modificarPuntaje (+10*tiempo unaReceta) . tomarObjetos unaReceta) unPersonaje
    | otherwise = modificarPuntaje (+(-100)) unPersonaje