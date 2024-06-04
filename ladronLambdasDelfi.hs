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

martillo :: Clave -> Clave
martillo unaClave = drop 3 unaClave

llaveMaestra :: Clave -> Clave
llaveMaestra _ = []

efectoGanzua :: Clave -> Clave
efectoGanzua unaClave = drop 1 unaClave

ganzuaGancho :: Clave -> Clave
ganzuaGancho unaClave = filter (not.isUpper) (efectoGanzua unaClave)

ganzuaRastrillo :: Clave -> Clave
ganzuaRastrillo unaClave = filter (not.isDigit) (efectoGanzua unaClave)

ganzuaRombo :: Clave -> Clave -> Clave
ganzuaRombo inscripcion unaClave = filter (not.tieneLetra inscripcion) unaClave

tieneLetra :: Clave -> Char -> Bool
tieneLetra unaClave unaLetra = elem unaLetra unaClave