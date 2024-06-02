import Text.Show.Functions

data Animal = UnAnimal{
    iq :: Int,
    especie :: String,
    capacidades :: [Capacidad]
} deriving (Show)

type Capacidad = String
type Transformacion = Animal -> Animal

modificarIq :: (Int->Int) -> Animal -> Animal
modificarIq unaFuncion unAnimal = unAnimal {iq= unaFuncion.iq $ unAnimal}

modificarEspecie :: (String->String) -> Animal -> Animal
modificarEspecie unaFuncion unAnimal = unAnimal {especie= unaFuncion.especie $ unAnimal}

modificarCapacidades :: ([Capacidad]->[Capacidad]) -> Animal -> Animal
modificarCapacidades unaFuncion unAnimal = unAnimal {capacidades= unaFuncion.capacidades $ unAnimal}

inteligenciaSuperior :: Int -> Transformacion
inteligenciaSuperior coeficiente = modificarIq (+coeficiente)

pinkificar :: Transformacion
pinkificar = modificarCapacidades (take 0)

superpoderes :: Transformacion
superpoderes unAnimal 
    | siEs "elefante" unAnimal = modificarCapacidades ("no tenerle miedo a los ratones":) unAnimal
    | siEs "raton" unAnimal && iq unAnimal > 100 = modificarCapacidades ("hablar":) unAnimal
    | otherwise = unAnimal


siEs :: String -> Animal -> Bool
siEs unaEspecie unAnimal = unaEspecie == especie unAnimal

type Criterio = Animal -> Bool

tieneHabilidad :: String -> Criterio
tieneHabilidad unaHabilidad unAnimal = elem unaHabilidad (capacidades unAnimal)

esAntropomorfico :: Criterio
esAntropomorfico unAnimal= tieneHabilidad "hablar" unAnimal && iq unAnimal > 60

noTanCuerdo :: Criterio
noTanCuerdo unAnimal = (>2).length.filter pinkiesco.capacidades 

pinkiesco :: Capacidad -> Bool
pinkiesco unaCapacidad = take 6 unaCapacidad == "hacer " && esPalabraPinkiesca (drop 6 unaCapacidad)

esPalabraPinkiesca :: String -> Bool
esPalabraPinkiesca unaPalabra = length unaPalabra > 4 && tieneVocales unaPalabra

tieneVocales :: String -> Bool
tieneVocales unaPalabra = any esVocal unaPalabra

esVocal :: Char -> Bool
esVocal c = c `elem` "aeiouAEIOUáéíóúÁÉÍÓÚ"

type Experimento = ([Transformacion], Criterio)

transformaciones :: Experimento -> [Transformacion]
transformaciones unExperimento = fst unExperimento

criterioExperimento :: Experimento -> Criterio
criterioExperimento unExperimento = snd unExperimento

experimentoExitos :: Experimento -> Animal -> Bool
experimentoExitos unExperimento unAnimal = criterioExperimento unExperimento (aplicarTransformaciones unExperimento unAnimal) 
--experimentoExitos unExperimento unAnimal = foldr ($) unAnimal (transformaciones unExperimento) otra forma

aplicarTransformaciones :: Experimento -> Animal -> Animal
aplicarTransformaciones unExperimento unAnimal = foldl (\animal trans-> trans animal) unAnimal (transformaciones unExperimento)

raton :: Animal
raton = UnAnimal {
    iq = 17,
    especie = "Ratón",
    capacidades = ["Destruenglonir el mundo", "Hacer planes desalmados"]
}
experimento1 :: Experimento
experimento1 = ([pinkificar, inteligenciaSuperior 10,superpoderes], esAntropomorfico)
-- experimentoExitos experimento1 raton

generarInformeDe :: (Animal -> b) -> [Animal] -> (Animal -> Animal) -> [b]
generarInformeDe unCampo unosAnimales funcionModificadora = 
  map (unCampo . funcionModificadora) unosAnimales

listaDeCoefsInts :: [Animal] -> [Capacidad] -> Experimento -> [Int]
listaDeCoefsInts unosAnimales unasCapacidades unExperimento = 
 map iq (tieneAlgunaHabilidad unasCapacidades.animalesExperimentados unExperimento $ unosAnimales)


animalesExperimentados :: Experimento -> [Animal] -> [Animal]
animalesExperimentados unExperimento unosAnimales = map (aplicarTransformaciones unExperimento) unosAnimales

animalTieneCapacidad :: Animal -> [Capacidad] -> Bool
animalTieneCapacidad unAnimal unasCapacidades = any (`elem` unasCapacidades) (capacidades unAnimal)

tieneAlgunaHabilidad :: [Capacidad] -> [Animal] -> [Animal]
tieneAlgunaHabilidad unasCapacidades unosAnimales = filter (`animalTieneCapacidad` unasCapacidades) unosAnimales

--7.  Generar todas las posibles palabras pinkiescas. Pistas:
--generateWordsUpTo, que toma una longitud y genera una lista con todas las posibles palabras de hasta la longitud dada.
--generateWords que toma una longitud y genera una lista de palabras donde todas tienen exactamente la longitud dada. 

generateWordsUpTo 