import Text.Show.Functions

data Material = Material {
    nombre :: String,
    calidad :: Int
} deriving (Show,Eq)

data Edificio = Edificio {
    tipoEdificio :: String,
    materiales :: [Material]
} deriving (Show, Eq)

data Aldea = Aldea {
    poblacion :: Int,
    materialesDisponibles :: [Material],
    edificios :: [Edificio]
} deriving (Show, Eq)

esValioso :: Material -> Bool
esValioso unMaterial = (>20).calidad $ unMaterial

unidadesDisponibles :: String -> Aldea -> Int
unidadesDisponibles unMaterial unaAldea = length.filter (\material -> nombre material == unMaterial) $ (materialesDisponibles unaAldea) 

aldeita :: Aldea
aldeita = Aldea 50 [Material "Madera" 15, Material "Acero" 20] []

papuAldea :: Aldea
papuAldea = Aldea 50 [Material "Acero" 15, Material "Piedra" 5] [edificio1, edificio2]

edificio1 :: Edificio
edificio1 = Edificio "Casa" [Material "Madera" 15, Material "Acero" 20]

edificio2 :: Edificio
edificio2 = Edificio "Casa" [Material "Madera" 15, Material "Acero" 20, Material "Piedra" 5]


valorTotal :: Aldea -> Int
valorTotal unaAldea = sumaDeMaterialesDisponibles unaAldea + sumaDeMaterialesDeEdificios unaAldea

sumaDeMaterialesDisponibles :: Aldea -> Int
sumaDeMaterialesDisponibles unaAldea = sum.map calidad.materialesDisponibles $ unaAldea

sumaDeMaterialesDeEdificios :: Aldea -> Int
sumaDeMaterialesDeEdificios unaAldea = sum.map calidad.concatMap materiales.edificios $ unaAldea

type Tarea = Aldea -> Aldea

modificarPoblacion :: (Int->Int) -> Aldea -> Aldea
modificarPoblacion unaFuncion unaAldea = unaAldea {poblacion = unaFuncion.poblacion $ unaAldea}

tenerGnomito :: Tarea
tenerGnomito unaAldea = modificarPoblacion (+1) unaAldea

modificarMateriales :: ([Material]->[Material]) -> Aldea -> Aldea
modificarMateriales unaFuncion unaAldea = unaAldea {materialesDisponibles = unaFuncion.materialesDisponibles $ unaAldea}

lustrarMaderas :: Tarea
lustrarMaderas unaAldea = modificarMateriales ((++ restantes (materialesDisponibles unaAldea)).modificarMaderas) unaAldea

modificarMaderas :: [Material] -> [Material]
modificarMaderas unosMateriales = map (modificarCalidad (+5)).filter (empiezanCon "Madera") $ unosMateriales

restantes :: [Material] -> [Material]
restantes  = filter (not.empiezanCon "Madera") 

empiezanCon :: String -> Material -> Bool
empiezanCon unasLetras unMaterial = take (length unasLetras) (nombre unMaterial) == unasLetras

modificarCalidad :: (Int->Int) -> Material -> Material
modificarCalidad unaFuncion unMaterial = unMaterial {calidad = unaFuncion.calidad $ unMaterial}

type Cantidad = Int

recolectar :: Material -> Cantidad -> Tarea
recolectar unMaterial unaCantidad unaAldea = modificarMateriales (++(replicate unaCantidad unMaterial)) unaAldea

obtenerEdificiosChetos :: Aldea -> [Edificio]
obtenerEdificiosChetos unaAldea = filter esEdificioCheto (edificios unaAldea)

esEdificioCheto :: Edificio -> Bool
esEdificioCheto unEdificio = any esValioso (materiales unEdificio)

-- 3B 
listaDeMaterialesComunes :: Aldea -> [String]
listaDeMaterialesComunes unaAldea = map nombre.filter (esMaterialComun unaAldea) $ (concatMap materiales (edificios unaAldea))

esMaterialComun :: Aldea -> Material -> Bool
esMaterialComun unaAldea unMaterial = length (edificios unaAldea) == length (filter (/=unMaterial) (concatMap materiales (edificios unaAldea)))

realizarLasQueCumplan :: [Tarea] -> (Aldea->Bool) -> Aldea -> Aldea
realizarLasQueCumplan [] _ unaAldea = unaAldea
realizarLasQueCumplan (tarea:tareas) unCriterio unaAldea 
 | unCriterio (tarea unaAldea) = realizarLasQueCumplan tareas unCriterio (tarea unaAldea)
 | otherwise = realizarLasQueCumplan tareas unCriterio unaAldea

--4B
-- realizarLasQueSeCumplan [traerGnomito,traerGnomito,traerGnomito] hayComidaDisponible unaAldea
-- realizarLasQueCumplan [recolectar 30 maderaDePino, lustrarMaderas] (all sonValiosos (materialesDisponibles unaAldea)) unaAldea
 