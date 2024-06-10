import Text.Show.Functions

data Auto = UnAuto {
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show, Eq)

type Carrera = [Auto]

mario:: Auto
mario = UnAuto "Rojo" 300 10000

yoshi:: Auto
yoshi = UnAuto "verde" 200 9999

princesaPeach:: Auto 
princesaPeach = UnAuto "Rosa" 150 6000

copaPiston :: Carrera
copaPiston = [mario, yoshi, princesaPeach]

estaCerca :: Auto -> Auto -> Bool
estaCerca unAuto otroAuto = unAuto /= otroAuto && ((<10).distanciaEntreAutos unAuto) otroAuto

distanciaEntreAutos :: Auto -> Auto -> Int
distanciaEntreAutos unAuto otroAuto = abs (distancia otroAuto - distancia unAuto)

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo unAuto unaCarrera = all (not.estaCerca unAuto) unaCarrera && maximum (map distancia unaCarrera) == distancia unAuto

{- autosPorDelante :: Auto -> Auto -> Bool
autosPorDelante unAuto otroAuto = distancia otroAuto > distancia unAuto
listaDeCantidadDeAutosPorDelante :: Auto -> Carrera -> [Auto]
listaDeCantidadDeAutosPorDelante unAuto unaCarrera = filter (autosPorDelante unAuto) unaCarrera 
puestoEnLaCarrera :: Auto -> Carrera -> Int
puestoEnLaCarrera unAuto unaCarrera = length (listaDeCantidadDeAutosPorDelante unAuto unaCarrera) +1 -}

puestoEnLaCarrera :: Auto -> Carrera -> Int
puestoEnLaCarrera unAuto unaCarrera = length (filter (>distancia unAuto) (map distancia unaCarrera)) +1

queCorraUnAuto :: Auto -> Int -> Auto
queCorraUnAuto unAuto tiempo = unAuto {distancia = distancia unAuto + (tiempo * velocidad unAuto)}

alterarLaVelocidad :: Auto -> (Int -> Int) -> Auto
alterarLaVelocidad unAuto unModificador = unAuto {velocidad = unModificador (velocidad unAuto)}

bajarVelocidad :: Auto -> Int -> Auto
bajarVelocidad unAuto ciertaVelocidad = unAuto { velocidad = max (velocidad (alterarLaVelocidad unAuto (flip (-) ciertaVelocidad))) 0 }

afectarALosQueCumplen :: (Auto -> Bool) -> (Auto -> Auto) -> Carrera -> Carrera
afectarALosQueCumplen criterio efecto lista = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

terremoto :: Auto -> Carrera -> Carrera
terremoto unAuto unaCarrera = afectarALosQueCumplen (estaCerca unAuto) (`bajarVelocidad`50) unaCarrera

estaDetrasDeUnAuto :: Auto -> Carrera -> Auto -> Bool
estaDetrasDeUnAuto unAuto unaCarrera otroAuto = puestoEnLaCarrera otroAuto unaCarrera < puestoEnLaCarrera unAuto unaCarrera

miguelito :: Auto -> Int -> Carrera -> Carrera
miguelito unAuto unValor unaCarrera = afectarALosQueCumplen (estaDetrasDeUnAuto unAuto unaCarrera) (`bajarVelocidad`unValor) unaCarrera
-- MIGUELITO NO ANDA TAN BIEN COMO DEBERIA (el puto de miguelito)

jetPack :: Auto -> Int -> Auto
jetPack unAuto unTiempo = unAuto {distancia = distancia (queCorraUnAuto (alterarLaVelocidad unAuto (*2)) unTiempo)}



