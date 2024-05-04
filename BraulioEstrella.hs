import Text.Show.Functions
--git add . se pone lindo para la foto,git commit -m "Nombre expresivo del commit" saco la foto
-- git add git commit git push origin HEAD
data Personaje = UnPersonaje{
    nombre :: String,
    poderBasico :: PoderBasico,
    superPoder :: SuperPoder,
    superPoderActivo :: Bool,
    cantidadDeVida :: Int
} deriving Show

type PoderBasico = Personaje -> Personaje
type SuperPoder = Personaje -> Personaje

--bolaEspinosa :: PoderBasico 
--bolaEspinosa unPersonaje = cantidadDeVida unPersonaje - 1000 ESTÁ MAL, PORQ NO DEVUELVE UN PERSONAJE

espina :: Personaje
espina = UnPersonaje "Espina" bolaEspinosa  (granadaDeEspinas 5) True 4800

bolaEspinosa :: PoderBasico 
bolaEspinosa unPersonaje = unPersonaje {cantidadDeVida = max (cantidadDeVida unPersonaje - 1000) 0}

-- cota minima max, cota maxima min

lluviaDeTuercas :: String -> PoderBasico
-- tmb puede ser lluviaDeTuercas :: String -> Personaje -> Personaje
lluviaDeTuercas tipoDeTuerca unPersonaje
    |tipoDeTuerca == "Sanadora" = unPersonaje {cantidadDeVida= cantidadDeVida unPersonaje + 800}
    |tipoDeTuerca == "Dañina" = unPersonaje {cantidadDeVida= cantidadDeVida unPersonaje `div` 2}
    |otherwise = unPersonaje

-- OTRA FORMA lluviaDeTuercas :: String -> PoderBasico
-- lluviaDeTuercas "Sanadora" unPersonaje = unPersonaje {cantidadDeVida= modificarVida (+800) unPersonaje}
-- lluviaDeTuercas "Dañina" unPersonaje = unPersonaje {cantidadDeVida= cantidadDeVida unPersonaje `div` 2}
-- lluviaDeTuercas _ unPersonaje = unPersonaje ES PREFERIBLE USAR ESTO ANTES Q LAS GUARDAS!

pamela :: Personaje
pamela = UnPersonaje "Pamela" (lluviaDeTuercas "Sanadora") torretaCurativa False 9600

modificarVida :: (Int->Int) -> Personaje -> Personaje
modificarVida unaFuncion unPersonaje = unPersonaje {cantidadDeVida = unaFuncion (cantidadDeVida unPersonaje)}
-- lluviaDeTuercas "Sanadora" unPersonaje = modificarVida (+800) unPersonaje

granadaDeEspinas:: Int -> SuperPoder
granadaDeEspinas radioDeExplosion unPersonaje 
    | radioDeExplosion>3 && cantidadDeVida unPersonaje < 800 = 
  unPersonaje {nombre = nombre unPersonaje ++ " Espina Estuvo Aqui", cantidadDeVida = 0, superPoderActivo = False}
    | radioDeExplosion>3 = unPersonaje {nombre = nombre unPersonaje ++ " Espina Estuvo Aqui"}
    | otherwise = bolaEspinosa unPersonaje 

torretaCurativa:: SuperPoder
torretaCurativa unPersonaje = unPersonaje {superPoderActivo = True, cantidadDeVida = (cantidadDeVida unPersonaje) *2}

atacarConElPoderEspecial :: Personaje -> Personaje
atacarConElPoderEspecial unPersonaje
    | superPoderActivo unPersonaje = ataqueSuperYBasico unPersonaje
    | otherwise = unPersonaje

ataqueSuperYBasico :: Personaje -> Personaje
ataqueSuperYBasico unPersonaje = (poderBasico unPersonaje.superPoder unPersonaje) unPersonaje

quienesEstanEnLasUltimas :: [Personaje] -> [Personaje]
quienesEstanEnLasUltimas listaDePersonajes = filter esMenorA800 listaDePersonajes

esMenorA800 :: Personaje -> Bool
esMenorDe800 unPersonaje = cantidadDeVida unPersonaje < 800
