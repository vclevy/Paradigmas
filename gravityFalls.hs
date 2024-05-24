import Text.Show.Functions
import GHC.ResponseFile (escapeArgs)

data Persona = Persona{
    edad :: Int,
    items :: [String],
    experiencia :: Int 
}deriving (Show)

data Criatura = Criatura{
    peligrosidad:: Int,
    deshacerseDe :: String --por ahora
} deriving(Show)

siempredetras:: Criatura
siempredetras = Criatura 0 ""

peligrosidadGnomos :: Int -> Int
peligrosidadGnomos cantidad = 2^cantidad

gnomos ::Int -> Criatura
gnomos cantidad = Criatura{peligrosidad= peligrosidadGnomos cantidad,deshacerseDe= "soplador de hojas"}

fantasma :: Int -> String ->Criatura
fantasma categoria condicion = Criatura{peligrosidad = 20*categoria,deshacerseDe = condicion}

modificarExperiencia :: (Int->Int) -> Persona -> Persona
modificarExperiencia modificador unaPersona = unaPersona{experiencia= modificador (experiencia unaPersona)}

tieneLoQueSeNecesita :: Criatura -> Persona -> Bool
tieneLoQueSeNecesita unaCriatura unaPersona = deshacerseDe unaCriatura `elem` items unaPersona

enfrenarCriatura :: Persona-> Criatura -> Persona
enfrenarCriatura unaPersona unaCriatura 
    | tieneLoQueSeNecesita unaCriatura unaPersona = modificarExperiencia (+peligrosidad unaCriatura) unaPersona
    | otherwise = modificarExperiencia (+1) unaPersona

