import Text.Show.Functions

data Heroe = UnHeroe{
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
} deriving (Show)

type Artefacto = (String, Int)

nombreArtefacto :: Artefacto -> String
nombreArtefacto (nombre, _) = nombre
rarezaArtefacto :: Artefacto -> Int
rarezaArtefacto (_, rareza) = rareza

modificarRareza :: (Int->Int) -> Artefacto -> Artefacto
modificarRareza unaFuncion (nombre, rareza) = (nombre, unaFuncion rareza)

type Tarea = Heroe -> Heroe

modificarEpiteto :: (String -> String) -> Heroe -> Heroe
modificarEpiteto unaFuncion unHeroe = unHeroe {epiteto = unaFuncion (epiteto unHeroe)}

cambiarEpiteto :: String -> Heroe -> Heroe
cambiarEpiteto unEpiteto unHeroe = unHeroe {epiteto = unEpiteto}

modificarReconocimiento :: (Int -> Int) -> Heroe -> Heroe
modificarReconocimiento unaFuncion unHeroe = unHeroe {reconocimiento = unaFuncion (reconocimiento unHeroe)}

modificarArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
modificarArtefactos unaFuncion unHeroe = unHeroe {artefactos = unaFuncion (artefactos unHeroe)}

modificarTareas :: ([Tarea] -> [Tarea]) -> Heroe -> Heroe
modificarTareas unaFuncion unHeroe = unHeroe {tareas = unaFuncion (tareas unHeroe)}

paseALaHistoria :: Heroe -> Heroe
paseALaHistoria unHeroe 
 |reconocimiento unHeroe > 1000 = cambiarEpiteto "El mitico" unHeroe
 |reconocimiento unHeroe >= 500 = cambiarEpiteto "El magnifico".modificarArtefactos (++ [("Lanza del Olimpo", 100)]) $ unHeroe
 |reconocimiento unHeroe > 100 = cambiarEpiteto "Hoplita".modificarArtefactos (++ [("Xiphos", 50)]) $ unHeroe
 |otherwise = unHeroe

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto =  modificarReconocimiento (+rarezaArtefacto unArtefacto).modificarArtefactos (++[unArtefacto]) 

escalarElOlimpo :: Tarea
escalarElOlimpo unHeroe = modificarReconocimiento (+500).modificarArtefactos (("El relámpago de Zeus", 500) :).mejorarArtefactos $ unHeroe

mejorarArtefactos :: Heroe -> Heroe
mejorarArtefactos unHeroe = modificarArtefactos (filter (\artefacto -> rarezaArtefacto artefacto > 1000)) (modificarArtefactos (map (modificarRareza (*3))) unHeroe)

ayudarACruzarCalle :: Int -> Tarea
ayudarACruzarCalle cantidadCalles = cambiarEpiteto ("Gros" ++ replicate cantidadCalles 'o')

data Bestia = UnaBestia{
    nombre :: String,
    debilidad :: Debilidad
} deriving (Show)

type Debilidad = Heroe -> Bool

matarUnaBestia :: Bestia -> Tarea
matarUnaBestia unaBestia unHeroe 
 |debilidad unaBestia unHeroe = cambiarEpiteto ("El asesino de " ++ nombre unaBestia) unHeroe
 |otherwise = cambiarEpiteto ("El cobarde").modificarArtefactos (drop 1) $ unHeroe

heracles :: Heroe
heracles = UnHeroe "Guardian del olimpo" 700 [("pistola",1000),("Relampago de Zeus",500)] [matarUnaBestia leonDeNemea]

leonDeNemea :: Bestia
leonDeNemea = UnaBestia "Leon de Nemea" ((>20).length.epiteto)

realizarTarea :: Tarea -> Heroe -> Heroe
realizarTarea unaTarea unHeroe = modificarTareas (unaTarea :).unaTarea $ unHeroe

presumenLogros :: Heroe -> Heroe -> (Heroe, Heroe)
presumenLogros unHeroe otroHeroe
    | gana unHeroe otroHeroe  = (unHeroe, otroHeroe)
    | gana otroHeroe unHeroe  = (otroHeroe, unHeroe)
    | otherwise               = presumenLogros (realizanTareasDelOtro unHeroe otroHeroe) (realizanTareasDelOtro otroHeroe unHeroe)

gana :: Heroe -> Heroe -> Bool
gana ganador perdedor = reconocimiento ganador > reconocimiento perdedor || reconocimiento ganador == reconocimiento perdedor && sumatoriaRarezas ganador > sumatoriaRarezas perdedor

sumatoriaRarezas :: Heroe -> Int
sumatoriaRarezas unHeroe = sum (map rarezaArtefacto (artefactos unHeroe))

realizanTareasDelOtro :: Heroe -> Heroe -> Heroe
realizanTareasDelOtro heroe1 heroe2 = realizarUnaLabor heroe1 (tareas heroe2)

type Labor = [Tarea]

realizarUnaLabor :: Heroe -> Labor -> Heroe
realizarUnaLabor unHeroe unaLabor = foldr ($) unHeroe unaLabor