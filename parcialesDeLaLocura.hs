{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}
import Text.Show.Functions
import Language.Haskell.TH (Con)

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
enloquecer :: Int ->Investigador -> Investigador
enloquecer unNumero unInvestigador
    | cordura unInvestigador - unNumero >=0 = Investigador{ cordura = cordura unInvestigador - unNumero}
    | otherwise = Investigador{cordura = 0}

hallarItem :: Item -> Investigador -> Investigador
hallarItem unItem unInvestigador = (enloquecer (valor unItem) unInvestigador){items = unItem : items unInvestigador}

--PUNTO 2
tienenElItem :: [Investigador] -> String -> Bool
tienenElItem grupoInvestigadores unItem = any (any (\item -> nombreItem item == unItem) . items) grupoInvestigadores
--No entendi esta funcion
--PUNTO 3

valorMaxItems :: [Item] -> Int
valorMaxItems unosItems = valor (maximoSegun valor unosItems)

potencial :: Investigador -> Int
potencial unInvestigador
    | cordura unInvestigador == 0 = 0
    | otherwise = cordura unInvestigador * ((1+).length.sucesosEvitados) unInvestigador + (valorMaxItems.items) unInvestigador

liderActual :: [Investigador] -> Investigador
liderActual unGrupo = maximoSegun potencial unGrupo

--PUNTO 4
deltaCordura :: Int -> [Investigador] -> Int
deltaCordura cantPuntos = sum.map (deltaSegun cordura (enloquecer cantPuntos))

enloquecerPorCompleto :: Investigador -> Investigador
enloquecerPorCompleto unInvestigador = enloquecer (cordura unInvestigador) unInvestigador

deltaPotencial :: [Investigador] -> Int
deltaPotencial = head.map (deltaSegun potencial enloquecerPorCompleto)

--Estan muriendo gatitos por el punto 4, aplicar orden superior
{-4c. No seria posible obtener el resultado de la funcion del punto a debido a que nunca dejaran de sumarse elementos 
asi que no podemos obtener un resultado final. En el punto b ocurre algo similar, si bien si podemos tomar la cabeza de una lista infinita
no hay una cabeza definida ya que siempre aparecer una nueva cabeza por cada iteracion del map-}

data Suceso = Suceso {
    descripcion :: String,
    consecuencias :: [Consecuencia],
    evitarConsecuencias :: [Investigador]->Bool
}deriving(Show)

type Consecuencia = [Investigador] -> [Investigador]

despertarDeUnAntiguo :: Suceso
despertarDeUnAntiguo = Suceso "Despertar de un Antiguo" [map (enloquecer 10), tail] (`tienenElItem` "Necronomicon")

ritualEnInnsmouth :: Suceso
ritualEnInnsmouth = Suceso "Ritual en Innsmouth" [aplicarAlPrimero (hallarItem dagaMaldita),map (enloquecer 2), enfrentarSuceso despertarDeUnAntiguo] ((100<).potencial.liderActual)

dagaMaldita :: Item
dagaMaldita = Item "Daga maldita" 3

aplicarAlPrimero :: (a -> a) -> [a] -> [a]
aplicarAlPrimero f [] = []
aplicarAlPrimero f (x:xs) = f x : xs

enfrentarSuceso :: Suceso -> Consecuencia
enfrentarSuceso unSuceso unGrupo
    | (evitarConsecuencias unSuceso) unGrupo = map ((agregarDescripcion.descripcion) unSuceso . enloquecer 1) unGrupo
    | otherwise = foldl (\grupo consecuencia -> consecuencia grupo) (map (enloquecer 1) unGrupo) (consecuencias unSuceso)

agregarDescripcion :: String -> Investigador-> Investigador
agregarDescripcion unaDescripcion unInvestigador = Investigador{sucesosEvitados = unaDescripcion:(sucesosEvitados unInvestigador)}

elMasAterrador :: [Investigador] -> [Suceso] -> String
elMasAterrador = undefined

