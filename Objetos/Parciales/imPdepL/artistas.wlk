class Artista {
    var experiencia
    var cantidadPeliculas
    var ahorros

    method cantidadPeliculas() = cantidadPeliculas

    method nivelDeFama() = cantidadPeliculas / 2

    method sueldo() = experiencia.sueldo(self)

    method puedeRecategorizarse() = experiencia.puedeRecategorizarse(self)

    method actuar() {
        cantidadPeliculas += 1
        ahorros += self.sueldo()
    }

    method recategorizar() {
        if (self.puedeRecategorizarse())
        {
            experiencia = experiencia.siguienteCategoria()
        }
    } 



}

