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
martillo unaClave = drop 3 unaClave

llaveMaestra :: Herramienta
llaveMaestra _ = []

efectoGanzua :: Herramienta
efectoGanzua unaClave = drop 1 unaClave

ganzuaGancho :: Herramienta
ganzuaGancho unaClave = filter (not.isUpper) (efectoGanzua unaClave)

ganzuaRastrillo :: Herramienta
ganzuaRastrillo unaClave = filter (not.isDigit) (efectoGanzua unaClave)

ganzuaRombo :: Clave -> Herramienta
ganzuaRombo inscripcion unaClave = filter (not.tieneLetra inscripcion) unaClave

tieneLetra :: Clave -> Char -> Bool
tieneLetra unaClave unaLetra = elem unaLetra unaClave

tensor :: Herramienta
tensor unaClave = map toUpper unaClave

socotroco :: Herramienta -> Herramienta -> Herramienta
socotroco unaHerramienta otraHerramienta unaClave = (otraHerramienta.unaHerramienta) unaClave

--Parte 3