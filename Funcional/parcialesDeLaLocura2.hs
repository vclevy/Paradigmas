{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions

data Investigador = Investigador {
    nombre :: String,
    cordura :: Int,
    items :: [Item],
    sucesosEvitados :: [String]
} deriving (Show, Eq)

data Item = Item {
    nombreItem :: String,
    valor :: Int
} deriving (Show, Eq)

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)

mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
    | f a > f b = a
    | otherwise = b

deltaSegun :: Num a => (b -> a) -> (b -> b) -> b -> a
deltaSegun ponderacion transformacion valor = abs ((ponderacion . transformacion) valor - ponderacion valor)

-- Punto 1

modificarCordura :: (Int -> Int) -> Investigador -> Investigador
modificarCordura modificador unInvestigador = unInvestigador {cordura = max 0 ((modificador . cordura) unInvestigador)}

modificarItems :: ([Item] -> [Item]) -> Investigador -> Investigador
modificarItems modificador unInvestigador = unInvestigador {items = (modificador . items) unInvestigador}

hallarItem :: Item -> Investigador -> Investigador
hallarItem unItem = modificarCordura (subtract (valor unItem)) . modificarItems (unItem :)

-- Punto 2

tieneElItem' :: String -> Investigador -> Bool
tieneElItem' unItem unInvestigador = elem unItem (map nombreItem (items unInvestigador))

tieneElItem :: String -> [Investigador] -> Bool
tieneElItem unItem = any (tieneElItem' unItem)

-- Punto 3

estaTotalmenteLoco :: Investigador -> Bool
estaTotalmenteLoco unInvestigador = cordura unInvestigador == 0

maxValorItem :: Investigador -> Int
maxValorItem unInvestigador = valor (maximoSegun valor (items unInvestigador))

experiencia :: Investigador -> Int
experiencia unInvestigador = 1 + 3 * length (sucesosEvitados unInvestigador)

potencial :: Investigador -> Int
potencial unInvestigador
    | estaTotalmenteLoco unInvestigador = 0
    | otherwise = experiencia unInvestigador * cordura unInvestigador + maxValorItem unInvestigador

liderActual :: [Investigador] -> Investigador
liderActual = maximoSegun potencial

-- Punto 4

deltaCorduraTotal :: [Investigador] -> ([Investigador] -> [Investigador]) -> Int
deltaCorduraTotal grupo transformacion = deltaSegun corduraTotal transformacion grupo
  where
    corduraTotal = sum . map cordura

data Suceso = Suceso {
    descripcion :: String,
    consecuencias :: [Consecuencia],
    evitarConsecuencias :: [Investigador] -> Bool
} deriving (Show)

type Consecuencia = [Investigador] -> [Investigador]

despertarDeUnAntiguo :: Suceso
despertarDeUnAntiguo = Suceso "Despertar de un Antiguo" [map (modificarCordura (subtract 10)), tail] (tieneElItem "Necronomicon")

ritualEnInnsmouth :: Suceso
ritualEnInnsmouth = Suceso "Ritual en Innsmouth" [aplicarAlPrimero (hallarItem dagaMaldita), map (modificarCordura (subtract 2)), enfrentarSuceso despertarDeUnAntiguo] ((100 <) . potencial . liderActual)

dagaMaldita :: Item
dagaMaldita = Item "Daga maldita" 3

aplicarAlPrimero :: (a -> a) -> [a] -> [a]
aplicarAlPrimero _ [] = []
aplicarAlPrimero f (x:xs) = f x : xs

aplicarConsecuencia :: Suceso -> [Investigador] -> [Investigador]
aplicarConsecuencia unSuceso grupo = foldl (flip ($)) grupo (consecuencias unSuceso)

enfrentarSuceso :: Suceso -> Consecuencia
enfrentarSuceso unSuceso unGrupo
    | evitarConsecuencias unSuceso unGrupo = map (agregarDescripcion (descripcion unSuceso) . modificarCordura (subtract 1)) unGrupo
    | otherwise = (aplicarConsecuencia unSuceso . map (modificarCordura (subtract 1))) unGrupo

agregarDescripcion :: String -> Investigador -> Investigador
agregarDescripcion unaDescripcion unInvestigador = unInvestigador {sucesosEvitados = unaDescripcion : sucesosEvitados unInvestigador}

elMasAterrador :: [Investigador] -> [Suceso] -> String
elMasAterrador grupo sucesos = descripcion . maximoSegun (deltaCorduraTotal grupo . enfrentarSuceso) $ sucesos
