// Experiencias
object amateur {
    method sueldo(unaPersona) = 10000
    method puedeRecategorizarse(unaPersona) = unaPersona.cantidadPeliculas() > 10
    method siguienteCategoria() = establecida
}

object establecida {
    method sueldo(unaPersona) {
        if (unaPersona.nivelDeFama() < 15) 
            return 15000
        else return 5000 * unaPersona.nivelDeFama()    
    }

    method puedeRecategorizarse(unaPersona) = unaPersona.nivelDeFama() > 10
    method siguienteCategoria() = estrella

}   

object estrella {
  method sueldo(unaPersona) = 30000 * unaPersona.cantidadPeliculas()
  method puedeRecategorizarse(unaPersona) = throw Exception
}
