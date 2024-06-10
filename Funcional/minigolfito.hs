{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
import Text.Show.Functions
-- Modelo inicial

data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

type Palo = Jugador -> Tiro

putter :: Palo
putter unJugador = UnTiro{velocidad=10, precision =((2*).precisionJugador) (habilidad unJugador), altura = 0}

madera :: Palo
madera unJugador = UnTiro{velocidad=100, precision =((0.5*).precisionJugador) (habilidad unJugador), altura = 5}

hierros :: Int->Palo
hierros n unJugador = UnTiro{velocidad=((n*).fuerzaJugador) (habilidad unJugador), precision =(((1/n)*).precisionJugador) (habilidad unJugador), altura = hastaCero n 3}

hastaCero :: Int -> Int -> Int
hastaCero unNumero otroNumero
    | unNumero - otroNumero<0 = 0
    |otherwise = unNumero - otroNumero

palos = [putter, madera] ++ map hierros [1..10]

golpe :: Jugador -> Palo -> Tiro
golpe unJugador unPalo = unPalo unJugador

type Obstaculo = Tiro -> Bool

condicionTunelConRampita :: Obstaculo
condicionTunelConRampita unTiro = precision unTiro >90 && altura unTiro == 0 
efectoTunelConRampita :: Tiro -> Tiro
efectoTunelConRampita unTiro = UnTiro{velocidad = ((2*).velocidad) unTiro,precision = 100, altura=0} 
tunelConRampita :: Tiro -> Tiro
tunelConRampita unTiro = superableSi condicionTunelConRampita unTiro efectoTunelConRampita

condicionLaguna :: Int -> Obstaculo
condicionLaguna largo unTiro =velocidad unTiro >80 && between (altura unTiro) 1 5 
efectoLaguna :: Int -> Tiro -> Tiro
efectoLaguna largo unTiro = UnTiro{altura= altura unTiro/largo}
laguna :: Int -> Tiro -> Tiro
laguna largo unTiro = superableSi (condicionLaguna largo) unTiro (efectoLaguna largo)

condicionHoyo :: Obstaculo
condicionHoyo unTiro = between (velocidad unTiro) 5 20 && altura unTiro == 0 && precision unTiro>95 -- = tiroNulo
efectoHoyo :: Tiro -> Tiro
efectoHoyo unTiro = tiroNulo
tiroNulo = UnTiro 0 0 0
hoyo :: Tiro -> Tiro
hoyo unTiro = superableSi condicionHoyo unTiro efectoHoyo

superableSi :: Obstaculo -> Tiro -> (Tiro -> Tiro) -> Tiro
superableSi condicion unTiro efecto 
  | condicion unTiro = efecto unTiro
  | otherwise = tiroNulo

palosUtiles :: Jugador -> Obstaculo -> [Palo]
palosUtiles unJugador unObstaculo = filter unObstaculo (map (golpe unJugador) palos )

obstaculosConsecutivos :: [Obstaculo] -> Tiro -> [Obstaculo]
obstaculosConsecutivos losObstaculos unTiro = filter True (obstaculosConUnTiro losObstaculos unTiro)

obstaculosConUnTiro :: [Obstaculo]->Tiro-> [Obstaculo]
obstaculosConUnTiro obstaculos tiro = foldl (\tiro obstaculo-> obstaculo tiro) tiro obstaculos


