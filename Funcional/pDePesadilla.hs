import Text.Show.Functions

data Persona = UnaPersona{
    nombre :: String,
    recuerdos :: [Recuerdo]
}deriving(Show)

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
