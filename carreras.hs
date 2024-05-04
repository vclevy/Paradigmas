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
yoshi = UnAuto "verde" 200 5000

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
bajarVelocidad unAuto ciertaVelocidad = unAuto {velocidad = alterarLaVelocidad unAuto (restar ciertaVelocidad)}

restar :: Int -> Int -> Int
restar x y = x - y
