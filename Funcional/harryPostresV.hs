import Text.Show.Functions

data Postre = UnPostre{
    sabores :: [String],
    peso :: Float,
    temperatura :: Float
} deriving (Show,Eq)

modificarSabores :: ([String] -> [String]) -> Postre -> Postre
modificarSabores f postre = postre {sabores = f (sabores postre)}

modificarPeso :: (Float -> Float) -> Postre -> Postre
modificarPeso f postre = postre {peso = f (peso postre)}

modificarTemperatura :: (Float -> Float) -> Postre -> Postre
modificarTemperatura f postre = postre {temperatura = f (temperatura postre)}

type Hechizo = Postre -> Postre

incendio :: Hechizo
incendio unPostre = modificarTemperatura(+1).modificarPeso(*0.95) $ unPostre

immobulus :: Hechizo
immobulus unPostre = modificarTemperatura (const 0) unPostre

wingardiumLeviosa :: Hechizo
wingardiumLeviosa unPostre = modificarSabores ("concentrado":).modificarPeso(*0.90) $ unPostre

diffindo :: Float -> Hechizo
diffindo unPorcentaje unPostre = modificarPeso (subtract (peso unPostre*(unPorcentaje/100))) unPostre

riddikulus :: String -> Hechizo
riddikulus unSabor unPostre = modificarSabores (reverse unSabor:) unPostre

avadaKedavra :: Hechizo
avadaKedavra unPostre = modificarSabores(take 0).immobulus $ unPostre

losDejaListos :: Hechizo -> [Postre] -> Bool
losDejaListos unHechizo unosPostres = all estaListo (map unHechizo unosPostres)

estaListo :: Postre -> Bool
estaListo unPostre = peso unPostre > 0 && (not.null $ sabores unPostre) && (not.estaCongelado) unPostre

estaCongelado :: Postre -> Bool
estaCongelado unPostre = (<0).temperatura $ unPostre

promedioDePesoDePostresListos :: [Postre] -> Float
promedioDePesoDePostresListos unosPostres = sumaDePesosDePostresListos unosPostres / cantidadDePostresListos unosPostres

sumaDePesosDePostresListos :: [Postre] -> Float
sumaDePesosDePostresListos unosPostres = sum.map peso.filter estaListo $ unosPostres

cantidadDePostresListos :: [Postre] -> Float
cantidadDePostresListos unosPostres = fromIntegral (length.filter estaListo $ unosPostres)

data Mago = UnMago {
    hechizos :: [Hechizo],
    cantidadHorrocruxes :: Int
}

modificarHechizos :: ([Hechizo]->[Hechizo]) -> Mago -> Mago
modificarHechizos unaFuncion unMago = unMago {hechizos = unaFuncion.hechizos $ unMago}

modificarHorrocruxes :: (Int->Int) -> Mago -> Mago
modificarHorrocruxes unaFuncion unMago = unMago {cantidadHorrocruxes = unaFuncion.cantidadHorrocruxes $ unMago}

asistirAClaseDeDefensa :: Hechizo -> Postre -> Mago -> Mago
asistirAClaseDeDefensa unHechizo unPostre unMago 
 | (unHechizo unPostre == avadaKedavra unPostre) = modificarHechizos(unHechizo:).modificarHorrocruxes (+1) $ unMago
 |otherwise = modificarHechizos(unHechizo:) unMago

mejorHechizo :: Postre -> Mago -> Hechizo
mejorHechizo unPostre unMago = foldr1 (compararHechizos unPostre) (hechizos unMago)

compararHechizos :: Postre -> Hechizo -> Hechizo -> Hechizo
compararHechizos unPostre unHechizo otroHechizo 
 |(length.sabores) (unHechizo unPostre) < (length.sabores) (otroHechizo unPostre) = unHechizo 
 |otherwise = otroHechizo

postresInfinitos :: [Postre] -> [Postre]
postresInfinitos unosPostres = unosPostres ++ (postresInfinitos unosPostres)

magoConInfinitosHechizos :: Mago 
magoConInfinitosHechizos = UnMago (repeat wingardiumLeviosa)  0

--Puede devolver falso si alguno no cumple, pero nunca va a devolver verdadero porque se necesitaría evaluar la totalidad de la lista, y no es posible porque es infinita

--No existe ninguna forma de conocer el mejor hechizo del mago porque para hacerlo hay que evaluar todos los elementos lista, aún teniendo lazy evaluation.