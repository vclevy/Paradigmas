import Text.Show.Functions
import Data.Char


data Persona = UnaPersona {
    habilidades :: [Habilidad],
    sonBuenas :: Bool
} deriving (Show, Eq)

pepe :: Persona
pepe = UnaPersona ["comer", "dormir"] True

skull :: Persona
skull = UnaPersona ["mimir", "hola"] True

bulk :: Persona
bulk = UnaPersona ["matar"] False

modificarHabilidades :: ([Habilidad]->[Habilidad]) -> Persona -> Persona
modificarHabilidades unaFuncion unaPersona = unaPersona {habilidades = unaFuncion.habilidades $ unaPersona}

data PowerRanger = UnPowerRanger{
    color :: String,
    habilidadesPR :: [Habilidad],
    nivelDePelea :: Int
} deriving (Show, Eq)

type Habilidad = String

convertirEnPowerRanger :: String -> Persona -> PowerRanger
convertirEnPowerRanger unColor unaPersona = 
  UnPowerRanger {color = unColor, 
  habilidadesPR = superHabilidades unaPersona, 
  nivelDePelea = length (concat (habilidades unaPersona)) }

superHabilidades :: Persona -> [Habilidad]
superHabilidades unaPersona = habilidades (modificarHabilidades (map anadirSuper) unaPersona)

anadirSuper :: Habilidad -> Habilidad 
anadirSuper unaHabilidad = "super" ++ [toUpper (head unaHabilidad)] ++ drop 1 unaHabilidad

formarEquipoRanger :: [String] -> [Persona] -> [PowerRanger]
formarEquipoRanger unosColores unasPersonas = zipWith convertirEnPowerRanger unosColores (personasBuenas unasPersonas)

personasBuenas :: [Persona] -> [Persona]
personasBuenas = filter sonBuenas

instance Ord PowerRanger where
    compare r1 r2 = compare (nivelDePelea r1) (nivelDePelea r2)

rangerMasPoderoso :: [PowerRanger] -> PowerRanger
rangerMasPoderoso unosRangers = foldr1 max unosRangers

alfa5 :: PowerRanger
alfa5 = UnPowerRanger "metalico" ["reparar cosas", "decir " ++ infinitosAy] 0

infinitosAy :: Habilidad
infinitosAy = cycle "ay "