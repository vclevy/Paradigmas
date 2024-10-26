import AngryBirdsV.Pajaro.*
class Isla{
    const pajaros = #{}
    const property obstaculos

    method losFuertes() = pajaros.filter{unPajaro=>unPajaro.esFuerte()}

    method fuerza() = self.losFuertes().sum{unPajaro=>unPajaro.fuerza()}

    method sesionDeManejoDeIraConMatilda(){
        pajaros.forEach({unPajaro=>unPajaro.tranquilizar()})
    }

    method invasionDeCerditos(unaCantidad){
        const cantidadDeEnojos = unaCantidad/100.abs()
        cantidadDeEnojos.times(pajaros.forEach({unPajaro=>unPajaro.enojarse()}))
    }

    method losHomenajeados() = pajaros.filter{unPajaro=>unPajaro.esHomenajeado()}

    method fiestaSorpresa(){
        if(self.losHomenajeados().isEmpty()){
            throw new Exception(message="no hay homenajeados")
        }
        self.losHomenajeados().forEach({unPajaro=>unPajaro.enojarse()})
    }

    // lo de eventos secuencialmente?

    method atacarA(unaIsla){
        const unPajaro = pajaros.anyOne()
        const obstaculoMasCercano = unaIsla.obstaculos().first()
        unPajaro.derribar(obstaculoMasCercano, unaIsla)
    }
    
    method seRecuperaronLosHuevos() = obstaculos.isEmpty()
}

