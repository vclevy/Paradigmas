import Text.Show.Functions

data Peleador = UnPeleador{
    puntosDeVida :: Int,
    resistencia :: Int,
    ataques :: [Ataque]
}

modificarVida :: (Int->Int) -> Peleador -> Peleador
modificarVida unaFuncion unPeleador = unPeleador {puntosDeVida = unaFuncion.puntosDeVida $ unPeleador}

modificarResistencia :: (Int->Int) -> Peleador -> Peleador
modificarResistencia unaFuncion unPeleador = unPeleador {resistencia = unaFuncion.resistencia $ unPeleador}

modificarAtaques :: ([Ataque]->[Ataque]) -> Peleador -> Peleador
modificarAtaques unaFuncion unPeleador = unPeleador {ataques = unaFuncion.ataques $ unPeleador}

type Ataque = Peleador -> Peleador

estaMuerto :: Peleador -> Bool
estaMuerto unPeleador = puntosDeVida unPeleador < 1

esHabil :: Peleador -> Bool
esHabil unPeleador = (>10).length.ataques $ unPeleador

golpe :: Int->Ataque
golpe intensidad unPeleador = modificarVida (subtract (div intensidad (resistencia unPeleador))) unPeleador

toqueDeLaMuerte :: Ataque
toqueDeLaMuerte = modificarVida (const 0)

patada :: String -> Ataque
patada "pecho" unPeleador 
 |estaMuerto unPeleador = modificarVida (+1) unPeleador
 |otherwise = modificarVida (subtract 10) unPeleador
patada "carita" unPeleador = modificarVida (`div` 2) unPeleador
patada "nuca" unPeleador = modificarAtaques (drop 1) unPeleador
patada _ unPeleador = unPeleador

type Enemigo = Peleador

mejorAtaque :: Peleador -> Enemigo -> Ataque
mejorAtaque unPeleador unEnemigo = foldr1 (compararAtaques unEnemigo) (ataques unPeleador)

compararAtaques :: Enemigo -> Ataque -> Ataque -> Ataque
compararAtaques unEnemigo unAtaque otroAtaque 
 |(puntosDeVida.unAtaque) unEnemigo < (puntosDeVida.otroAtaque) unEnemigo = unAtaque 
 |otherwise = otroAtaque

esTerrible :: Ataque -> [Enemigo] -> Bool
esTerrible unAtaque unosEnemigos = (>(div (length unosEnemigos) 2)).length.map unAtaque $ unosEnemigos

esPeligroso :: Peleador -> [Enemigo] -> Bool
esPeligroso unPeleador unosEnemigos = 
    all (flip esTerrible (filter esHabil unosEnemigos)) . ataques $ unPeleador

invencible :: Peleador -> [Enemigo] -> Bool
invencible unPeleador =
    (puntosDeVida unPeleador == ) . puntosDeVida . foldr ($) unPeleador . map (flip mejorAtaque unPeleador)
