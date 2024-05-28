import Text.Show.Functions

data Ninja = Ninja{
    nombre :: String,
    herramientas :: [Herramienta],
    jutsus :: [Jutsu],
    rango :: Int
}deriving(Show)

type Jutsu = Mision -> Mision

elrango::Int->Int
elrango = max 0

data Herramienta = Herramienta{
    nombreHerramienta :: String,
    cantDisponible :: Int
}deriving(Show,Eq)

cantidadHerramientas :: Ninja -> Int
cantidadHerramientas unNinja = sum (map cantDisponible (herramientas unNinja))

totalAdquirido :: Ninja -> Int -> Int
totalAdquirido unNinja cantidad = min (cantidadHerramientas unNinja + cantidad) 100

herramientaAdquirida :: Herramienta-> Ninja -> Int -> Herramienta
herramientaAdquirida unaHerramienta unNinja cantidad = unaHerramienta{cantDisponible = totalAdquirido unNinja cantidad}

obtenerHerraienta:: Herramienta -> Ninja -> Ninja
obtenerHerraienta unaHerramienta unNinja = unNinja{herramientas = herramientaAdquirida unaHerramienta unNinja (cantDisponible unaHerramienta) : herramientas unNinja}

despuesDeUsar :: Herramienta -> Ninja -> [Herramienta]
despuesDeUsar unaHerramienta unNinja = filter (\h -> nombreHerramienta h /= nombreHerramienta unaHerramienta) (herramientas unNinja)

usarHerramienta :: Herramienta -> Ninja -> Ninja
usarHerramienta unaHerramienta unNinja = unNinja{herramientas = despuesDeUsar unaHerramienta unNinja}

data Mision = Mision{
    ninjasNecesarios :: Int,
    rangoRecomendado :: Int,
    enemigos :: [Ninja],
    recompensa :: Herramienta
} deriving(Show)

rangoMenorA :: Int ->Ninja -> Bool
rangoMenorA unRango unNinja= unRango> rango unNinja

esDesafiante :: Mision -> [Ninja] -> Bool
esDesafiante unaMision equipo = any (rangoMenorA (rangoRecomendado unaMision)) equipo && length (enemigos unaMision)>=2

bombaDeHumo3 :: Herramienta
bombaDeHumo3 = Herramienta "Bomba de Humo" 3
shuriken :: Herramienta
shuriken = Herramienta "Shuriken" 5
kunai :: Herramienta
kunai = Herramienta "Kunai" 14

recompensasCopadas :: [Herramienta]
recompensasCopadas = [bombaDeHumo3,shuriken,kunai]

esCopada :: Mision -> Bool
esCopada unaMision = recompensa unaMision `elem` recompensasCopadas

tienenLosNinjasNecesarios :: [Ninja] -> Mision -> Bool
tienenLosNinjasNecesarios equipo mision = length equipo >= ninjasNecesarios mision

esFactible ::  Mision-> [Ninja] -> Bool
esFactible unaMision equipo = (not.esDesafiante unaMision) equipo &&
 (tienenLosNinjasNecesarios equipo unaMision || sum (map cantidadHerramientas equipo) > 500)

modificarRango :: (Int->Int)-> Ninja -> Ninja
modificarRango modificador unNinja = unNinja{rango = modificador (rango unNinja)}

ninjasQueSobreviven :: Mision -> [Ninja] -> [Ninja]
ninjasQueSobreviven unaMision = filter (not.rangoMenorA (rangoRecomendado unaMision))

fallarMision :: Mision -> [Ninja] -> [Ninja]
fallarMision unaMision equipo = map (modificarRango (\x -> x - 2)) (ninjasQueSobreviven unaMision equipo)

cumplirMision :: Mision -> [Ninja] -> [Ninja]
cumplirMision unaMision = map (modificarRango (+1).obtenerHerraienta (recompensa unaMision))

clonesDeSombra :: Int -> Jutsu
clonesDeSombra clones unaMision = unaMision{ninjasNecesarios = max (ninjasNecesarios unaMision - clones) 1}

fuerzaDeUnCentenar :: Jutsu
fuerzaDeUnCentenar unaMision = unaMision {enemigos = filter (rangoMenorA 500) (enemigos unaMision)}

aplicarJutsus :: Mision -> [Ninja] -> Mision
aplicarJutsus unaMision equipo = foldl (\m j -> j m) unaMision (concatMap jutsus equipo)

ejecutarMision :: Mision -> [Ninja] -> Bool
ejecutarMision unaMision equipo = esCopada(aplicarJutsus unaMision equipo) || esFactible (aplicarJutsus unaMision equipo) equipo

zetsuBase :: Ninja
zetsuBase = Ninja "Zetsu" [] [] 600 

modificarNombre :: Ninja -> String -> Ninja
modificarNombre unNinja string =unNinja{nombre = nombre unNinja ++ string}

infinito :: [String]
infinito = map show [1..]

zetsus :: [Ninja]
zetsus = map (modificarNombre zetsuBase) infinito

granGuerraNinja :: Mision
granGuerraNinja = Mision 100000 100 zetsus abanicoMadaraUchiha

abanicoMadaraUchiha :: Herramienta
abanicoMadaraUchiha = undefined

{- a) Funciona correctamente con esDesafiante ya que en la que encuentra a alguien con 
rango bajo (any) y recorre +2 posiciones retorna True
b) la recompensa de la mision no es una lista infinita y a la vez no es ningun elementoCopado asi que
devuelve False
c) la funcion no retorna nada, ya que no finaliza de filtrar los enemigos de la lista infinita
mas alla de que nosotros sepamos que todos tienen el mismo rango 
-}