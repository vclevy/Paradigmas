import cantidadIncorrectaException.*
class Ninio {
    const actitud
    const elementos
    var caramelos

    method capacidadDeAsustar() = self.sumatoriaDeSustos() * actitud

    method sumatoriaDeSustos() = elementos.sum({unElemento => unElemento.nivelDeSusto()})

    method asustar(unAdulto) {
        unAdulto.intentarSerAsustadoPor(self)
        if (unAdulto.loAsusta(self)){
            unAdulto.serAsustadoPor(self)
        }
    }

    method tieneMasDeNCaramelos(cantidad) = cantidad > caramelos

    method recibirCaramelos(unaCantidad) {
        caramelos += unaCantidad
    }

    method comer(unosCaramelos) {
        if (caramelos < unosCaramelos) {
            throw new CantidadIncorrectaException()
        }
        caramelos -= unosCaramelos
    }
}

class Adulto {
    var niniosQueIntentaronAsustarlo
    var caramelos

    method loAsusta(unNinio) = self.tolerancia() < unNinio.capacidadDeAsustar()

    method tolerancia() = 10 * niniosQueIntentaronAsustarlo.filter({unNinio => unNinio.tieneMasDeNCaramelos(15)}).size()

    method intentarSerAsustadoPor(unNinio) {
        niniosQueIntentaronAsustarlo.add(unNinio)
    }

    method serAsustadoPor(unNinio) {
        caramelos -= self.caramelosAEntregar()
        unNinio.recibirCaramelos(self.caramelosAEntregar())
    }
    
    method caramelosAEntregar() = self.tolerancia() / 2
}

class Abuelo inherits Adulto {
    override method loAsusta(_unNinio) = true

    override method caramelosAEntregar() = super() / 2
}

class AdultoNecio inherits Adulto {
    override method loAsusta(_unNinio) = false
}