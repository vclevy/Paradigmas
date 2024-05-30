import Text.Show.Functions

data Ninja = UnNinja {
    nombre :: String,
    herramientas :: [Herramienta],
    jutsus :: [Jutsu],
    rango :: Int
} deriving (Show)

type Jutsu = Mision -> Mision
type Herramienta = (String, Cantidad)
type Cantidad = Int

--accesores a la tupla Herramienta
nombreHerramienta :: Herramienta -> String
nombreHerramienta (nombre, _) = nombre
cantidadHerramienta :: Herramienta -> Int
cantidadHerramienta (_, cantidad) = cantidad

modificarHerramientas :: ([Herramienta]->[Herramienta]) -> Ninja -> Ninja
modificarHerramientas unaFuncion unNinja = unNinja {herramientas= unaFuncion.herramientas $ unNinja}

obtenerHerramienta :: Herramienta -> Ninja -> Ninja
obtenerHerramienta unaHerramienta unNinja
 | sumaDeHerramientas unNinja + cantidadHerramienta unaHerramienta <=100 = modificarHerramientas (++ [unaHerramienta]) unNinja
 | otherwise = modificarHerramientas (++ [herramientaSinExcederse unaHerramienta unNinja]) unNinja

herramientaSinExcederse :: Herramienta -> Ninja -> Herramienta
herramientaSinExcederse unaHerramienta unNinja = (nombreHerramienta unaHerramienta, max (100-sumaDeHerramientas unNinja) 0)

sumaDeHerramientas :: Ninja -> Int
sumaDeHerramientas unNinja = sum (map cantidadHerramienta (herramientas unNinja))

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta unaHerramienta = modificarHerramientas (filter (/= unaHerramienta)) -- point free

data Mision = UnaMision {
    cantidadDeNinjas :: Int,
    rangoRecomendable :: Int,
    enemigosADerrotar :: [Enemigo],
    recompensa :: Herramienta
} deriving (Show)

type Enemigo = Ninja
misionHola :: Mision
misionHola = UnaMision 3 2 [] ("Kunai", 14)

type Equipo = [Ninja]

esDesafiante ::  Mision -> Equipo -> Bool
esDesafiante unaMision unEquipo = algunoTieneMenorRangoDelRecomendado unaMision unEquipo && cantidadDeEnemigosADerrotar unaMision == 2

algunoTieneMenorRangoDelRecomendado :: Mision -> Equipo -> Bool
algunoTieneMenorRangoDelRecomendado unaMision unEquipo = any (>= (rangoRecomendable unaMision)) (map rango unEquipo)

cantidadDeEnemigosADerrotar :: Mision -> Int
cantidadDeEnemigosADerrotar unaMision = length (enemigosADerrotar unaMision)

esCopada :: Mision -> Bool
esCopada unaMision = elem (recompensa unaMision) recompensasCopadas 

recompensasCopadas :: [Herramienta]
recompensasCopadas = [("Bomba de humo", 3),("Shuriken", 5),("Kunai",14)]

esFactible :: Equipo -> Mision -> Bool
esFactible unEquipo unaMision = (not.esDesafiante unaMision) unEquipo && estanBienPreparados unEquipo unaMision

estanBienPreparados :: Equipo -> Mision -> Bool
estanBienPreparados unEquipo unaMision= estanBienArmados unEquipo || cuentanConLaCantidadDeNinjasNecesarios unEquipo unaMision

cuentanConLaCantidadDeNinjasNecesarios :: Equipo -> Mision -> Bool
cuentanConLaCantidadDeNinjasNecesarios unEquipo unaMision = length unEquipo >= cantidadDeNinjas unaMision

estanBienArmados :: Equipo -> Bool
estanBienArmados unEquipo = (>500).sumaDeHerramientasDelEquipo $ unEquipo

sumaDeHerramientasDelEquipo :: Equipo -> Int
sumaDeHerramientasDelEquipo unEquipo = sum (map sumaDeHerramientas unEquipo)

modificarRango :: (Int->Int) -> Ninja -> Ninja
modificarRango unaFuncion unNinja = unNinja {rango= unaFuncion.rango $ unNinja}

fallarMision :: Equipo -> Mision -> Equipo
fallarMision unEquipo unaMision = disminuirEn2RangoDeSobrevivientes (sobrevivientes unaMision unEquipo)

disminuirEn2RangoDeSobrevivientes :: Equipo -> Equipo
disminuirEn2RangoDeSobrevivientes = map (modificarRango (subtract 2)) -- point free

sobrevivientes :: Mision -> Equipo -> Equipo
sobrevivientes unaMision unEquipo = filter (\ninja -> rango ninja >= rangoRecomendable unaMision) unEquipo

cumplirMision :: Mision -> Equipo -> Equipo
cumplirMision unaMision unEquipo = darRecompensaAlEquipo unaMision.promocionarDeRango $ unEquipo

promocionarDeRango :: Equipo -> Equipo
promocionarDeRango = map (modificarRango (+1)) -- point free

darRecompensaAlEquipo :: Mision -> Equipo -> Equipo
darRecompensaAlEquipo unaMision unEquipo = map (obtenerHerramienta (recompensa unaMision)) unEquipo

modificarEnemigosDeMision :: ([Enemigo]->[Enemigo]) -> Mision -> Mision
modificarEnemigosDeMision unaFuncion unaMision = unaMision {enemigosADerrotar = unaFuncion.enemigosADerrotar $ unaMision}

modificarCantidadDeNinjasDeMision :: (Int->Int) -> Mision -> Mision
modificarCantidadDeNinjasDeMision unaFuncion unaMision = unaMision {cantidadDeNinjas = unaFuncion.cantidadDeNinjas $ unaMision}

clonesDeSombra :: Int -> Jutsu
clonesDeSombra clonesCreados = modificarCantidadDeNinjasDeMision (max 1.subtract clonesCreados) --point free

fuerzaDeUnCentenar :: Jutsu
fuerzaDeUnCentenar = modificarEnemigosDeMision (filter (\enemigo -> rango enemigo > 500)) --point free

ejecutarMision :: Equipo -> Mision -> Equipo
ejecutarMision unEquipo = completarMision unEquipo . usarTodosSusJutsus unEquipo

usarTodosSusJutsus :: Equipo -> Mision -> Mision
usarTodosSusJutsus unEquipo unaMision = foldr ($) unaMision . concatMap jutsus $ unEquipo

completarMision :: Equipo -> Mision -> Equipo
completarMision unEquipo unaMision
 | esCopada unaMision || esFactible unEquipo unaMision = cumplirMision unaMision unEquipo
 | otherwise                                           = fallarMision unEquipo unaMision

granGuerraNinja :: Mision
granGuerraNinja = UnaMision 100000 100 zetsusInfinitos abanicoDeMadaraUchiha

zetsusInfinitos :: [Ninja]
zetsusInfinitos = map zetsu [1..]

zetsu :: Int -> Ninja
zetsu unNumero = UnNinja {
  nombre       = "Zetsu " ++ show unNumero,
  rango        = 600,
  jutsus       = [],
  herramientas = []
} 

abanicoDeMadaraUchiha :: Herramienta
abanicoDeMadaraUchiha = ("Abanico de Madara Uchiha",1)