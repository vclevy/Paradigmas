import MeQuedeSinPlataException.*
import Suscripciones.*

class Cliente{
    var humor
    var plata
    var suscripcion

    method bajarHumor(unaCantidad){
        humor -= unaCantidad

    }
    method pagar(unaCantidad){
        if (plata < unaCantidad){
            throw new MeQuedeSinPlataException()
        }
        plata -= unaCantidad
    }
    
    method aumentarHumor(unaCantidad){
        humor += unaCantidad
    }

    method pagarSuscripcion(){
        try{
            self.pagar(suscripcion.precio())
        } catch unError : MeQuedeSinPlataException {
            self.suscripcion(prueba) 
        }
    }

    method suscripcion(unaSuscripcion){
        suscripcion = unaSuscripcion
    }

    method jugar(unJuego,unasHoras){
        if (suscripcion.puedeJugar(unJuego)){
            unJuego.afectarA(self,unasHoras)
        } else throw new Exception(message="la suscripcion no lo permite")
    }
}