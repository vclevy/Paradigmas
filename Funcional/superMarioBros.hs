{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# OPTIONS_GHC -Wno-typed-holes #-}
import Text.Show.Functions
import Data.Char (isUpper)


data Plomero = Plomero{
    nombre :: [Char],
    caja :: [Herramienta],
    historial :: [Reparacion], --Seguro cambia
    dinero :: Int
}deriving(Show)

data Herramienta = Herramienta{
    nombreHerramienta :: String,
    precio :: Int,
    material :: String
} deriving(Show,Eq)

data Reparacion = Reparacion{
    descripcion :: [Char],
    requerimiento :: Plomero -> Bool
}deriving (Show)

llaveInglesa :: Herramienta
llaveInglesa = Herramienta "Llave inglesa" 220 "hierro"

martillo :: Herramienta
martillo = Herramienta "Martillo" 20 "madera"

mario :: Plomero
mario = Plomero "Mario" [llaveInglesa, martillo] [] 1200

wario :: Plomero
wario = Plomero "Wario" infinitasLlavesF [] (div 1 2)

llaveFrancesa :: Herramienta
llaveFrancesa = Herramienta "Llave francesa" 1 "hierro"

modificarPrecio :: Int -> Herramienta -> Herramienta
modificarPrecio agregar unaHerramienta = unaHerramienta{precio = precio unaHerramienta + agregar}

infinitasLlavesF :: [Herramienta]
infinitasLlavesF = map (`modificarPrecio` llaveFrancesa) [1..]

tieneHerramienta :: Herramienta -> Plomero -> Bool
tieneHerramienta unaHerramienta unPlomero = elem unaHerramienta (caja unPlomero)

esMalo :: Plomero -> Bool
esMalo unPlomero = take 2 (nombre unPlomero) == "Wa"

puedeComprarHerramienta :: Herramienta -> Plomero -> Bool
puedeComprarHerramienta unaHerramienta unPlomero = precio unaHerramienta <= dinero unPlomero

esLoDeseado :: String -> (Herramienta->[Char]) -> Herramienta -> Bool
esLoDeseado laHerramienta campo unaHerramienta = laHerramienta == campo unaHerramienta

esBuena :: Herramienta -> Bool
esBuena unaHerramienta = esLoDeseado "hierro" material unaHerramienta || precio unaHerramienta> 10000 || (esLoDeseado "martillo" nombreHerramienta unaHerramienta && 
    (esLoDeseado "goma" material unaHerramienta || esLoDeseado "madera" material unaHerramienta))

modificarHerramientas :: ([Herramienta]-> [Herramienta]) -> Plomero -> Plomero
modificarHerramientas modificador unPlomero = unPlomero{caja = modificador (caja unPlomero)}

modificarDinero :: (Int->Int)-> Plomero -> Plomero
modificarDinero modificador unPlomero = unPlomero {dinero = modificador (dinero unPlomero)}

comprarHerramienta :: Herramienta -> Plomero -> Plomero
comprarHerramienta unaHerramienta unPlomero
    | puedeComprarHerramienta unaHerramienta unPlomero = (modificarDinero(subtract(precio unaHerramienta)).modificarHerramientas(unaHerramienta:)) unPlomero
    | otherwise = unPlomero

filtracionAgua :: Reparacion
filtracionAgua = Reparacion "filtracion de agua" (tieneHerramienta llaveInglesa)

esDificil :: Reparacion -> Bool
esDificil unaReparacion = all isUpper (descripcion unaReparacion) && length(descripcion unaReparacion)>100

modificarHistorial :: ([Reparacion]->[Reparacion]) -> Plomero -> Plomero
modificarHistorial modificador unPlomero = unPlomero{historial = modificador (historial unPlomero)}

presupuesto :: Reparacion -> Int
presupuesto = (3*).length.descripcion

hacerReparacion :: Plomero ->Reparacion -> Plomero
hacerReparacion unPlomero unaReparacion
    | requerimiento unaReparacion unPlomero && esMalo unPlomero = (modificarDinero(+presupuesto unaReparacion).modificarHerramientas (llaveFrancesa:))unPlomero
    | requerimiento unaReparacion unPlomero && (not.esMalo) unPlomero && esDificil unaReparacion = (modificarDinero(+presupuesto unaReparacion).modificarHerramientas (filter (not.esBuena))) unPlomero
    | requerimiento unaReparacion unPlomero && (not.esMalo) unPlomero && (not.esDificil) unaReparacion  = (modificarDinero(+presupuesto unaReparacion).modificarHerramientas(drop 1)) unPlomero
    | otherwise = modificarDinero (+100) unPlomero

jornadaDeTrabajo :: [Reparacion] -> Plomero -> Int
jornadaDeTrabajo reparaciones unPlomero = (dinero.foldl hacerReparacion unPlomero) reparaciones

elMas :: (Eq a, Ord a) => [Plomero] -> (Plomero -> a) -> Plomero
elMas [] _ = error "lista vacia"
elMas [x] _ = x
elMas (x:y:xs) criterio 
    | criterio x > criterio y = elMas (x:xs) criterio
    | otherwise = elMas (y:xs) criterio

