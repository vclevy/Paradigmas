import Text.Show.Functions

data Ninja = Ninja{
    nombre :: String,
    herramientas :: [Herramienta],
    jutsus :: [String],
    rango :: Int
}deriving(Show,Eq)

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

obtenerHerraienta:: Int->Herramienta -> Ninja -> Ninja
obtenerHerraienta cantidad unaHerramienta unNinja = unNinja{herramientas = herramientaAdquirida unaHerramienta unNinja cantidad : herramientas unNinja}

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

menorRangoQueElRecomendado :: Int ->Ninja -> Bool
menorRangoQueElRecomendado recomendado unNinja= recomendado> rango unNinja

esDesafiante :: Mision -> [Ninja] -> Bool
esDesafiante unaMision equipo = any (menorRangoQueElRecomendado (rangoRecomendado unaMision)) equipo && length(enemigos unaMision)>=2

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

modificarRango :: Ninja -> (Int->Int) -> Ninja
modificarRango unNinja modificador = unNinja{rango = modificador (rango unNinja)}

ninjasQueSobreviven :: Mision -> [Ninja] -> [Ninja]
ninjasQueSobreviven unaMision = filter (not.menorRangoQueElRecomendado (rangoRecomendado unaMision)) 

fallarMision :: Mision -> [Ninja] -> [Ninja]
fallarMision = undefined