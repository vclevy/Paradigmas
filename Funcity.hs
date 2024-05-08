data Ciudad = UnaCiudad {
    nombre :: String,
    anioDeFundacion :: Int,
    atracciones :: [String],
    costoDeVida :: Int
}

valorDeCiudad :: Ciudad -> Int
valorDeCiudad unaCiudad 