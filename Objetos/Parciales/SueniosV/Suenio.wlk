class Suenio{
    const felicidonios

    method puedeSerCumplidoPor(unaPersona)

    method serCumplidoPor(unaPersona){
        unaPersona.aumentarFelicidad(felicidonios)
    }

    method felicidonios() = felicidonios

    method esLindo() = felicidonios > 100
}

class SuenioMultiple{
    var property sueniosACumplir 
}

class RecibirseDe inherits Suenio{
    const carrera

    override method puedeSerCumplidoPor(unaPersona) = unaPersona.quiereEstudiar(carrera) && not unaPersona.seRecibioDe(carrera)

    override method serCumplidoPor(unaPersona){
        super(unaPersona)
        unaPersona.recibiseDe(carrera)
    }
}

class ConseguirTrabajoDe inherits Suenio{
    const plata
    const trabajo

    override method puedeSerCumplidoPor(unaPersona) = plata<unaPersona.plataDeseada()
    
    override method serCumplidoPor(unaPersona){
        super(unaPersona)
        unaPersona.trabajo(trabajo)
    }
}

class TenerHijo inherits Suenio{
    const nombre

    override method puedeSerCumplidoPor(unaPersona) = not unaPersona.tieneUnHijo()

    override method serCumplidoPor(unaPersona){
        super(unaPersona)
        unaPersona.tenerA(nombre)
    }
}

class ViajarA inherits Suenio{
    const lugar

    override method puedeSerCumplidoPor(unaPersona){}

    override method serCumplidoPor(unaPersona){
        super(unaPersona)
        unaPersona.viajarA(lugar)
    }

}