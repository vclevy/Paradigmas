
data Chico = Chico {
    nombre :: String,
    edad :: Int,
    habilidades :: [String],
    deseos :: String
}deriving (Show,Eq)



aprenderHabilidades :: String -> Chico -> Chico
aprenderHabilidades habilidad unChico = unChico{habilidades = (habilidades unChico) ++ habilidad}