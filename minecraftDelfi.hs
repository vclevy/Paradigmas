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
}deriving(Show,Eq)

tieneLosObjetos :: Receta -> Personaje -> Bool
tieneLosObjetos unaReceta unPersonaje = all (`elem` inventario unPersonaje) (ingredientes unaReceta)

quitarUno :: Material -> Material
quitarUno (nombre, cantidad) = (nombre, cantidad-1)

materialesUsados :: [Material] -> [Material]
materialesUsados losMateriales = map quitarUno losMateriales
listaMaterialesUsados :: Receta -> Personaje -> [Material]
listaMaterialesUsados unaReceta unPersonaje= materialesUsados (intersect (ingredientes unaReceta) (inventario unPersonaje))

listaMaterialesSinUsar :: Receta -> Personaje -> [Material]
listaMaterialesSinUsar unaReceta unPersonaje = inventario unPersonaje \\ ingredientes unaReceta

tomarObjetos :: Receta -> Personaje -> Personaje
tomarObjetos unaReceta unPersonaje = unPersonaje { inventario = listaMaterialesUsados unaReceta unPersonaje ++ listaMaterialesSinUsar unaReceta unPersonaje}
agregarObjetoAlInventario :: Receta -> Personaje -> Personaje
agregarObjetoAlInventario unaReceta unPersonaje = unPersonaje { inventario = producto unaReceta : inventario unPersonaje }

modificarPuntaje :: (Int->Int) -> Personaje -> Personaje
modificarPuntaje modificador unPersonaje = unPersonaje { puntaje = modificador (puntaje unPersonaje) }

craftear :: Personaje -> Receta -> Personaje
craftear unPersonaje unaReceta
    | tieneLosObjetos unaReceta unPersonaje = (agregarObjetoAlInventario unaReceta . modificarPuntaje (+10*tiempo unaReceta) . tomarObjetos unaReceta) unPersonaje
    | otherwise = modificarPuntaje (+(-100)) unPersonaje

puntosTotales :: Personaje -> Int->Int
puntosTotales personaje segundos = puntaje personaje + 10*segundos

todosLosQuePuedeCraftear :: [Receta] -> Personaje -> [Receta]
todosLosQuePuedeCraftear recetas personaje = filter (`tieneLosObjetos` personaje) recetas

todosLosQueDuplicanPuntaje :: [Receta] -> Personaje -> [Receta]
todosLosQueDuplicanPuntaje recetas personaje = filter ((2*puntaje personaje<=).puntosTotales personaje. tiempo) recetas

duplicanYPuede :: [Receta]-> Personaje -> [Receta]
duplicanYPuede recetas personaje = intersect (todosLosQuePuedeCraftear recetas personaje) (todosLosQueDuplicanPuntaje recetas personaje)

crafteoSucesivo :: Personaje -> [Receta] -> Personaje
crafteoSucesivo personaje recetas = foldl craftear personaje (duplicanYPuede recetas personaje)

masPuntosOrdenado :: [Receta] -> Personaje -> Bool
masPuntosOrdenado recetas personaje = puntaje (crafteoSucesivo personaje recetas ) > puntaje ((crafteoSucesivo personaje . reverse)recetas)

