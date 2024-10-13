class Persona{
    var sueniosPendientes 
    var sueniosCumplidos 
    var carrerasQueQuiereEstudiar
    var carrerasHechas
    var felicidad
    const plataDeseada
    var trabajo
    var hijos
    var lugaresViajados
    var property tipoPersona

    method cumplir(unSuenio){
        if (!unSuenio.puedeSerCumplidoPor(self)){
            throw new Exception(message= "No se puede cumplir" + unSuenio)
        }
        unSuenio.serCumplido()
        sueniosCumplidos.add(unSuenio)
        sueniosPendientes.remove(unSuenio)
    }

    method quiereEstudiar(unaCarrera) = carrerasQueQuiereEstudiar.contains(unaCarrera)

    method seRecibioDe(unaCarrera) = carrerasHechas.contains(unaCarrera)

    method recibirseDe(unaCarrera) = carrerasHechas.add(unaCarrera)

    method aumentarFelicidad(unaCantidad){
        felicidad+=unaCantidad
    }

    method plataDeseada() = plataDeseada

    method trabajo(nuevoTrabajo){
        trabajo = nuevoTrabajo
    }

    method tieneUnHijo() = not hijos.isEmpty()

    method tenerA(unHijo) = hijos.add(unHijo)

    method viajarA(unLugar) = lugaresViajados.add(unLugar)

    method cumplirSuenioMultiple(unosSuenios){
        if(unosSuenios.sueniosACumplir().any({unSuenio=>not unSuenio.puedeSerCumplidoPor(self)})){
            throw new Exception(message= "No se puede cumplir el suenio multiple")
        }
        unosSuenios.sueniosACumplir().forEach({unSuenio=>unSuenio.serCumplidoPor(self)})
        sueniosCumplidos.add(unosSuenios.sueniosACumplir())
        sueniosPendientes.remove(unosSuenios.sueniosACumplir())
    }

    method esFeliz() = felicidad > sueniosPendientes.sum({unSuenio=>unSuenio.felicidonios()})

    method cantidadDeSueniosFelices() = (sueniosPendientes+sueniosCumplidos).count({unSuenio=>unSuenio.esLindo()})

    method esAmbiciosa() = self.cantidadDeSueniosFelices() > 3

    method cumplirSuenioElegido() {
		const suenioElegido = tipoPersona.elegirSuenio(sueniosPendientes)
		self.cumplir(suenioElegido)
	}
}
object realista {
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.max { suenio => suenio.felicidonios() }
	}
}

object alocado { 
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.anyOne()
	}
}

object obsesivo {
	method elegirSuenio(sueniosPendientes) {
		sueniosPendientes.first()
	}
}
