import Text.Show.Functions

data Personaje = UnPersonaje {
    nombre :: String,
    cantidadDePoder:: Int,
    derrotas :: [Derrota],
    equipamiento :: [Equipamiento]
} deriving (Show)

type Derrota = (String, Int)
nombreDelDerrotado::Derrota->String
nombreDelDerrotado (nombree,_) = nombree
anioDeDerrota ::Derrota->Int
anioDeDerrota (_,anio) = anio

modificarNombre :: (String->String) -> Personaje -> Personaje
modificarNombre unaFuncion unPersonaje = unPersonaje {nombre = unaFuncion.nombre $ unPersonaje}

modificarCantidadDePoder :: (Int->Int) -> Personaje -> Personaje
modificarCantidadDePoder unaFuncion unPersonaje = unPersonaje {cantidadDePoder = unaFuncion.cantidadDePoder $ unPersonaje}

modificarDerrotas :: ([Derrota]->[Derrota]) -> Personaje -> Personaje
modificarDerrotas unaFuncion unPersonaje = unPersonaje {derrotas = unaFuncion.derrotas $ unPersonaje}

modificarEquipamiento :: ([Equipamiento]->[Equipamiento]) ->Personaje -> Personaje
modificarEquipamiento unaFuncion unPersonaje = unPersonaje {equipamiento = unaFuncion.equipamiento $ unPersonaje}

entrenamiento :: [Personaje] -> [Personaje]
entrenamiento unosPersonajes = map (modificarCantidadDePoder (*length unosPersonajes)) unosPersonajes

rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos unosPersonajes = filter (digno) (entrenamiento unosPersonajes)

digno :: Personaje -> Bool
digno unPersonaje =  ((>500).cantidadDePoder) unPersonaje && algunaDerrotaSea "Hijo de Tanos" unPersonaje

algunaDerrotaSea :: String -> Personaje -> Bool
algunaDerrotaSea nombreDerrota unPersonaje = elem nombreDerrota (nombresDeLosDerrotados unPersonaje)

nombresDeLosDerrotados :: Personaje -> [String]
nombresDeLosDerrotados unPersonaje = map nombreDelDerrotado (derrotas unPersonaje)

guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil unAnio = zipWith (pelean unAnio)

pelean :: Int -> Personaje -> Personaje -> Personaje
pelean unAnio unPersonaje otroPersonaje 
 |gana unPersonaje otroPersonaje = modificarDerrotas ((nombre otroPersonaje,unAnio):) unPersonaje
 |otherwise = modificarDerrotas ((nombre unPersonaje,unAnio):) otroPersonaje

gana :: Personaje -> Personaje -> Bool
gana unPersonaje otroPersonaje = cantidadDePoder unPersonaje > cantidadDePoder otroPersonaje

type Equipamiento = Personaje -> Personaje    

escudo :: Equipamiento
escudo unPersonaje 
 |(<5).length $ derrotas unPersonaje = modificarCantidadDePoder (+50) unPersonaje
 |otherwise = modificarCantidadDePoder (subtract 100) unPersonaje

trajeMecanizado :: String -> Equipamiento
trajeMecanizado unaVersion unPersonaje = modificarNombre (const ("Iron" ++ (nombre unPersonaje) ++ unaVersion)) unPersonaje

stormBreaker :: Equipamiento
stormBreaker unPersonaje 
 |es "Thor" unPersonaje = modificarNombre (++ "dios del trueno").modificarDerrotas (take 0) $ unPersonaje
 |otherwise = unPersonaje

es:: String -> Personaje -> Bool
es unNombre unPersonaje = unNombre == (nombre unPersonaje)

gemaDelAlma :: Int -> Equipamiento
gemaDelAlma unAnio unPersonaje
 |es "Thanos" unPersonaje = modificarDerrotas (++ derrotasInfinitas unAnio) unPersonaje
 |otherwise = unPersonaje

derrotasInfinitas :: Int-> [Derrota]
derrotasInfinitas unAnio = zip (map (derrotasExtra unAnio) [1..]) (iterate (+1) unAnio)

derrotasExtra :: Int -> Int -> String
derrotasExtra unAnio unNumero  = "extra numero " ++ show unNumero

thanos :: Personaje
thanos = UnPersonaje {
  nombre = "Thanos",
  cantidadDePoder = 1000,
  derrotas = [],
  equipamiento = []
}

guanteleteInfinito :: Personaje -> Personaje
guanteleteInfinito unPersonaje = foldr ($) unPersonaje (equipamiento (gemasDelInfinito unPersonaje))

gemasDelInfinito :: Personaje -> Personaje
gemasDelInfinito unPersonaje = modificarEquipamiento (filter (esGemaDelInfinito)) unPersonaje-}

{-
a- No va a devolver nada, pues no se conoce el tamaño de la lista

b- Va a funcionar siempre y cuando alguna de sus derrotas sea Hijo de Tanos, con que una ya pertenezca deja de evaluar esa lista por la evaluacion perezosa

c- Sí se puede porque por lazy evaluation toma los primeros 100 y desecha lo q quede de la lista, no la sigue evaluando
-}