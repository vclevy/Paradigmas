import Text.Show.Functions

--hola!!, salto del papu chau!

data Elemento = UnElemento { 
tipo :: String,
ataque :: (Personaje-> Personaje),
defensa :: (Personaje-> Personaje) 
    } deriving (Show)

daniel :: Personaje
daniel = UnPersonaje "Daniel" 27 [maldad] 1999

maldad:: Elemento
maldad = UnElemento "Maldad" (mandarAlAnio 1) (mandarAlAnio 2) 

data Personaje = UnPersonaje { 
nombre :: String,
salud :: Float,
elementos :: [Elemento],
anioPresente :: Int 
    } deriving(Show)

-- PUNTE UNE
type Efecto = Personaje -> Personaje

modificarAnio :: (Int->Int)-> Efecto
modificarAnio unaFuncion unPersonaje = unPersonaje {anioPresente = unaFuncion (anioPresente unPersonaje)}

modificarSalud :: (Float->Float) -> Efecto
modificarSalud unaFuncion unPersonaje = unPersonaje {salud = unaFuncion (salud unPersonaje)}

mandarAlAnio :: Int-> Efecto
mandarAlAnio anioIndicado unPersonaje = unPersonaje {anioPresente = anioIndicado} 

meditar :: Efecto
meditar unPersonaje = modificarSalud (+(1/2)*(salud unPersonaje)) unPersonaje

causarDanio :: Float -> Efecto
causarDanio danioQuerido = modificarSalud (max 0. subtract danioQuerido)

------------ Punte des ---------

esMalvado :: Personaje -> Bool
esMalvado = tieneElElementoTipo "Maldad" 

tieneElElementoTipo :: String -> Personaje -> Bool
tieneElElementoTipo tipoElemento unPersonaje = any ((==tipoElemento).tipo) (elementos unPersonaje)

danioQueProduce :: Personaje -> Elemento -> Float 
danioQueProduce unPersonaje unElemento = salud unPersonaje - saludDespuesDelAtaque unPersonaje unElemento 

saludDespuesDelAtaque :: Personaje -> Elemento -> Float 
saludDespuesDelAtaque unPersonaje unElemento = salud .(ataque unElemento) $ unPersonaje

type Enemigo = Personaje

enemigosMortales :: Personaje -> [Enemigo] -> [Enemigo]
enemigosMortales unPersonaje losEnemigos = filter (mataConUnElemento unPersonaje) losEnemigos

mataConUnElemento :: Personaje -> Enemigo -> Bool
mataConUnElemento unPersonaje unEnemigo = any (0==) (map (saludDespuesDelAtaque unPersonaje) (elementos unEnemigo))

-- Punte tre

concentracion :: Int -> Elemento
concentracion nivelIndicado = UnElemento {tipo = "Magia", defensa = foldr1 (.) (replicate nivelIndicado meditar), ataque = id}

esbirro :: Elemento
esbirro = UnElemento "Maldad" (causarDanio 1) id

type Esbirro = Elemento

esbirrosMalvados :: Int -> [Esbirro]
esbirrosMalvados cantEsbirros = replicate cantEsbirros esbirro

jack :: Personaje
jack = UnPersonaje {
    salud = 300,
    nombre = "Jack",
    elementos = [concentracion 3, katanaMagica],
    anioPresente = 200
}

katanaMagica :: Elemento
katanaMagica = UnElemento "Magia" (causarDanio 1000) id

{-aku :: Int -> Float -> Personaje
aku anioEnElQueVive saludAku = UnPersonaje {
    nombre = id,
    salud = id,
    elementos = [concentracion 4, esbirrosMalvados (100 * anioEnElQueVive), portalAlFuturo],
    anioPresente = id}

portalAlFuturo :: Elemento
portalAlFuturo = UnElemento "Magia" (modificarAnio (+2800)) generarNuevoAku 

generarNuevoAku :: Personaje -> Personaje
generarNuevoAku unPersonaje = (modificarAnio (+2800) unPersonaje) {salud = salud unPersonaje} -}

luchar :: Personaje -> Personaje -> (Personaje->Personaje)
luchar unPersonaje otroPersonaje = 


--SERIE DE MIERDA