class Mision{
    
    method puedeSerRealizadaPor(unBarco){
        return unBarco.tieneSuficienteTripulacion()
    }

    method esUtil(unTripulante)
}

class BusquedaDelTesoro inherits Mision{

    override method esUtil(unTripulante){
        return unTripulante.estaPreparadoParaBuscar() && unTripulante.tieneMenosMonedasQue(5)
    }

    override method puedeSerRealizadaPor(unBarco){
     return super(unBarco) && unBarco.puedeAbrirUnCofre()
    }
}

class ConvertirseEnLeyenda inherits Mision{

    const itemLegendario

    override method esUtil(unTripulante){
        return unTripulante.tieneMuchosItems() && unTripulante.contiene(itemLegendario)
    }
}

class Saqueo inherits Mision{

    const victima
    var monedas

    method monedas(unaCantidad){
        monedas = unaCantidad
    }

    override method esUtil(unTripulante){
        return unTripulante.tieneMenosMonedasQue(monedas) && unTripulante.seAnimaASaquearA(victima)
    }

     override method puedeSerRealizadaPor(unBarco){
        return super(unBarco) && victima.esVulnerableA(unBarco)
     }

}

