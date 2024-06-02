import Text.Show.Functions

data Participante = UnParticipante{
    nombre :: String,
    trucosDeCocina :: [Truco],
    especialidad :: Plato
}  

pepeRonccino :: Participante
pepeRonccino = UnParticipante "Pepe Ronccino" [darSabor 2 5] platoDePepe

platoDePepe :: Plato
platoDePepe = UnPlato 10 [("Sal", 100),("Sal", 100),("Sal", 100),("Sal", 100),("Sal", 100),("Sal", 100)]
type Truco = Plato -> Plato 

data Plato = UnPlato{
    dificultad :: Int,
    componentes :: [Componente]
} deriving Show

type Componente = (String, Int)

pesoDeComponente :: Componente -> Int
pesoDeComponente unComponente = snd unComponente
 
nombreDeComponente :: Componente -> String
nombreDeComponente unComponente = fst unComponente

modificarNombre :: (String -> String) -> Participante -> Participante
modificarNombre unaFuncion unParticipante = unParticipante {nombre = unaFuncion.nombre $ unParticipante}

modificarEspecialidad :: (Plato -> Plato) -> Participante -> Participante
modificarEspecialidad unaFuncion unParticipante = unParticipante {especialidad = unaFuncion.especialidad $ unParticipante}

modificarTrucos :: ([Truco] -> [Truco]) -> Participante -> Participante
modificarTrucos unaFuncion unParticipante = unParticipante {trucosDeCocina = unaFuncion.trucosDeCocina $ unParticipante}

modificarDificultad :: (Int -> Int) -> Plato -> Plato
modificarDificultad unaFuncion unPlato = unPlato {dificultad = unaFuncion.dificultad $ unPlato}

modificarComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
modificarComponentes unaFuncion unPlato = unPlato {componentes = unaFuncion.componentes $ unPlato}

endulzar :: Int->Truco
endulzar gramosDeAzucar = modificarComponentes (("Azucar",gramosDeAzucar):) 

salar :: Int->Truco
salar gramosDeSal = modificarComponentes (("Sal",gramosDeSal):) 
 
darSabor :: Int->Int->Truco
darSabor gramosDeSal gramosDeAzucar = salar gramosDeSal.endulzar gramosDeAzucar

duplicarPorcion :: Truco
duplicarPorcion unPlato = modificarComponentes (map duplicarComponente) unPlato

duplicarComponente :: Componente -> Componente
duplicarComponente (nombre, peso) = (nombre, peso * 2)

simplificar :: Truco
simplificar unPlato 
 |esComplejo unPlato = modificarDificultad (const 5).modificarComponentes (filter hayMucho) $ unPlato
 |otherwise = unPlato

hayMucho :: Componente -> Bool
hayMucho unComponente = pesoDeComponente unComponente >10

esVegano :: Plato -> Bool
esVegano unPlato = not . any esProductoAnimal . componentes $ unPlato

esProductoAnimal :: Componente -> Bool
esProductoAnimal (ingrediente, _) = elem ingrediente productosAnimales

productosAnimales :: [String]
productosAnimales = ["Leche", "Carne", "Huevo", "Manteca"]

esSinTacc :: Plato -> Bool
esSinTacc = not.tiene "Harina" 

tiene :: String -> Plato -> Bool
tiene unComponente unPlato = elem unComponente (map nombreDeComponente.componentes $ unPlato)

esComplejo :: Plato -> Bool
esComplejo unPlato = length (componentes unPlato) > 5 && dificultad unPlato > 7

noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = tiene "Sal" unPlato && cantidadDe "Sal" unPlato > 2

cantidadDe :: String -> Plato -> Int
cantidadDe unIngrediente unPlato = pesoDeComponente . conseguirComponente unIngrediente $ unPlato

conseguirComponente :: String -> Plato -> Componente
conseguirComponente unIngrediente unPlato = head . filter (esDe unIngrediente) . componentes $ unPlato

esDe :: String -> Componente -> Bool
esDe unIngrediente (ingredienteDelComponente, _) = unIngrediente == ingredienteDelComponente

cocinar :: Participante -> Plato -> Plato
cocinar = aplicarTrucos 

aplicarTrucos :: Participante -> Plato -> Plato
aplicarTrucos unParticipante unPlato = foldr ($) unPlato (trucosDeCocina unParticipante)

esMejorQue :: Plato->Plato->Bool
esMejorQue unPlato otroPlato = esMasDificil unPlato otroPlato && pesaMenos unPlato otroPlato

esMasDificil :: Plato -> Plato -> Bool
esMasDificil unPlato otroPlato = dificultad unPlato > dificultad otroPlato

pesaMenos :: Plato -> Plato -> Bool
pesaMenos unPlato otroPlato = peso unPlato < peso otroPlato

peso :: Plato -> Int
peso unPlato = sum (map pesoDeComponente.componentes $ unPlato)

mejorParticipante :: Participante -> Participante -> Participante
mejorParticipante unParticipante otroParticipante
  | esMejorQue (cocinar unParticipante (especialidad unParticipante)) (cocinar otroParticipante (especialidad otroParticipante)) = unParticipante
  | otherwise = otroParticipante

participanteEstrella :: [Participante] -> Participante
participanteEstrella [unParticipante] = unParticipante
participanteEstrella (unParticipante : otrosParticipantes) =
  mejorParticipante unParticipante (participanteEstrella otrosParticipantes)

platinum :: Plato
platinum = UnPlato 10 infinitosComponentes

infinitosComponentes :: [Componente]
infinitosComponentes = zip (map ingredientesInfinitos [1..]) (iterate (+1) 1)

ingredientesInfinitos :: Int  -> String
ingredientesInfinitos unNumero  = "extra numero " ++ show unNumero

{-
A- los primeros 4 modifican al plato pero nunca se termina de imprimir, el último no lo modifica
B- esComplejo y noAptoHipertension
C- No, porque algunos trucos no funcionan con ese plato

-}