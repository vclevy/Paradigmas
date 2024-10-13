class Pirata{
    const items
    var nivelDeEbriedad
    var dinero
    const quienLoInvito

    method items() = items

    method dinero() = dinero

    method nivelDeEbriedad() = nivelDeEbriedad

    method estaPreparadoParaBuscar(){
        return items.contains("brujula") || items.contains("mapa") || items.contains("botellaGrogXD")  
    }

    method tieneMenosMonedasQue(unaCantidad) = dinero < unaCantidad

    method esUtilPara(unaMision){
         unaMision.esUtil(self)
    }

    method puedeFormarParteDe(unBarco){
        return unBarco.puedeFormarParte(self)
    }

    method contiene(unItem) = items.contains(unItem)

    method tieneMuchosItems() = items.size() > 10

    method estaPasadoDeGrogXD(unNumero)= nivelDeEbriedad>unNumero

    method aumentarEbriedad(unNumero){
        nivelDeEbriedad += unNumero
    }

    method disminuirDinero(unNumero){
        dinero-=unNumero
    }

    method seAnimaASaquearA(unaVictima){
        return unaVictima.puedeSerSaqueadaPor(self)
    }

    method meInvito(unTripulante){
		return unTripulante == quienLoInvito
	}

}

class EspiaDeLaCorona inherits Pirata{

    override method estaPasadoDeGrogXD(unNumero) = false

    override method seAnimaASaquearA(unaVictima){
        return super(unaVictima) && self.contiene("permiso de la corona")
    }
}

