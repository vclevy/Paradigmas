import Asadito.Person.Persona

object vegetariano{
    method puedeComer(unaComida) = not unaComida.esCarne()
}

object dietetico{
    const cantidadDeCalorias = 500

    method puedeComer(unaComida) = unaComida.calorias() < cantidadDeCalorias
}

object alterna{
    var come = true

    method puedeComer(unaComida){
        come = !come
        return true
    }
}

object combinacion{
    const property criterios = []

}