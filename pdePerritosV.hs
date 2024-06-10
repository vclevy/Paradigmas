import Text.Show.Functions

data Perro= UnPerro{
    raza :: Raza,
    juguetesFavoritos :: [Juguete],
    tiempoDePermanencia :: TiempoDePermanencia,
    energia :: Energia
} deriving Show

type Raza = String
type Juguete = String
type TiempoDePermanencia = Int
type Energia = Int

data Guarderia = UnaGuarderia{
    nombre :: Nombre,
    rutina :: Rutina
}

type Nombre = String
type Rutina = [Actividad]

data Actividad = UnaActividad {
    ejercicio :: Ejercicio,
    duracion :: Duracion
}
type Ejercicio = Perro -> Perro
type Duracion = Int

modificarEnergia :: (Energia->Energia) -> Perro -> Perro
modificarEnergia unaFuncion unPerro = unPerro {energia = max 0.unaFuncion.energia $ unPerro}

modificarJuguetes :: ([Juguete]->[Juguete]) -> Perro -> Perro
modificarJuguetes unaFuncion unPerro = unPerro {juguetesFavoritos = unaFuncion.juguetesFavoritos $ unPerro}

jugar :: Ejercicio 
jugar unPerro = modificarEnergia (subtract 10) unPerro

type Ladrido = Int

ladrar :: Ladrido -> Ejercicio
ladrar cantidadLadridos unPerro = modificarEnergia (+(div cantidadLadridos 2)) unPerro

regalar :: Juguete -> Ejercicio
regalar unJuguete unPerro = modificarJuguetes (unJuguete:) unPerro

diaDeSpa :: Ejercicio
diaDeSpa unPerro 
 |tiempoDePermanencia unPerro >= 50 || esDeRazaExtravagante unPerro = modificarEnergia (const 100).modificarJuguetes ("peine de goma":) $ unPerro
 |otherwise = unPerro

esDeRazaExtravagante :: Perro -> Bool
esDeRazaExtravagante unPerro = elem (raza unPerro) razasExtravagantes

razasExtravagantes :: [String]
razasExtravagantes = ["Dalmata","pomerania"]

diaDeCampo :: Ejercicio
diaDeCampo unPerro = modificarJuguetes (drop 1).jugar $ unPerro

zara :: Perro
zara = UnPerro "Dalmata" ["Pelota", "Mantita"] 90 80

guarderiaPdePerritos :: Guarderia
guarderiaPdePerritos = UnaGuarderia "PdePerritos" [UnaActividad jugar 30,UnaActividad (ladrar 18) 20, UnaActividad (regalar "pelota") 0, UnaActividad diaDeSpa 120, UnaActividad diaDeCampo 720]

puedeEstar :: Guarderia -> Perro -> Bool
puedeEstar unaGuarderia unPerro = tiempoDePermanencia unPerro > tiempoDeRutina unaGuarderia

tiempoDeRutina :: Guarderia -> Int
tiempoDeRutina unaGuarderia = sum.map duracion.rutina $ unaGuarderia

esResponsable :: Perro -> Bool
esResponsable unPerro = (>3).length.juguetesFavoritos.diaDeCampo $ unPerro

realizarRutina :: Guarderia -> Perro -> Perro
realizarRutina unaGuarderia unPerro
 |puedeEstar unaGuarderia unPerro = realizarEjercicios unaGuarderia unPerro
 |otherwise = unPerro

realizarEjercicios :: Guarderia -> Perro -> Perro
realizarEjercicios unaGuarderia unPerro = foldr ($) unPerro (ejerciciosDeRutina unaGuarderia)

ejerciciosDeRutina :: Guarderia -> [Ejercicio]
ejerciciosDeRutina unaGuarderia = map ejercicio.rutina $ unaGuarderia

losCansaditos :: Guarderia -> [Perro] -> [Perro]
losCansaditos unaGuarderia unosPerros = filter quedaCansadito (perrosEjercitados unaGuarderia unosPerros)

quedaCansadito :: Perro -> Bool
quedaCansadito unPerro = (<5).energia $ unPerro

perrosEjercitados :: Guarderia -> [Perro] -> [Perro]
perrosEjercitados unaGuarderia unosPerros = map (realizarEjercicios unaGuarderia) unosPerros

perroPi :: Perro
perroPi = UnPerro "Labrador" soguitasInfinitas 314 159
--le puse perroPi en vez de Pi, porque sino la consola se confunde y no lo puedo mostrar

soguitasInfinitas :: [Juguete]
soguitasInfinitas = map soguita [1..]

soguita :: Int -> Juguete
soguita unNumero = "soguita " ++ show unNumero

{-
1. > esDeRazaExtravagante perroPi
Es posible saberlo, ya que la funcion esDeRazaExtravagante evalua la raza del perro que es única, y al no pertenecer a las razas extravagantes, el resultado es False.

2. a- > elem "Huesito" (juguetesFavoritos perroPi)
Ya que Haskell trabaja con Lazy Evaluation, podría llegarse a dar el caso de que el huesito esté entre los juguetes, y como la va recorriendo 1 a 1, podría tirar True. Pero en este caso
todos los juguetes son soguitas (y Haskell no puede determinar el patrón que seguirá la lista tendiendo al infinito) por lo que el programa se quedaría colgado.
   b- > elem "pelotita" (juguetesFavoritos (realizarRutina guarderiaPdePerritos perroPi))
El programa se queda colgado, porque recorre toda la lista tratando de encontrar una pelota entre sus juguetes, y no lo está porque si bien se la regalan, después pasa un día de Campo y lo pierde.
Como Haskell no sabe el patrón que sigue la lista, la recorre infinitamente.
   c- > elem "soguita 31112" (juguetesFavoritos perroPi)
La computadora sufre, pero como ese juguete pertenece a la lista, eventualmente lo encuentra

3. > realizarRutina guarderiaPdePerritos perroPi
Sí es posible, ya que las rutinas cambian el estado del perrito pero ninguna necesita evaluar por completo la lista infinita de juguetes. Lo que pasa es que modifica los atributos del perrito, pero 
nunca termina de imprimir los juguetes que tiene.

4. > regalar "hueso" perroPi
En mi caso, le agrega el juguete al principio de la lista, por lo tanto se le puede regalar cualquier juguete. Pero, similar al punto 3,
nunca termina de imprimir los jueguetes ya que son infinitos.
-}

