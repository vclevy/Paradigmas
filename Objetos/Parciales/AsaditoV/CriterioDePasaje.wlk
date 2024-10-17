import Asadito.Person.Persona

class Criterio{

    method elementoQueSePasa(unaPersona,unElemento)

    method pasarA(laQuePasa,laQuePide,unElemento){
        const elementoAPasar = self.elementoQueSePasa(laQuePasa,unElemento)
        laQuePasa.elementosCercanos().remove(elementoAPasar)
        laQuePide.elementosCercanos().add(elementoAPasar)
    }
}
object sorda inherits Criterio{
    override method elementoQueSePasa(unaPersona,unElemento) = unaPersona.elementosCercanos().first()
}

object ortiva inherits Criterio{
      override method elementoQueSePasa(unaPersona,unElemento) = unaPersona.elementosCercanos()
}

object cambioDeLugar{
    method pasarA(laQuePasa,laQuePide,unElemento){
        laQuePasa.posicion(laQuePide.posicion())
        laQuePide.posicion(laQuePasa.posicion()) 
    }
}

object normal inherits Criterio{
    override method elementoQueSePasa(unaPersona,unElemento) = unElemento
}

