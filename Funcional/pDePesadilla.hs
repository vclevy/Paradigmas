{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}
import Text.Show.Functions

data Persona = UnaPersona{
    nombre :: String,
    recuerdos :: [Recuerdo]
}deriving(Show,Eq)

type Recuerdo = String

suki :: Persona
suki = UnaPersona {
	nombre = "Susana Kitimporta",
	recuerdos = ["abuelita", "escuela primaria", "examen aprobado","novio"]}

modificarRecuerdos :: ([Recuerdo]-> [Recuerdo])-> Persona -> Persona
modificarRecuerdos modificador unaPersona = unaPersona{recuerdos = (modificador.recuerdos)unaPersona}

asignar :: Int->Int->[Recuerdo] -> [Recuerdo]
asignar unaPosicion unRecuerdo listaRecuerdos = ((listaRecuerdos !! unRecuerdo:).take (unaPosicion-1))listaRecuerdos ++  drop (unaPosicion+1) listaRecuerdos

pesadillaDeMovimiento :: Int -> Int -> Persona -> Persona
pesadillaDeMovimiento unRecuerdo otroRecuerdo  = modificarRecuerdos (asignar unRecuerdo otroRecuerdo . asignar otroRecuerdo unRecuerdo) 

posicionDelRecuerdo :: Recuerdo -> Persona -> Int
posicionDelRecuerdo recuerdo = length.takeWhile (/= recuerdo). recuerdos

pesadillaDeSustitucion :: Int -> Recuerdo -> Persona -> Persona
pesadillaDeSustitucion posicion recuerdo unaPersona = modificarRecuerdos (asignar posicion (posicionDelRecuerdo recuerdo unaPersona)) unaPersona

pesadillaDesmemorizadora :: Recuerdo -> Persona -> Persona
pesadillaDesmemorizadora unRecuerdo =  modificarRecuerdos (filter (/= unRecuerdo))

pesadillaEspejo :: Persona -> Persona 
pesadillaEspejo = modificarRecuerdos reverse 

nop :: Persona -> Persona
nop unaPersona = unaPersona

type Pesadilla = Persona -> Persona

dormir :: [Pesadilla] -> Persona -> Persona
dormir lasPesadillas unaPersona = foldl (flip($)) unaPersona lasPesadillas

nuevaPesadilla :: Persona -> Persona
nuevaPesadilla = modificarRecuerdos (map (\x -> x ++ "de la muerte"))

-- Situaciones excepcionales

esPesadilla :: Persona -> Pesadilla -> Bool
esPesadilla unaPersona unSueño = unSueño unaPersona /= unaPersona

segmentationFault :: Situacion
segmentationFault unaNoche unaPersona = length(filter (esPesadilla unaPersona) unaNoche) > length (recuerdos unaPersona)

aplicarPrimeraPesadilla :: Persona -> [Pesadilla] -> Persona
aplicarPrimeraPesadilla unaPersona unaNoche= (head.filter (esPesadilla unaPersona)) unaNoche unaPersona 

bugInicial :: Situacion
bugInicial unaNoche unaPersona = take 1 ((recuerdos.aplicarPrimeraPesadilla unaPersona) unaNoche) /= take 1 (recuerdos unaPersona)

falsaAlarma :: Situacion
falsaAlarma unaNoche unaPersona = last unaNoche unaPersona == unaPersona

deteccionesSituacion :: Situacion ->[Pesadilla] -> [Persona] ->Int
deteccionesSituacion situacion unaNoche = length. filter (situacion unaNoche) 

type Situacion = ([Pesadilla]->Persona -> Bool)

unaSituacionEnTodas :: [Pesadilla] -> [Persona] -> Situacion ->  Bool
unaSituacionEnTodas unaNoche grupo situacion = all (situacion unaNoche)  grupo

algunaSituacionEnTodos :: [Situacion] -> [Pesadilla] -> [Persona] -> Bool
algunaSituacionEnTodos situaciones unaNoche grupo = any (unaSituacionEnTodas unaNoche grupo) situaciones

-- Dado que para saber si una falsa alarma necesitamos conocer el ultimo elemento de la lista, en una 
--lista infinta no podemos conocer dicho elemento. En el caso de bug inicial, podriamos conocer el 
--resultado ya que por su estrategia peresoza de evaluacion al encontrar la primera pesadilla ya da 
--un resultado