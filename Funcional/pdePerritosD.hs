import Text.Show.Functions

data Perro = Perro{
    raza :: String,
    juguetes :: [String],
    tiempoEnGuarderia :: Int,
    energia :: Int
}deriving (Show)

type Ejercicio = Perro -> Perro

type Actividad = (Ejercicio,Int)

data Guarderia = Guarderia{
    rutina :: [Actividad],
    nombre :: String
}deriving(Show)

modificarEnergia :: (Int->Int) -> Perro-> Perro
modificarEnergia modificador unPerro = unPerro {energia = (modificador.energia)unPerro}

modificarJuguetes :: ([String]->[String]) -> Perro-> Perro
modificarJuguetes modificador unPerro = unPerro {juguetes = (modificador.juguetes)unPerro}

jugar :: Ejercicio
jugar unPerro = modificarEnergia ((subtract.max 0 )(energia unPerro - 10)) unPerro

ladrar :: Int -> Ejercicio
ladrar ladridos = modificarEnergia(+ div ladridos 2)

regalar :: String -> Ejercicio
regalar unJuguete = modificarJuguetes (unJuguete:)

esRaza :: String -> Perro -> Bool
esRaza unaRaza unPerro = raza unPerro == unaRaza

esRazaExtravagante :: Perro -> Bool
esRazaExtravagante unPerro = esRaza "dalmata" unPerro || esRaza "pomerania" unPerro

diaDeSpa :: Ejercicio
diaDeSpa unPerro
    | tiempoEnGuarderia unPerro>50 || esRazaExtravagante unPerro = modificarEnergia (+(-energia unPerro +100)) unPerro
    | otherwise = unPerro

diaDeCampo :: Ejercicio
diaDeCampo = modificarJuguetes (drop 1)

zara :: Perro
zara = Perro "dalmata" ["pelota","manzanita"] 90 80

guarderiaPdePerritos :: Guarderia
guarderiaPdePerritos = Guarderia [(jugar,30),(ladrar 18,20),(regalar "pelota",0),(diaDeSpa,120),(diaDeCampo,720)] "P de Perritos"

tiempoRutina :: Guarderia -> Int
tiempoRutina = sum.(map snd.rutina)

losEjercicios :: Guarderia -> [Ejercicio]
losEjercicios = map fst.rutina

puedeEstar :: Guarderia -> Perro -> Bool
puedeEstar unaGuarderia unPerro = tiempoEnGuarderia unPerro > tiempoRutina unaGuarderia

responsables :: [Perro]->[Perro]
responsables = filter ((3<).length.juguetes.diaDeCampo)  

hacerRutina :: Guarderia -> Perro -> Perro
hacerRutina unaGuarderia unPerro
    | puedeEstar unaGuarderia unPerro = foldl (flip($)) unPerro (losEjercicios unaGuarderia)
    | otherwise = unPerro

sogasInfinitas :: [String]
sogasInfinitas = map ("soga" ++) sogas

sogas :: [String]
sogas = map show [1..]

pi :: Perro
pi = Perro "labrador" sogasInfinitas 314 159 

{-¿Sería posible saber si Pi es de una raza extravagante?
Si, debido a que la funcion esRazaExtravagante toma unicamente el nombre, sin importar la lista de juguetes
¿Qué pasa si queremos saber si Pi tiene…
… algún huesito como juguete favorito? 
si tiene el juguete, la funcion devuelve true sin necesidad de llegar el final, en caso de no tenerlo la funcion no devuelve nada
… alguna pelota luego de pasar por la Guardería de Perritos?
lo mismo que la funcion anterior
… la soguita 31112?
devuelve true ya que al haber infinitas, esa soga esparte de los juguetes
¿Es posible que Pi realice una rutina?
puede hacerla
¿Qué pasa si le regalamos un hueso a Pi?
se agrega el hueso al inicio de la lista de juguetes favoritos
-}