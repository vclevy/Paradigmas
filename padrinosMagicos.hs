
data Chico = Chico {
    nombre :: String,
    edad :: Float,
    habilidades :: [String],
    deseos :: [String]
}deriving (Show,Eq)

aprenderHabilidades :: Chico -> String -> Chico
aprenderHabilidades unChico habilidad = unChico{habilidades = habilidad : habilidades unChico}

serGrosoEnNeedForSpeed :: Chico -> String -> String -> String -> Chico
serGrosoEnNeedForSpeed unChico n1 n2 n3= (aprenderHabilidades n3.aprenderHabilidades n2.aprenderHabilidades n1) unChico

serMayor :: Chico -> Chico
serMayor unChico = unChico{edad = 18}

wanda :: Chico -> Chico
wanda unChico = unChico{edad = edad unChico + 1, deseos = init (deseos unChico)}

cosmo :: Chico -> Chico                         --HAY LOGICA REPETIDA! APLICAR HIGH ORDER
cosmo unChico = unChico{edad = edad unChico/2}

muffinMagico :: Chico -> Chico
muffinMagico unChico = foldl aprenderHabilidades unChico (deseos unChico)
