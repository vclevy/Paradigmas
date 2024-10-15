object impdep {
    const peliculas = []
    const artistas = []

    method artistaMejorPago() =  peliculas.max({unaPelicula => unaPelicula.artistaMejorPago()})

    method peliculasEconomicas() = peliculas.filter({unaPelicula => unaPelicula.esEconomica()}).map({unaPelicula => unaPelicula.nombre()})

    method recategorizar() = artistas.map({unArtista => unArtista.recategorizar()})
}