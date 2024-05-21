{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions

data Investigador = Investigador{
    nombre :: String,
    cordura :: Int,
    items :: [Item],
    sucesosEvitados :: [String]
} deriving(Show,Eq)

data Item = Item{
   nombreItem :: String,
   valor :: Int
} deriving(Show,Eq)

maximoSegun :: (Foldable t, Ord a1) => (a2 -> a1) -> t a2 -> a2
maximoSegun f = foldl1 (mayorSegun f)
mayorSegun :: Ord a => (t -> a) -> t -> t -> t
mayorSegun f a b
    | f a > f b = a
    | otherwise = b
deltaSegun :: Num a => (b -> a) -> (b -> b) -> b -> a
deltaSegun ponderacion transformacion valor = abs ((ponderacion . transformacion) valor - ponderacion valor)
--PUNTO 1
enloquecer :: Int ->Investigador-> Investigador
enloquecer unNumero unInvestigador
    | cordura unInvestigador - unNumero >=0 = Investigador{ cordura = cordura unInvestigador - unNumero}
    | otherwise = Investigador{cordura = 0}

hallarItem :: Item -> Investigador -> Investigador
hallarItem unItem unInvestigador = (enloquecer (valor unItem) unInvestigador){items = unItem : items unInvestigador}

--PUNTO 2
tienenElItem :: [Investigador] -> Item -> Bool
tienenElItem grupoInvestigadores unItem = any (elem unItem . items) grupoInvestigadores

--PUNTO 3

valorMaxItems :: [Item] -> Int
valorMaxItems unosItems = valor (maximoSegun valor unosItems)

potencial :: Investigador -> Int
potencial unInvestigador 
    | cordura unInvestigador == 0 = 0
    | otherwise = cordura unInvestigador * ((1+).length.sucesosEvitados) unInvestigador + (valorMaxItems.items) unInvestigador

liderActual :: [Investigador] -> Investigador
liderActual unGrupo = maximoSegun potencial unGrupo

deltaCordura :: Int -> [Investigador] -> Int
deltaCordura cantPuntos = sum.map (deltaSegun cordura (enloquecer cantPuntos)) 

enloquecerPorCompleto :: Investigador -> Investigador
enloquecerPorCompleto unInvestigador = enloquecer (cordura unInvestigador) unInvestigador

deltaPotencial :: [Investigador] -> Int
deltaPotencial = head.map (deltaSegun potencial enloquecerPorCompleto)