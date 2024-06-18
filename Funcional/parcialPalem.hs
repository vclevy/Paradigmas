import Text.Show.Functions

data Persona = Persona{
    nombre :: String,
    edad :: Float,
    felicidad :: Float,
    estres :: Float,
    guita :: Float,
    habilidades :: [Habilidad],
    limite :: Int
}deriving (Show)

losJovenesAdultos :: [Persona]->[Persona]
losJovenesAdultos = filter esJovenAdulto 

modificarFelicidad :: (Float->Float)->Persona->Persona
modificarFelicidad modificador unaPersona = unaPersona{felicidad = (modificador.felicidad) unaPersona}

modificarEstres :: (Float->Float)->Persona->Persona
modificarEstres modificador unaPersona = unaPersona{estres = (modificador.estres) unaPersona}

modificarGuita :: (Float->Float)->Persona->Persona
modificarGuita modificador unaPersona = unaPersona{guita = (modificador.guita) unaPersona}

type Habilidad = Persona -> Persona

cocinar :: Habilidad
cocinar = modificarFelicidad (+5).modificarEstres(subtract 4)

tieneMuchaGuita :: Persona -> Bool
tieneMuchaGuita unaPersona = guita unaPersona > 60

tenerMascota :: Habilidad
tenerMascota unaPersona
    | tieneMuchaGuita unaPersona = (modificarEstres (subtract 10).modificarFelicidad (+20). modificarGuita (subtract 5)) unaPersona
    | otherwise = (modificarEstres (+5).modificarFelicidad (+20). modificarGuita (subtract 5)) unaPersona

trabajarEn :: String -> Habilidad
trabajarEn trabajo unaPersona
    | trabajo == "Software" = (modificarGuita(+20).modificarEstres(+10)) unaPersona
    | trabajo == "Docencia" = modificarEstres (+30) unaPersona
    | otherwise = (modificarGuita (+5). modificarEstres (+5)) unaPersona

tieneMasGuita :: Persona -> Persona -> Bool
tieneMasGuita unaPersona otraPersona = guita unaPersona > guita otraPersona

estresCompartido :: Persona -> Persona -> Float
estresCompartido unaPersona otraPersona= abs (estres unaPersona-estres otraPersona)/2 

compartirCasa :: Persona -> Habilidad
compartirCasa unaPersona otraPersona 
    | unaPersona `tieneMasGuita` otraPersona = (modificarEstres(+ estresCompartido unaPersona otraPersona).modificarFelicidad(+5)) unaPersona
    | otherwise = (modificarEstres(+ estresCompartido unaPersona otraPersona).modificarFelicidad(+5).modificarGuita(+10)) unaPersona

esNino :: Persona -> Bool
esNino = (<=18).edad

esGrande :: Persona -> Bool
esGrande = (>=30).edad

esJovenAdulto :: Persona -> Bool
esJovenAdulto unaPersona = edad unaPersona >18 && edad unaPersona < 30

limiteHabilidades :: Persona -> Int
limiteHabilidades unaPersona
    | esNino unaPersona = 3
    | esJovenAdulto unaPersona = 6
    | esGrande unaPersona = 4

aumenta :: (Persona->Float) -> Habilidad -> Persona -> Bool
aumenta criterio habilidad unaPersona = (criterio.habilidad) unaPersona > criterio unaPersona 

valeLaPena :: Habilidad -> Persona -> Bool
valeLaPena unaHabilidad unaPersona = aumenta felicidad unaHabilidad unaPersona || aumenta guita unaHabilidad unaPersona

lasQuePuede :: [Habilidad] -> Persona -> [Habilidad]
lasQuePuede lasHabilidades unaPersona = take (limiteHabilidades unaPersona - length(habilidades unaPersona)) lasHabilidades

aprenderHabilidades :: [Habilidad]-> Persona -> Persona
aprenderHabilidades lasHabilidades unaPersona = foldl (flip($)) unaPersona lasHabilidades

modificarHabilidades ::([Habilidad]->[Habilidad])->Persona->Persona
modificarHabilidades modificador unaPersona = unaPersona{habilidades = (modificador.habilidades) unaPersona}

cursoIntensivo :: [Habilidad]->Persona->Persona
cursoIntensivo lasHabilidades unaPersona = (aprenderHabilidades (lasQuePuede lasHabilidades unaPersona) .modificarHabilidades (lasQuePuede lasHabilidades unaPersona++)) unaPersona

modificarLimite::(Int->Int)->Persona->Persona
modificarLimite modificador unaPersona = unaPersona{limite = (modificador.limite) unaPersona}

modificarEdad::(Float->Float)->Persona->Persona
modificarEdad modificador unaPersona = unaPersona{edad = (modificador.edad) unaPersona}

felizCumple :: Persona ->Persona
felizCumple unaPersona = (modificarLimite (+(-limite unaPersona+limiteHabilidades unaPersona)).modificarEdad(+1)) unaPersona

