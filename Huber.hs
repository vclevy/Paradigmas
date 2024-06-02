import Text.Show.Functions

data Chofer = UnChofer{
    nombre :: String,
    viajes :: [Viaje],
    kilometraje :: Int,
    condicion :: Condicion
} deriving (Show)

data Viaje = UnViaje{
    fecha :: Fecha,
    cliente :: Cliente,
    costo :: Int
} deriving (Show)

type Fecha = (Int,Int,Int)
type Cliente = (Nombre,Direccion)

modificarViaje :: ([Viaje]->[Viaje]) -> Chofer -> Chofer
modificarViaje unaFuncion unChofer = unChofer {viajes = unaFuncion.viajes $ unChofer}
nombreCliente :: Cliente->String
nombreCliente unCliente = fst unCliente

direccionCliente :: Cliente->String
direccionCliente unCliente = snd unCliente

type Direccion = String
type Nombre = String
type Condicion = Viaje->Bool

tomaCualquierViaje ::  Condicion
tomaCualquierViaje _ = True

saleMasDe :: Int -> Condicion
saleMasDe unCosto = mayorQueUnParametro costo unCosto

masDeNLetras :: Int -> Condicion
masDeNLetras unNumero = mayorQueUnParametro (length.nombreCliente.cliente) unNumero 

mayorQueUnParametro :: (Viaje->Int) -> Int -> Condicion
mayorQueUnParametro unModificador unParametro unViaje = unModificador unViaje > unParametro

noViveEn :: String -> Condicion
noViveEn unaDireccion unViaje = direccionCliente (cliente unViaje) /= unaDireccion

{-noViveEn unaDireccion unViaje = not.viveEn unaDireccion $ (cliente unViaje)
viveEn :: String -> Cliente -> Bool
viveEn unaDireccion unCliente = direccionCliente unCliente == unaDireccion-}

lucas :: Cliente
lucas = ("Lucas","Victoria")

daniel :: Chofer
daniel = UnChofer "Daniel" [viajeLucas] 23500 (noViveEn "Olivos")

viajeLucas :: Viaje
viajeLucas = UnViaje (20,04,2017) lucas 150

alejandra :: Chofer
alejandra = UnChofer "Alejandra" [] 180000 tomaCualquierViaje

puedeTomarElViaje :: Viaje -> Chofer -> Bool
puedeTomarElViaje unViaje unChofer = (condicion unChofer) unViaje

liquidacionDeChofer :: Chofer -> Int
liquidacionDeChofer = sum.map costo.viajes

realizarUnViaje :: Viaje -> [Chofer] -> Chofer
realizarUnViaje unViaje unosChoferes= efectuarViaje unViaje.menosViaje.choferesInteresados unViaje $ unosChoferes

choferesInteresados :: Viaje -> [Chofer] -> [Chofer]
choferesInteresados unViaje = filter (puedeTomarElViaje unViaje)

menosViaje :: [Chofer] -> Chofer
menosViaje [unChofer] = unChofer
menosViaje (unChofer:otrosChoferes) = minimoKilometraje unChofer (menosViaje (otrosChoferes))

minimoKilometraje :: Chofer -> Chofer -> Chofer
minimoKilometraje unChofer otroChofer 
    | kilometraje unChofer < kilometraje otroChofer = unChofer
    | otherwise = otroChofer

efectuarViaje :: Viaje -> Chofer -> Chofer
efectuarViaje unViaje = modificarViaje (unViaje :) 

nitoInfy :: Chofer
nitoInfy = UnChofer "Nito Infy" infinitosViajesLucasPor50 70000 (masDeNLetras 3)

viajesLucasPor50 :: Viaje
viajesLucasPor50 = UnViaje (20,04,2017) lucas 50

infinitosViajesLucasPor50 :: [Viaje]
infinitosViajesLucasPor50 = repeat viajesLucasPor50

-- B- no puede, porque la lista nunca termina de evaluarse
-- C- sí puede pq no recorre la lista, y lucas tiene mas de 3 letras
