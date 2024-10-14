
class NivelLimitado{
    const limite

    method permiteAgregarACarrito(unCarrito){
        unCarrito.size() < limite
    }
}

const bronce = new NivelLimitado(limite=1)
const plata = new NivelLimitado(limite=5)

object oro{
   method permiteAgregarACarrito(unCarrito) = true

   method puedeAcceder(unaPersona) = unaPersona.puntos() > 15000

}