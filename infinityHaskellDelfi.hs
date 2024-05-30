{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
import Text.Show.Functions
import Data.List ( intersect )

data Personaje = Personaje {
    nombre:: String,
    poder :: Int,
    derrotas :: [Derrota],
    equipamento :: [Equipamento]
} deriving(Show)

type Derrota = (String, Int)
type Equipamento = Personaje -> Personaje

-- PARTE A

modificarPoder :: (Int->Int)-> Personaje -> Personaje
modificarPoder modificador unPersonaje = unPersonaje{poder = modificador (poder unPersonaje)}

entrenamiento :: [Personaje]-> [Personaje]
entrenamiento grupo = map (modificarPoder (*length grupo)) grupo

vencioA :: String -> Personaje -> Bool
vencioA enemigo personaje = elem enemigo (map fst (derrotas personaje))

--sonDignos :: [Personaje] -> [Personaje]
--sonDignos grupo =  filter (vencioA "Hijo de Thanos") grupo `intersect` filter ((500<).poder) (entrenamiento grupo)

pelear :: Int -> Personaje -> Personaje -> Personaje
pelear anio unPersonaje otroPersonaje --Asumo que nunca son iguales los poderes, cada uno es unico ;)
    | poder unPersonaje > poder otroPersonaje = unPersonaje{derrotas = (nombre otroPersonaje,anio): derrotas unPersonaje}
    | otherwise = otroPersonaje{derrotas = (nombre unPersonaje,anio): derrotas otroPersonaje}

guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil anio unGrupo otroGrupo = zipWith (pelear anio) unGrupo otroGrupo

--PARTE B

escudo :: Equipamento
escudo unPersonaje
    |length (derrotas unPersonaje)<5 = modificarPoder (+50) unPersonaje
    | otherwise = modificarPoder (+(-100)) unPersonaje

modificarNombre :: String -> Personaje -> Personaje
modificarNombre agregado unPersonaje = unPersonaje{nombre = nombre unPersonaje ++ agregado}

trajeMecanizado :: Int -> Personaje -> Personaje
trajeMecanizado version unPersonaje = modificarNombre ("V"++ show version) (unPersonaje{nombre = "Iron "++ nombre unPersonaje})

thor :: Personaje
thor = Personaje { nombre = "Thor", poder = 1000, derrotas = [], equipamento = [] }

capitanAmerica :: Personaje
capitanAmerica = Personaje { nombre = "Capitan America", poder = 800, derrotas = [], equipamento = [] }

usarSiLePertenece :: EquipamentoExclusivo -> Equipamento
usarSiLePertenece exclusivo unPersonaje
    | snd exclusivo == nombre unPersonaje = fst exclusivo unPersonaje
    | otherwise = unPersonaje

resultadostormBreaker :: Equipamento
resultadostormBreaker personaje = modificarNombre " dios del trueno" (personaje{derrotas = []})

stormBreaker :: EquipamentoExclusivo
stormBreaker = (resultadostormBreaker,"Thor")

type EquipamentoExclusivo = (Equipamento,String)

extraBase :: Personaje
extraBase = Personaje "Extra numero" 0 [] []

infinitosExtras :: [Personaje]
infinitosExtras = map ((`modificarNombre` extraBase) . show) [1..]
infinitosAnios :: [Integer]
infinitosAnios = [2018..]

--resultadoGemaDelAlma :: Equipamento
--resultadoGemaDelAlma unPersonaje =  zipWith (`pelear` unPersonaje) infinitosAnios infinitosExtras
