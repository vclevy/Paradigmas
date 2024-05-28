{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLFloat ignore "Use notElem" #-}
import Text.Show.Functions

data Pais = Pais{
    ingresoPerCapita :: Float,
    poblacionActivaPublico :: Float,
    poblacionActivaPrivado :: Float,
    rrnaturales :: [String],
    deuda :: Float
}deriving(Show)

modificarDeuda :: Pais -> (Float->Float) -> Pais
modificarDeuda unPais modificador =unPais{deuda = modificador (deuda unPais)}

prestar :: Float -> Pais -> Pais
prestar millones unPais = modificarDeuda unPais (+ 1.5*millones)

modificarPoblacionPublico :: Float -> Pais -> Pais
modificarPoblacionPublico personas unPais = unPais{poblacionActivaPublico= poblacionActivaPublico unPais-personas}

reducirSectorPublico :: Float -> Pais -> Pais
reducirSectorPublico personas unPais 
    |poblacionActivaPublico(modificarPoblacionPublico personas unPais) >100 = (modificarPoblacionPublico personas unPais){ingresoPerCapita= ingresoPerCapita unPais *0.8}
    |otherwise =(modificarPoblacionPublico personas unPais){ingresoPerCapita = ingresoPerCapita unPais *0.85}

sacarRecurso :: String -> Pais -> Pais
sacarRecurso recurso unPais = unPais{rrnaturales = filter (/= recurso) (rrnaturales unPais)}

explotarRecurso :: String -> Pais -> Pais
explotarRecurso recurso unPais = modificarDeuda (sacarRecurso recurso unPais) (+(-2))

pbi :: Pais -> Float
pbi unPais = ingresoPerCapita unPais*(poblacionActivaPrivado unPais + poblacionActivaPublico unPais)

blindar :: Pais -> Pais 
blindar unPais = (reducirSectorPublico 500.prestar (pbi unPais)) unPais