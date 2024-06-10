import Text.Show.Functions

data Pais = UnPais{
    ingresoPerCapita :: Float,
    poblacionActivaPrivado :: Float,
    poblacionActivaPublico :: Float,
    recursosNaturales :: [String],
    deudaFMI :: Float 
}deriving (Show)

modificarDeudaFMI :: (Float->Float) -> Pais -> Pais
modificarDeudaFMI unaFuncion unPais = unPais {deudaFMI = unaFuncion.deudaFMI $ unPais}

modificarPoblacionPublico :: (Float->Float) -> Pais -> Pais
modificarPoblacionPublico unaFuncion unPais = unPais {poblacionActivaPublico = unaFuncion.poblacionActivaPublico$ unPais}

modificarPoblacionPrivado :: (Float->Float) -> Pais -> Pais
modificarPoblacionPrivado unaFuncion unPais = unPais {poblacionActivaPrivado = unaFuncion.poblacionActivaPrivado$ unPais}

modificarPerCapita :: (Float->Float) -> Pais -> Pais
modificarPerCapita unaFuncion unPais = unPais {ingresoPerCapita = unaFuncion.ingresoPerCapita $ unPais}

modificarRN :: ([String] -> [String]) -> Pais -> Pais
modificarRN unaFuncion unPais = unPais {recursosNaturales = unaFuncion.recursosNaturales $ unPais}

type Estrategia = Pais->Pais

prestarMillones :: Float -> Estrategia
prestarMillones unNumero = modificarDeudaFMI (+ 1.5*unNumero)

reducirSectorPublico :: Float -> Estrategia
reducirSectorPublico unNumero unPais 
 |poblacionActivaPublico unPais >100 = modificarPoblacionPublico (subtract unNumero).modificarPerCapita (subtract (0.2*ingresoPerCapita unPais)) $ unPais
 |otherwise = modificarPoblacionPublico (subtract unNumero).modificarPerCapita (subtract (0.15*ingresoPerCapita unPais)) $ unPais

darAFin :: String -> Estrategia
darAFin unRecurso = modificarDeudaFMI (subtract 200).modificarRN (filter (/= unRecurso))

poblacionActiva:: Pais -> Float
poblacionActiva unPais = poblacionActivaPrivado unPais + poblacionActivaPublico unPais

pbi :: Pais -> Float
pbi unPais = ingresoPerCapita unPais * (poblacionActiva unPais)

establecerBlindaje :: Estrategia
establecerBlindaje unPais = modificarDeudaFMI (subtract ((pbi unPais)/2)).modificarPoblacionPublico (subtract 500) $ unPais

namibia :: Pais
namibia = UnPais {
    ingresoPerCapita = 4140,
    poblacionActivaPrivado = 650000,
    poblacionActivaPublico = 400000,
    recursosNaturales = ["mineria", "ecoturismo"],
    deudaFMI = 50 --en millones
}


-- darAFin "Mineria" namibia

--zafa :: Pais -> Bool
--zafa unPais = elem "Petroleo" (recursosNaturales unPais)

cualesZafan :: [Pais] -> [Pais]
cualesZafan = filter (\pais -> elem "Petroleo" (recursosNaturales pais))

deudaAFavor :: [Pais] -> [Pais]
deudaAFavor = filter ((<0).deudaFMI) 

ordenada :: Pais -> Estrategia -> Bool
ordenada unPais unasEstrategias = estrategiasOrdenadas unasEstrategias unPais

estrategiasOrdenadas :: [Estrategia] -> Pais -> Bool
estrategiasOrdenadas [unaEstrategia] unPais = True
estrategiasOrdenadas (cabeza:cola) unPais = pbi ((head cola)aplicarEstrategias unPais) > pbi (cabeza unPais) && estrategiasOrdenadas cola unPais

aplicarEstrategias :: Pais -> [Estrategia] -> Pais
aplicarEstrategias unPais estrategias = foldr ($) unPais estrategias
