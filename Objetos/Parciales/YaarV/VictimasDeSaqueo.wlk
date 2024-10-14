import yaar.Pirata.*
import yaar.Mision.*
class Barco{
    var mision
    var tripulantes = #{}
    const capacidad

    method elMasAdineradoDe(unosTripulantes) = unosTripulantes.max({unTripulante=>unTripulante.dinero()})

    method cantidadDeTripulantes() = tripulantes.size()

    method puedeFormarParte(unTripulante) = self.tieneEspacio() && self.sirveParaLaMision(unTripulante)

    method reclutar(unTripulante){
        if (self.puedeFormarParte(unTripulante)){
            tripulantes.add(unTripulante)
        } 
        else throw new Exception(message= unTripulante + "no puede formar parte")
    }

    method tieneSuficienteTripulacion() = self.cantidadDeTripulantes() >= capacidad*0.9

    method sirveParaLaMision(unTripulante) = mision.esUtil(unTripulante)

    method puedeRealizar(unaMision){
        return unaMision.puedeSerRealizadaPor(self)
    }

    method tieneEspacio() = capacidad > self.cantidadDeTripulantes()

    method mision(unaMision){
        mision = unaMision
        tripulantes.removeAllSuchThat({unPirata=>not mision.esUtil(unPirata)})
    }

    method puedeAbrirUnCofre()= tripulantes.any({unTripulante=>unTripulante.contiene("llaveDeCofre")})

    method esVulnerableA(otroBarco) = otroBarco.cantidadDeTripulantes() > self.cantidadDeTripulantes()/2

    method puedeSerSaqueadaPor(unTripulante) = unTripulante.estaPasadoDeGrogXD(90)

    method losBorrachos() = tripulantes.filter({unTripulante=>unTripulante.estaPasadoDeGrog(90)})

    method estanTodosBorrachos() = tripulantes.all({unTripulante=>unTripulante.estaPasadoDeGrog(90)})

    method elMasEbrio() = tripulantes.max({unTripulante=>unTripulante.nivelDeEbriedad()})

    method anclarEn(unaCiudad){
        tripulantes.forEach({unTripulante=> unTripulante.aumentarEbriedad(5)})
        tripulantes.forEach({unTripulante=> unTripulante.disminuirDinero(1)})
        tripulantes.remove(self.elMasEbrio())
        unaCiudad.aumentarHabitantes(1)
    }

    method esTemible() = self.puedeRealizar(mision)

    method cantidadDeBorrachos() = tripulantes.count({unTripulante=>unTripulante.estaPasadoDeGrog(90)})

    method items() = self.losBorrachos().map({unTripulante=>unTripulante.items()}).asSet()

    method elBorrachoMasAdinerado() = self.elMasAdineradoDe(self.losBorrachos())

    method cantidadDeTripulantesQueHaInvitado(unTripulante){
		return tripulantes.count({tripulante => tripulante.meInvito(unTripulante)})
	}
	
	method tripulanteQueMasInvito(){
		return tripulantes.max({tripulante => self.cantidadDeTripulantesQueHaInvitado(tripulante)})
	} 
}   

class CiudadCostera{

    var habitantes

    method puedeSerSaqueadaPor(unTripulante) = unTripulante.estaPasadoDeGrogXD(50)

    method esVulnerableA(unBarco) = unBarco.cantidadDeTripulantes()*0.4 > habitantes || unBarco.estanTodosBorrachos()

    method aumentarHabitantes(unNumero){
        habitantes += unNumero
    }

}
