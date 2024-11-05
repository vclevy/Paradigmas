class Maquillaje {
    var nivelDeSusto = 3

    method cambiarNivelDeSusto(nuevoNivel) {
        nivelDeSusto = nuevoNivel
    }

    method nivelDeSusto() = nivelDeSusto
}

class Traje {
    const tipo

    method nivelDeSusto() = tipo.nivelDeSusto()
}

object tierno {
    method nivelDeSusto() = 2
}

object terrorifico {
    method nivelDeSusto() = 5
}

const winniePooh = new Traje(tipo = tierno)
const sullivan   = new Traje(tipo = tierno)

const jason      = new Traje(tipo = terrorifico)
const georgeBush = new Traje(tipo = terrorifico)
