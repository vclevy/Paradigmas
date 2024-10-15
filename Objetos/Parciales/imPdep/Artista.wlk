import imPdep.Experiencia.*
class Artista{
    var experiencia
    var cantidadDePeliculas
    var ahorros

    method sueldo() = experiencia.sueldoDe(self)

    method nivelDeFama() = cantidadDePeliculas/2

    method cantidadDePeliculas() = cantidadDePeliculas

    method recategorizar(){
        if (self.es(estrella)){
            throw new Exception(message="No se puede recategorizar")
        }
        experiencia = self.categoriaCorrespondiente()
    }

    method es(unaCategoria) = experiencia === unaCategoria

    method categoriaCorrespondiente(){
        if (cantidadDePeliculas<10){
            return amateur
        }
        else (self.es(amateur) && self.nivelDeFama()>10) {
            return estrella
        }
    }

    method actuar(){
        cantidadDePeliculas+=1
        const sueldoACobrar = self.sueldo()
        self.aumentarAhorros(sueldoACobrar)
    }

    method aumentarAhorros(unNumero){
        ahorros+=unNumero
    }
}

