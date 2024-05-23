import Text.Show.Functions

data Turista = UnTurista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [String]
} deriving (Show)
 
type Excursion = Turista -> Turista

irALaPlaya :: Excursion
irALaPlaya unTurista 
 | viajaSolo unTurista = modificarCansancio (subtract 5) unTurista
 | otherwise = modificarStress (subtract 1) unTurista

modificarCansancio :: (Int->Int) -> Turista -> Turista
modificarCansancio unaFuncion unTurista = unTurista {cansancio = unaFuncion (cansancio unTurista)}

modificarStress :: (Int->Int) -> Turista -> Turista
modificarStress unaFuncion unTurista = unTurista {stress = unaFuncion (stress unTurista)}

apreciarDelPaisaje :: String -> Excursion
apreciarDelPaisaje unElemento unTurista = modificarStress (subtract (length unElemento)) unTurista

salirAHablarUnIdioma :: String -> Excursion
salirAHablarUnIdioma unIdioma unTurista = (aprenderIdioma unIdioma.continuaAcompaniado) unTurista

continuaAcompaniado :: Excursion
continuaAcompaniado unTurista = unTurista {viajaSolo=False}

aprenderIdioma :: String -> Excursion
aprenderIdioma unIdioma unTurista = unTurista {idiomas = idiomas unTurista ++ [unIdioma]}

caminar :: Int -> Excursion
caminar unosMinutos unTurista = modificarStress (subtract (intensidad unosMinutos)) (modificarCansancio (+intensidad unosMinutos) unTurista)
                                                    -- unaFuncion                                      devuelve unTurista
                                                                --          me devuelve unTurista
intensidad :: Int -> Int
intensidad unosMinutos = div unosMinutos 4

paseoEnBarco :: String -> Excursion
paseoEnBarco "Fuerte" unTurista = modificarStress (+6) (modificarCansancio (+10) unTurista)
paseoEnBarco "Moderada" unTurista = unTurista
paseoEnBarco "Tranquila" unTurista = (caminar 10.apreciarDelPaisaje "mar") (salirAHablarUnIdioma "Aleman" unTurista)

ana::Turista
ana = UnTurista 0 21 False ["Espanol"]

beto::Turista
beto = UnTurista 15 15 True ["Aleman"]

cathi::Turista
cathi = UnTurista 15 15 True ["Aleman", "Catalan"]

hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion unaExcursion unTurista =  unaExcursion $ modificarStressPorcentual (stress unTurista -) 10 unTurista

modificarStressPorcentual :: (Int -> Int) -> Int -> Turista -> Turista
modificarStressPorcentual unaFuncion unPorcentaje unTurista = unTurista {stress = unaFuncion (stress unTurista * unPorcentaje `div` 100)}

{-hacerExcursion :: Excursion -> Turista -> Turista
hacerExcursion unaExcursion unTurista =  unaExcursion $ unTurista {stress= modificarStressPorcentual (stress unTurista -) 10 unTurista}

modificarStressPorcentual :: (Int -> Int) -> Int -> Turista -> Int
modificarStressPorcentual unaFuncion unPorcentaje unTurista = unaFuncion (stress unTurista * unPorcentaje `div` 100)-} -- ASÍ, MODIFICARSTRESSPORCENTUAL ME DEVUELVE UN NÚMERO EN VEZ DE UN TURISTA ENTERO

type Indice = Turista->Int

deltaExcursionSegun :: Indice -> Turista -> Excursion -> Int
deltaExcursionSegun unIndice unTurista unaExcursion = unIndice (hacerExcursion unaExcursion unTurista) - unIndice unTurista

esEducativa :: Excursion -> Turista -> Bool
esEducativa unaExcursion unTurista = deltaExcursionSegun (length.idiomas) unTurista unaExcursion > 0

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes unTurista unasExcursiones = filter (esDesestresante unTurista) unasExcursiones

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante unTurista unaExcursion = deltaExcursionSegun stress unTurista unaExcursion > 3

type Tour = [Excursion]

tourCompleto :: Tour
tourCompleto = [caminar 20, apreciarDelPaisaje "cascada", caminar 40, irALaPlaya, salirAHablarUnIdioma "melmacquiano"]

tourLadoB :: Excursion -> Tour
tourLadoB unaExcursion= [paseoEnBarco "Tranquila", hacerExcursion unaExcursion, caminar 120]

tourIslasVecinas :: String -> Tour
tourIslasVecinas "Fuerte" = [paseoEnBarco "Fuerte", apreciarDelPaisaje "lago", paseoEnBarco "Fuerte"]
tourIslasVecinas "Tranquila" = [paseoEnBarco "Tranquila", irALaPlaya, paseoEnBarco "Tranquila"]
tourIslasVecinas "Moderada" = [paseoEnBarco "Moderada", irALaPlaya, paseoEnBarco "Moderada"]

-- Hacer que un turista haga un tour. Esto implica, primero un aumento del stress en tantas unidades como cantidad de excursiones tenga el tour, y luego realizar las excursiones en orden.

hacerTour :: Tour -> Turista -> Turista
hacerTour unTour unTurista = foldr ($) (modificarStress (+length unTour) unTurista) unTour
-- a cada elemento del Tour, le aplica un turista, y el resultado de esa aplicación se lo aplica al siguiente elemento del Tour. Usa $ para aplicar la función a la derecha del $ a la izquierda del $.

-- Dado un conjunto de tours, saber si existe alguno que sea convincente para un turista. Esto significa que el tour tiene alguna excursión desestresante la cual, además, deja al turista acompañado luego de realizarla.

tourConvincente :: Turista -> [Tour] -> Bool
tourConvincente unTurista unosTours = any (esConvincente unTurista) unosTours

esConvincente :: Turista -> Tour -> Bool
esConvincente unTurista unTour = any (\excursion -> esDesestresante unTurista excursion && viajaSolo (hacerExcursion excursion unTurista)) unTour





