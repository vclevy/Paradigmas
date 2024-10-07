import Juego.*
import Cliente.*
import Suscripciones.*

object gameflix{
    const juegos = []
    const clientes = []

    method juegosDeCategoria(unaCategoria){
        return juegos.filter({unJuego => unJuego.perteneceACategoria(unaCategoria)})
    }

    method juegoQueSeLlama(unNombre){
        return juegos.findOrElse({unJuego => unJuego.seLlama(unNombre)}, {throw new Exception(message = "No existe el juego " + unNombre)})
    }

    method juegoRecomendado() = juegos.anyOne()

    method cobrarSuscripciones(){
        clientes.forEach({unCliente => unCliente.pagarSuscripcion()})
    }
}

// el INFINITIVO, por convención, se usa para métodos con efecto.