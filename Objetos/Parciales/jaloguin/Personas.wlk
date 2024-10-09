import jaloguin.Elementos.*
import jaloguin.CantidadIncorrectaException.CantidadIncorrectaException
class Ninio{
    const elementosPuestos
    var bolsa
    const actitud
    
    method bolsa() = bolsa
    
    method elementosPuestos() = elementosPuestos

    method darCaramelos(unNumero){
        bolsa += unNumero
    }
    method tieneMasDeXCaramelos(unNumero) = bolsa>unNumero

    method capacidadDeAsustar() = elementosPuestos.sum({unElemento=>unElemento.susto()})*actitud

    method asustarA(unAdulto){
        if(unAdulto.puedeSerAsustadoPor(self))
        {
            unAdulto.serAsustadoPor(self)
        }
    }

    method comer(unosCaramelos){
        if (bolsa<unosCaramelos){
            throw new CantidadIncorrectaException()
        }
        bolsa -= unosCaramelos
    }

}

class Adulto{
    const niniosQueQuisieronAsustar = []

    method puedeSerAsustadoPor(unNinio)

    method serAsustadoPor(unNinio){
        unNinio.darCaramelos(self.tolerancia()/2)
    }
    method tolerancia() = 10 * niniosQueQuisieronAsustar.filter({unNinio=>unNinio.tieneMasDeXCaramelos(15)}).size()
}

class AdultoComun inherits Adulto{
    override method puedeSerAsustadoPor(unNinio){
        self.tolerancia()<unNinio.capacidadDeAsustar()
    }
}

class AdultoMayor inherits Adulto{
    override method puedeSerAsustadoPor(unNinio) = true

    override method serAsustadoPor(unNinio){
        super(unNinio)/2
    }
}

class AdultoNecio inherits Adulto{
    override method puedeSerAsustadoPor(unNinio) = false
}

