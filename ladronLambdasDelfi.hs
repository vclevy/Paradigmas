{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions
import Data.Char(isUpper,isDigit,toUpper)

data Tesoro = Tesoro {
    anio :: Float,
    precio :: Float
}deriving (Show)

modificarPrecio :: (Float->Float) -> Tesoro -> Tesoro
modificarPrecio modificador unTesoro = unTesoro {precio = modificador (precio unTesoro)}

antiguedad :: Tesoro -> Float
antiguedad unTesoro = 2024.0 - anio unTesoro

compararValor :: (Float -> Bool) -> Float -> Bool
compararValor comparador valor = comparador valor

tesoroDeLujo :: Tesoro -> Bool
tesoroDeLujo unTesoro = compararValor (> 1000)(precio unTesoro)|| compararValor (> 200) (antiguedad unTesoro) 

telaSucia :: Tesoro -> Bool
telaSucia unTesoro = compararValor (<50)(precio unTesoro) || (not.tesoroDeLujo) unTesoro

estandar :: Tesoro -> Bool
estandar unTesoro = (not.telaSucia) unTesoro && (not.tesoroDeLujo) unTesoro

valorTesoro :: Tesoro -> Float
valorTesoro unTesoro = precio unTesoro + 2* antiguedad unTesoro

--Parte 2 

type Clave = [Char]
type Herramienta = Clave -> Clave

martillo :: Herramienta
martillo  = drop 3 

llaveMaestra :: Herramienta
llaveMaestra _ = []

efectoGanzua :: Herramienta
efectoGanzua  = drop 1 

ganzuaGancho :: Herramienta
ganzuaGancho unaClave = filter (not.isUpper) (efectoGanzua unaClave)

ganzuaRastrillo :: Herramienta
ganzuaRastrillo unaClave = filter (not.isDigit) (efectoGanzua unaClave)

ganzuaRombo :: Clave -> Herramienta
ganzuaRombo inscripcion  = filter (not.tieneLetra inscripcion) 

tieneLetra :: Clave -> Char -> Bool
tieneLetra unaClave unaLetra = elem unaLetra unaClave

tensor :: Herramienta
tensor = map toUpper 

socotroco :: Herramienta -> Herramienta -> Herramienta
socotroco unaHerramienta otraHerramienta  = otraHerramienta.unaHerramienta 

--Parte 3

data Ladron = Ladron {
    nombre :: String,
    herramientas :: [Herramienta],
    tesorosRobados :: [Tesoro]
}deriving (Show)

data Cofre = Cofre {
    cerradura :: Clave,
    suTesoro :: Tesoro
}deriving (Show)

experiencia :: Ladron -> Float
experiencia unLadron = sum (map valorTesoro (tesorosRobados unLadron))

ladronLegendario :: Ladron -> Bool
ladronLegendario unLadron = compararValor (>100) (experiencia unLadron) && all tesoroDeLujo (tesorosRobados unLadron)

modificarHerramientas :: [Herramienta] -> Ladron -> Ladron
modificarHerramientas nuevas unLadron = unLadron{herramientas = nuevas}

modificarTesoros :: ([Tesoro]-> [Tesoro]) -> Ladron -> Ladron
modificarTesoros modificador unLadron = unLadron{tesorosRobados = modificador (tesorosRobados unLadron)}

usarHerramientas :: Cofre -> [Herramienta] -> [Herramienta]
usarHerramientas _ [] = []
usarHerramientas unCofre (h:hs)
    | abre h unCofre = hs
    | otherwise = usarHerramientas unCofre hs

abre :: Herramienta -> Cofre -> Bool
abre unaHerramienta unCofre = (null.unaHerramienta) (cerradura unCofre)

laUltimaAbre :: Cofre -> [Herramienta] -> Bool
laUltimaAbre unCofre herramientas = abre (last herramientas) unCofre

robarCofre :: Ladron -> Cofre -> Ladron
robarCofre unLadron unCofre 
    | laUltimaAbre unCofre (herramientas unLadron) || (not.null)(usarHerramientas unCofre (herramientas unLadron)) = 
        (modificarTesoros (++[suTesoro unCofre]).modificarHerramientas (usarHerramientas unCofre (herramientas unLadron))) unLadron
    | otherwise = modificarHerramientas [] unLadron

manu :: Ladron
manu = Ladron "manu" [martillo,ganzuaGancho, ganzuaRastrillo] []

cofre1 :: Cofre
cofre1 = Cofre "qwERTY" tesorito

packManu :: [Herramienta]
packManu = [martillo,ganzuaGancho, ganzuaRastrillo]

tesorito :: Tesoro
tesorito = Tesoro 1900 900

atraco :: Ladron -> [Cofre] -> Ladron
atraco unLadron cofres = foldl robarCofre unLadron cofres

{-
>> atraco lucas (cycle cofre)
nunca terminaria de atracar, entonces no podria agregar todos los cofres a la lista de cofres robados
por ende no devuelve nada la funcion

un atraco de un ladron que entre sus herramientas tenga la llaveMaestra a un confre con clave 
infinita porque sin importar lo que tenga la clave la llaveMaestra lo abre
-}