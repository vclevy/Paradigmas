
data Chico = Chico {
    nombre :: String,
    edad :: Float,
    habilidades :: [String],
    deseos :: [String]
}deriving (Show,Eq)

aprenderHabilidades :: Chico -> String -> Chico
aprenderHabilidades unChico habilidad = unChico{habilidades = habilidad : habilidades unChico}

serGrosoEnNeedForSpeed :: Chico -> String -> String -> String -> Chico
serGrosoEnNeedForSpeed unChico n1 n2 n3 = foldl aprenderHabilidades unChico [n1,n2,n3]

serMayor :: Chico -> Chico
serMayor unChico = modificarEdad unChico (*(18/edad unChico))

wanda :: Chico -> Chico
wanda unChico = (modificarEdad unChico (+1)) {deseos = init (deseos unChico)}

cosmo :: Chico -> Chico                     
cosmo unChico = modificarEdad unChico (/2)

modificarEdad :: Chico -> (Float->Float) -> Chico
modificarEdad unChico modificador = unChico{edad = modificador (edad unChico)}

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldl aprenderHabilidades unChico (deseos unChico)
