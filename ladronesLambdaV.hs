import Text.Show.Functions
import Data.Char

data Tesoro = UnTesoro{
    anioDeDescubrimiento :: Int,
    precio :: Precio
} deriving (Show)

tesorito = UnTesoro 1000 100

type Precio = Int

type Tipo = Tesoro -> Bool

deLujo :: Tipo
deLujo unTesoro = precio unTesoro > 1000 || antiguedad unTesoro > 200

antiguedad :: Tesoro -> Int
antiguedad unTesoro = (`subtract` 2024).anioDeDescubrimiento $ unTesoro

telaSucia :: Tipo
telaSucia unTesoro = (not.deLujo $ unTesoro) && precio unTesoro < 50

estandar :: Tipo
estandar unTesoro = (not.deLujo) unTesoro && (not.telaSucia) unTesoro

valorDeTesoro :: Tesoro -> Int
valorDeTesoro unTesoro = ((*2).precio) unTesoro + antiguedad unTesoro

type Cerradura = String

estaAbierta :: Cerradura -> Bool
--estaAbierta unaCerradura = length unaCerradura == 0
estaAbierta [] = True
estaAbierta _ = False

type Herramienta = Cerradura -> Cerradura

modificarCerradura :: (Cerradura -> Cerradura) -> Cerradura -> Cerradura
modificarCerradura unaFuncion unaCerradura = unaFuncion unaCerradura

martillo :: Herramienta
martillo unaCerradura = modificarCerradura (drop 3) unaCerradura

llaveMaestra :: Herramienta
llaveMaestra unaCerradura = modificarCerradura (take 0) unaCerradura

ganzua :: String -> String -> Herramienta
ganzua "gancho" _ unaCerradura = modificarCerradura (filter (not.isUpper)) unaCerradura
ganzua "rastrillo" _ unaCerradura = modificarCerradura (filter (not.isDigit)) unaCerradura
ganzua "rombo" unaInscripcion unaCerradura = modificarCerradura (filter (distintosALaInscripcion unaInscripcion)) unaCerradura

distintosALaInscripcion :: String -> Char -> Bool
distintosALaInscripcion unaInscripcion unaLetra = not (elem unaLetra unaInscripcion)

tensor :: Herramienta
tensor unaCerradura = modificarCerradura (map toUpper) unaCerradura

socotroco :: Herramienta
socotroco = tensor.llaveMaestra

data Ladron = UnLadron{
    nombre :: String,
    herramientas :: [Herramienta],
    tesorosRobados :: [Tesoro]
} deriving (Show)

modificarHerramientas :: ([Herramienta]->[Herramienta]) -> Ladron -> Ladron
modificarHerramientas unaFuncion unLadron = unLadron {herramientas = unaFuncion.herramientas $ unLadron}

modificarTesoros :: ([Tesoro]->[Tesoro]) -> Ladron -> Ladron
modificarTesoros unaFuncion unLadron = unLadron {tesorosRobados = unaFuncion.tesorosRobados $ unLadron}

data Cofre = UnCofre {
    cerradura :: Cerradura,
    tesoro :: Tesoro
} deriving (Show)

esLegendario :: Ladron -> Bool
esLegendario unLadron = experiencia unLadron > 100 && all deLujo (tesorosRobados unLadron)

experiencia :: Ladron -> Int
experiencia unLadron = sum (map valorDeTesoro.tesorosRobados $ unLadron)

robarCofre :: Ladron -> Cofre -> Ladron
robarCofre unLadron unCofre 
 | estaAbierta (usarHerramientasEnCerradura unLadron unCofre) = modificarTesoros ((tesoro unCofre):) unLadron
 | otherwise =  modificarHerramientas (take 0) unLadron

usarHerramientasEnCerradura :: Ladron -> Cofre -> Cerradura
usarHerramientasEnCerradura unLadron unCofre = foldr ($) (cerradura unCofre) (herramientas unLadron)


