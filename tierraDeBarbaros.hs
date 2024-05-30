import Text.Show.Functions
import Data.Char

data Barbaro = UnBarbaro {
    nombre :: String,
    fuerza :: Int,
    habilidades :: [Habilidad],
    objetos :: [Objeto]
} deriving (Show)

type Habilidad = String
type Objeto = Barbaro -> Barbaro

modificarFuerza :: (Int->Int) -> Barbaro -> Barbaro
modificarFuerza unaFuncion unBarbaro = unBarbaro {fuerza = unaFuncion.fuerza $ unBarbaro}

modificarObjetos :: ([Objeto]->[Objeto]) -> Barbaro -> Barbaro
modificarObjetos unaFuncion unBarbaro = unBarbaro {objetos = unaFuncion.objetos $ unBarbaro}

modificarHabilidades :: ([Habilidad]->[Habilidad]) -> Barbaro -> Barbaro
modificarHabilidades unaFuncion unBarbaro = unBarbaro {habilidades = unaFuncion.habilidades $ unBarbaro}

espadas :: Int -> Objeto
espadas pesoEspada = modificarFuerza (+ (2*pesoEspada)) --point free

amuletosMisticos :: Habilidad -> Objeto
amuletosMisticos unaHabilidad unBarbaro = modificarHabilidades (++ [unaHabilidad]) unBarbaro

varitasDefectuosas :: Objeto
varitasDefectuosas = modificarHabilidades (++ ["hacer Magia"]).modificarObjetos (take 0) -- point free

ardilla:: Objeto
ardilla unBarbaro = unBarbaro -- tambien puede ser ardilla unBarbaro = id (el id no hace nada)

cuerda:: Objeto -> Objeto -> Objeto
cuerda unObjeto otroObjeto = unObjeto.otroObjeto

megafono :: Objeto
megafono = modificarHabilidades (ponerEnMayuscula.concatenarHabilidades) 

concatenarHabilidades :: [Habilidad] -> [Habilidad]
concatenarHabilidades habilidadesDeBarbaro = [concat habilidadesDeBarbaro]

ponerEnMayuscula :: [Habilidad] -> [Habilidad]
ponerEnMayuscula =  map (map toUpper)

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono

type Evento = Barbaro->Bool
type Aventura = [Evento]

invasionDeSuciosDuendes :: Evento
invasionDeSuciosDuendes = sabeEscribirPoesiaAtroz

sabeEscribirPoesiaAtroz :: Evento
sabeEscribirPoesiaAtroz = tieneHabilidad "Escribir Poesía Atroz"

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad unaHabilidad unBarbaro = elem unaHabilidad (habilidades unBarbaro)

cremalleraDelTiempo :: Evento
cremalleraDelTiempo = noTienePulgares

noTienePulgares :: Evento
noTienePulgares unBarbaro = seLlama "Faffy" unBarbaro || seLlama "Astro" unBarbaro

seLlama :: String -> Barbaro -> Bool
seLlama unNombre unBarbaro = nombre unBarbaro == unNombre

ritualDeFechorias :: [Evento]->Evento
ritualDeFechorias eventos unBarbaro = any (\evento -> evento unBarbaro) eventos

saqueo :: Evento
saqueo unBarbaro= sabeRobar unBarbaro && tieneMasDeXFuerza 80 unBarbaro

sabeRobar :: Barbaro -> Bool
sabeRobar = tieneHabilidad "Robar"

tieneMasDeXFuerza :: Int -> Barbaro -> Bool
tieneMasDeXFuerza unNumero unBarbaro = fuerza unBarbaro > unNumero

gritoDeGuerra :: Evento
gritoDeGuerra unBarbaro = poderDeGritoDeGuerra unBarbaro >= 4* length (objetos unBarbaro)

poderDeGritoDeGuerra :: Barbaro -> Int
poderDeGritoDeGuerra unBarbaro = length (concatenarHabilidades (habilidades unBarbaro))

caligrafia :: Evento
caligrafia unBarbaro = contienenMasDe3Vocales (habilidades unBarbaro) && comienzanEnMayuscula (habilidades unBarbaro)

contienenMasDe3Vocales :: [Habilidad] -> Bool
contienenMasDe3Vocales habilidadesDeBarbaro = all (>3) (map contarVocales habilidadesDeBarbaro) 

contarVocales :: String -> Int
contarVocales = length . filter (`elem` "aeiouAEIOU")

comienzanEnMayuscula :: [Habilidad] -> Bool
comienzanEnMayuscula habilidadesDeBarbaro = all isUpper (map head habilidadesDeBarbaro)

sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes listaDeBarbaros unaAventura = filter (siSobrevive unaAventura) listaDeBarbaros

siSobrevive :: Aventura -> Barbaro -> Bool
siSobrevive unaAventura unBarbaro = all (\evento -> evento unBarbaro) unaAventura

sinRepetidos :: [Habilidad] -> [Habilidad]
sinRepetidos [] = []
sinRepetidos (cabeza:cola) = cabeza : sinRepetidos (filter (/= cabeza) cola)

modificarNombre :: (String->String) -> Barbaro -> Barbaro
modificarNombre unaFuncion unBarbaro = unBarbaro {nombre = unaFuncion.nombre $ unBarbaro}

descendiente :: Barbaro -> Barbaro
descendiente unBarbaro = utilizarObjetos.modificarNombre(++ "*").modificarHabilidades sinRepetidos $ unBarbaro

utilizarObjetos :: Barbaro -> Barbaro
utilizarObjetos unBarbaro = foldr ($) unBarbaro (objetos unBarbaro)

descendientes :: Barbaro -> [Barbaro]
descendientes unBarbaro = iterate descendiente unBarbaro