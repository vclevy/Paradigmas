import imPdep.Artista.Artista

object amateur{
    method sueldoDe(unaPersona) = 10000
}

object establecida{
    method sueldoDe(unaPersona){
        if (unaPersona.nivelDeFama()<15){
            return 15000
        }
        else return unaPersona.nivelDeFama()*5000
    }
}

object estrella{
    method sueldoDe(unaPersona) = 30000*unaPersona.cantidadDePeliculas()
}