import imPdep.Pelicula.Pelicula
import imPdep.Artista.Artista

object impPdeP{
    const artistas = #{}
    const peliculas = #{}

    method mejorPago() = artistas.max{unArtista=>unArtista.sueldo()}

    method peliculasEconomicas() = peliculas.map{unaPelicula=>unaPelicula.esEconomica()}

    method nombreDeLasPeliculasEconomicas() = self.peliculasEconomicas().map{unaPelicula=>unaPelicula.nombre()}

    method gananciaDeLasPeliculasEconomicas() = self.peliculasEconomicas().sum{unaPelicula=>unaPelicula.ganancias()}

    method recategorizarAArtistas(){
        artistas.forEach({unArtista=>unArtista.recategorizar()})
    }
}