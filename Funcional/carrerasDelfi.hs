{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Hoist not" #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions

data Auto = Auto{
    color :: Color,
    velocidad :: Int,
    distanciaRecorrida :: Int
}deriving (Show,Eq)

type Color = String
type Carrera = [Auto]

-- Punto 1

distanciaMenorA :: Int-> Auto -> Auto -> Bool
distanciaMenorA n unAuto otroAuto = n > abs (distanciaRecorrida unAuto - distanciaRecorrida otroAuto)

estaCerca :: Auto -> Auto -> Bool
estaCerca unAuto otroAuto = unAuto /= otroAuto && distanciaMenorA 10 unAuto otroAuto

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo unAuto unaCarrera = all (not.estaCerca unAuto) unaCarrera && all (leVaGanando unAuto) unaCarrera

leVaGanando :: Auto -> Auto -> Bool
leVaGanando unAuto otroAuto = distanciaRecorrida unAuto > distanciaRecorrida otroAuto

puesto :: Auto -> Carrera -> Int
puesto unAuto = (+1).length.filter (not.leVaGanando unAuto)

--Punto 2

modificarDistancia :: (Int-> Int) -> Auto -> Auto
modificarDistancia modificador unAuto = unAuto{distanciaRecorrida = (modificador.distanciaRecorrida) unAuto}

corra :: Int -> Auto -> Auto
corra tiempo unAuto = modificarDistancia (+ tiempo * velocidad unAuto) unAuto

modificarVelocidad :: (Int-> Int) -> Auto -> Auto
modificarVelocidad modificador unAuto = unAuto{velocidad = (modificador.velocidad) unAuto}

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad restar unAuto = modificarVelocidad (subtract (max 0 (velocidad unAuto - restar))) unAuto

-- Punto 3

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

type PowerUp = Auto -> Carrera -> Carrera

terremoto ::PowerUp
terremoto unAuto = afectarALosQueCumplen (estaCerca unAuto) (bajarVelocidad 50)

miguelito :: Int -> PowerUp
miguelito vel unAuto = afectarALosQueCumplen (leVaGanando unAuto) (bajarVelocidad vel)

jetPack :: Int -> PowerUp
jetPack tiempo unAuto = afectarALosQueCumplen (== unAuto) (modificarVelocidad (subtract (velocidad unAuto)).corra tiempo.modificarVelocidad (*2))

type Evento = Carrera -> Carrera

--  auto de ejemplo
autoNegro :: Auto
autoNegro = Auto {
    color = "Negro",
    velocidad = 120,
    distanciaRecorrida = 0
}
autoBlanco :: Auto
autoBlanco = Auto {
    color = "Blanco",
    velocidad = 120,
    distanciaRecorrida = 0
}

autoAzul :: Auto
autoAzul = Auto {
    color = "Azul",
    velocidad = 120,
    distanciaRecorrida = 0
}


-- Punto 4

correnTodos :: Int -> Carrera -> Carrera
correnTodos tiempo = map (corra tiempo)
    
usaPowerUp :: PowerUp -> Color -> Evento
usaPowerUp powerUp colorBuscado carrera = powerUp (autoQueGatillaElPoder colorBuscado carrera) carrera
    
autoQueGatillaElPoder :: Color -> Carrera -> Auto
autoQueGatillaElPoder colorBuscado carrera = (head.filter ((== colorBuscado).color)) carrera

simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera unaCarrera eventos = map (composicionTabla unaCarrera) (procesar eventos unaCarrera)

procesar :: [Evento] -> Evento
procesar eventos unaCarrera = foldl (flip ($)) unaCarrera eventos

composicionTabla :: Carrera-> Auto -> (Int, Color)
composicionTabla unaCarrera unAuto = (puesto unAuto unaCarrera, color unAuto)

eventosLaCarrera :: [Evento]
eventosLaCarrera = [correnTodos 30,usaPowerUp (jetPack 3) "azul",usaPowerUp terremoto "blanco",correnTodos 40, usaPowerUp (miguelito 20) "blanco",usaPowerUp (jetPack 3) "negro",correnTodos 10]

carreraPrueba :: Carrera
carreraPrueba = [autoAzul,autoBlanco,autoNegro]

--Punto 5


{-Se puede agregar sin problemas como una función más misilTeledirigido :: Color -> PowerUp, y usarlo como:
usaPowerUp (misilTeledirigido "rojo") "azul" :: Eventos-}

{-vaTranquilo puede terminar sólo si el auto indicado no va tranquilo
(en este caso por tener a alguien cerca, si las condiciones estuvieran al revés, 
terminaría si se encuentra alguno al que no le gana).
Esto es gracias a la evaluación perezosa, any es capaz de retornar True si se encuentra alguno que cumpla 
la condición indicada, y all es capaz de retornar False si alguno no cumple la condición correspondiente. 
Sin embargo, no podría terminar si se tratara de un auto que va tranquilo.

- puesto no puede terminar nunca porque hace falta saber cuántos le van ganando, entonces por más 
que se pueda tratar de filtrar el conjunto de autos, nunca se llegaría al final para calcular la longitud.-}
