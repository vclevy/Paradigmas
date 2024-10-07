import Suscripciones.*

class Juego{
    const nombre
    const precio
    const categoria

    method seLlama(unNombre) = nombre == unNombre

    method perteneceACategoria(unaCategoria) = categoria == unaCategoria

    method afectarA(unCliente, unasHoras)

    method saleMenosQue(unaCantidad){
        return precio <= unaCantidad
    }
}

class JuegoViolento inherits Juego{
    override method afectarA(unCliente, unasHoras){
        unCliente.bajarHumor(10* unasHoras)
    }
}

class Moba inherits Juego{
    override method afectarA(unCliente, unasHoras){
        unCliente.pagar(30)
    }
}

class JuegoDeTerror inherits Juego{
    override method afectarA(unCliente, unasHoras){
        unCliente.suscripcion(infantil)
    }
}

class JuegoEstrategico inherits Juego{
    override method afectarA(unCliente, unasHoras){
        unCliente.aumentarHumor(5*unasHoras)
    }
}

// para heredar la flecha es --|>