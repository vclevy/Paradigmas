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

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
    | f a > f b = a
    | otherwise = b
deltaSegun ponderacion transformacion valor = abs ((ponderacion . transformacion) valor - ponderacion valor)
