import Text.Show.Functions

data Auto = UnAuto{
    marca :: String,
    modelo :: Modelo,
    desgaste :: Desgaste,
    velocidadMax :: Float,
    tiempoDeCarrera :: Float
} deriving Show
modificarTiempoDeCarrera :: (Float->Float) -> Auto -> Auto
modificarTiempoDeCarrera unaFuncion unAuto = unAuto {tiempoDeCarrera = unaFuncion.tiempoDeCarrera $ unAuto}

type Modelo = String
type Desgaste = (Ruedas,Chasis)
type Ruedas = Float
type Chasis = Float

desgasteRuedas :: Desgaste -> Ruedas
desgasteRuedas unAuto = fst unAuto
desgasteChasis :: Desgaste -> Chasis
desgasteChasis unAuto = snd unAuto

ferrari :: Auto
ferrari = UnAuto "Ferrari" "F50" (0,0) 65 0

lamborghini :: Auto
lamborghini = UnAuto "Lamborghini" "Diablo" (4,7) 73 0

fiat :: Auto
fiat = UnAuto "Fiat" "600" (27,33) 44 0

type Estado = Auto -> Bool

estaEnBuenEstado :: Estado
estaEnBuenEstado unAuto = desgasteChasis (desgaste unAuto) < 40 && desgasteRuedas (desgaste unAuto) < 60

noDaMas :: Estado
noDaMas unAuto = desgasteChasis (desgaste unAuto) > 80 || desgasteRuedas (desgaste unAuto) > 80

modificarDesgaste :: (Float -> Float) -> (Float -> Float) -> Auto -> Auto
modificarDesgaste unaFuncion otraFuncion unAuto = unAuto {desgaste = (unaFuncion.desgasteRuedas.desgaste $ unAuto, otraFuncion.desgasteChasis.desgaste $ unAuto)}
-- si quiero modificar solo uno, puedo hacerlo así por ejemplo: modificarDesgaste (+0) (id) unAuto (o const 0 en vez de id)
modificarDesgasteRuedas:: (Float->Float) -> Auto -> Auto
modificarDesgasteRuedas unaFuncion unAuto = unAuto {desgaste = (unaFuncion.desgasteRuedas.desgaste $ unAuto, desgasteChasis (desgaste unAuto))}

modificarDesgasteChasis :: (Float->Float) -> Auto -> Auto
modificarDesgasteChasis unaFuncion unAuto = unAuto {desgaste = (desgasteRuedas (desgaste unAuto),unaFuncion.desgasteChasis.desgaste $ unAuto )}

reparar :: Auto -> Auto
reparar unAuto =  modificarDesgasteChasis (*0.15).modificarDesgasteRuedas (const 0) $ unAuto

type Curva = (Angulo, Longitud)

angulo :: Curva -> Angulo
angulo unaCurva = fst unaCurva
longCurva :: Curva -> Longitud
longCurva unaCurva = snd unaCurva

type Angulo = Float
type Longitud = Float
type Recta = Longitud
type Box = (Longitud,Tiempo)
type Tiempo = Float

type Tramo = Auto -> Auto

curva :: Curva -> Tramo
curva unaCurva unAuto = modificarDesgasteRuedas (+(danioCurva (angulo unaCurva) (longCurva unaCurva))).modificarTiempoDeCarrera (+ (longCurva unaCurva / (velocidadMax unAuto*0.5))) $ unAuto

curvaPeligrosa :: Tramo
curvaPeligrosa = curva (60,300)
curvaTranca :: Tramo
curvaTranca = curva (110,550)

danioCurva :: Float -> Float -> Float
danioCurva angulo longitud = 3*(angulo/longitud)

recta :: Recta -> Tramo
recta longitudRecta unAuto= modificarDesgasteChasis (subtract (longitudRecta/100)).modificarTiempoDeCarrera (+ (longitudRecta/velocidadMax unAuto)) $ unAuto

tramoRecto :: Tramo
tramoRecto = recta 750

tramito :: Tramo
tramito = recta 280

tiempoDeUnTramo :: Tramo -> Auto -> Float
tiempoDeUnTramo unTramo unAuto = tiempoDeCarrera (unTramo unAuto) - tiempoDeCarrera unAuto

boxes :: Tramo -> Tramo
boxes unTramo unAuto 
  | estaEnBuenEstado unAuto = unTramo unAuto
  | otherwise = modificarTiempoDeCarrera (+tiempoDeUnTramo unTramo unAuto) . reparar $ unAuto

pasarPorTramo :: Tramo -> Auto -> Auto
pasarPorTramo unTramo unAuto
  | noDaMas unAuto = unAuto
  | otherwise = unTramo unAuto

tramoMojado :: Tramo -> Tramo
tramoMojado unTramo unAuto = modificarTiempoDeCarrera (+(tiempoDeUnTramo unTramo unAuto/ 2)) unAuto

tramoRipio :: Tramo -> Tramo
tramoRipio unTramo unAuto = modificarTiempoDeCarrera ((+2 * tiempoDeUnTramo unTramo unAuto)) . unTramo . unTramo $ unAuto 

tramoConObstruccion :: Tramo -> Float -> Tramo
tramoConObstruccion unTramo metrosOcupados = unTramo . modificarDesgasteRuedas (subtract (2 * metrosOcupados))

type Pista = [Tramo]

peganLaVuelta :: Pista -> [Auto] -> [Auto]
peganLaVuelta unaPista unosAutos = filter noDaMas.map (danLaVuelta unaPista) $ unosAutos

danLaVuelta :: Pista -> Auto -> Auto
danLaVuelta unaPista unAuto = foldr ($) unAuto unaPista


data Carrera = UnaCarrera{
    vueltas :: Int,
    pistaCarrera :: Pista
}

--tourBuenosAires :: Carrera
--tourBuenosAires = 20 superPista

{-jugarUnaCarrerra :: Carrera -> [Auto] -> [Auto]
jugarUnaCarrerra unaCarrera = take (vueltas unaCarrera) . vanCorriendoVueltas (pistaCarrera unaCarrera) 


vanCorriendoVueltas :: Pista -> [Auto] -> [Auto]
vanCorriendoVueltas unaPista = iterate (danLaVuelta unaPista) -}