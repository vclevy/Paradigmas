import Text.Show.Functions

data Persona = Persona{
    edad :: Int,
    items :: [String],
    experiencia :: Int 
}deriving (Show)

data Criatura = Criatura{
    peligrosidad:: Int,
    deshacerseDe :: Persona->Bool --por ahora
} deriving(Show)

type Condicion = Persona -> Bool

siempredetras:: Criatura
siempredetras = Criatura 0 nadaQueHacer

nadaQueHacer:: Persona -> Bool
nadaQueHacer _ = False

peligrosidadGnomos :: Int -> Int
peligrosidadGnomos cantidad = 2^cantidad

poseeElemento :: String -> Persona -> Bool
poseeElemento elemento persona = elemento `elem` items persona

gnomos ::Int -> Criatura
gnomos cantidad = Criatura{peligrosidad= peligrosidadGnomos cantidad,deshacerseDe= poseeElemento "soplador de hojas"}

fantasma :: Int -> Condicion ->Criatura
fantasma categoria condicion = Criatura{peligrosidad = 20*categoria,deshacerseDe = condicion}

modificarExperiencia :: (Int->Int) -> Persona -> Persona
modificarExperiencia modificador unaPersona = unaPersona{experiencia= modificador (experiencia unaPersona)}

tieneLoQueSeNecesita :: Criatura -> Persona -> Bool
tieneLoQueSeNecesita  = deshacerseDe   

enfrenarCriatura :: Persona-> Criatura -> Persona
enfrenarCriatura unaPersona unaCriatura 
    | tieneLoQueSeNecesita unaCriatura unaPersona = modificarExperiencia (+peligrosidad unaCriatura) unaPersona
    | otherwise = modificarExperiencia (+1) unaPersona

enfrentosSucesivos :: [Criatura] -> Persona -> Persona
enfrentosSucesivos unasCriaturas unaPersona = foldl enfrenarCriatura unaPersona unasCriaturas

gnomos10 :: Criatura
gnomos10 = gnomos 10

condicionFantasma3 :: Persona -> Bool
condicionFantasma3 unaPersona = poseeElemento "disfraz de oveja" unaPersona && 13>edad unaPersona

fantasma3 :: Criatura
fantasma3 = fantasma 3 condicionFantasma3 

fantasma1 :: Criatura
fantasma1 = fantasma 1 ((10<).experiencia)

persona1 ::Persona
persona1 = Persona 10 ["caca", "disfraz de oveja"] 0

