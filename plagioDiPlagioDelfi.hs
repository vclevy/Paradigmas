{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Redundant ==" #-}
import Text.Show.Functions
import Data.Char (isAlphaNum)


data Obra = Obra{
    nombre :: [Char],
    publicacion :: Int
}deriving (Show,Eq)

type Autor = (String,[Obra])

obraA :: Obra
obraA = Obra { nombre = "Había una vez un pato.", publicacion = 1997 }

obraB :: Obra
obraB = Obra { nombre = "¡Habia una vez un pato!", publicacion = 1996 }

obraC :: Obra
obraC = Obra { nombre = "Mirtha, Susana y Moria.", publicacion = 2010 }

obraD :: Obra
obraD = Obra { nombre = "La semántica funcional del amoblamiento vertebral es riboficiente", publicacion = 2020 }

obraE :: Obra
obraE = Obra { nombre = "La semántica funcional de Mirtha, Susana y Moria.", publicacion = 2022 }

quitarTilde :: Char -> Char
quitarTilde 'í' = 'i'
quitarTilde 'á' = 'a'
quitarTilde 'é' = 'e'
quitarTilde 'ó' = 'o'
quitarTilde 'ú' = 'u'
quitarTilde 'Í' = 'I'
quitarTilde 'Á' = 'A'
quitarTilde 'É' = 'E'
quitarTilde 'Ó' = 'O'
quitarTilde 'Ú' = 'U'
quitarTilde letra = letra

quitarNoAlfaNum :: Char -> Char
quitarNoAlfaNum letra 
 |isAlphaNum letra = letra
 | otherwise = ' '

modificarNombreObra :: (Char -> Char) ->Obra -> Obra
modificarNombreObra modificador unaObra = unaObra{nombre= map modificador (nombre unaObra)}

versionCruda :: Obra -> Obra
versionCruda unaObra = modificarNombreObra (quitarTilde.quitarNoAlfaNum) unaObra

copiaLiteral :: Obra -> Obra -> Bool
copiaLiteral unaObra otraObra = versionCruda unaObra == versionCruda otraObra

primerosCaracteresIguales :: Int -> Obra -> Obra -> Bool
primerosCaracteresIguales num unaObra otraObra = (take num.nombre.versionCruda) unaObra == (take num.nombre.versionCruda) otraObra

largo :: Obra -> Int
largo = length.nombre

tieneNombreMasCorto :: Obra -> Obra -> Bool
tieneNombreMasCorto unaObra otraObra = largo unaObra < largo otraObra

empiezaIgual :: Int -> Obra -> Obra -> Bool
empiezaIgual num unaObra otraObra = unaObra `tieneNombreMasCorto` otraObra && primerosCaracteresIguales num unaObra otraObra

finalIgual :: Obra -> Obra -> [Char]
finalIgual unaObra otraObra = drop (largo otraObra - largo unaObra) (nombre otraObra) 

leAgregaronIntro :: Obra -> Obra -> Bool
leAgregaronIntro unaObra otraObra = finalIgual unaObra otraObra == nombre unaObra

mismaLetra :: Obra -> Obra -> Bool
mismaLetra unaObra otraObra = filter (\l -> l == 'a' || l == 'i') (nombre unaObra) == filter (\l -> l == 'a' || l == 'i') (nombre otraObra)

type Plagio = Obra -> Obra -> Bool

type Bot = ([Plagio],String)

esPlagio :: Bot -> Obra -> Obra -> Bool
esPlagio (plagios, _) unaObra otraObra = any (\plagio -> plagio unaObra otraObra) plagios
