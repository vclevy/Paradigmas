class Sala {
    const nombre
    const dificultad

    method precio() = 10000

    method esDificil() = dificultad > 7

}

class SalaDeAnime inherits Sala {
    override method precio() = super() + 7000
}

class SalaDeHistoria inherits Sala {
    const basadaEnHechosReales 
    override method precio() = super() + dificultad * 0.314

    override method esDificil() = super() && not(basadaEnHechosReales)

}

class SalaDeTerror inherits Sala {
    var cantidadDeSustos
    
    override method precio() {
        if (self.haySuficientesSustos())
        {
            return super() * 1.2
        }
        return super()
    }

    method haySuficientesSustos() = cantidadDeSustos > 5

    override method esDificil() = super() || self.haySuficientesSustos()
}