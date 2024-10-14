import PdepLibre.Nivel.*
import PdepLibre.Cupones.*
class Usuario{
    const nombre
    var dinero
    var puntos
    var nivel
    const carrito
    const cupones

    method agregarAlCarrito(unProducto){
        if(!nivel.permiteAgregarACarrito()){
            throw new Exception(message="No se puede agregar al carrito")
        }
        carrito.add(unProducto)
    }

    method comprarCarrito(){
        const cupon = self.cuponDisponible()
        cupon.usar()
        const descuento = cupon.descuentoAplicado(self.precioDelCarrito())
        const valorDeCompra = self.precioDelCarrito()-descuento
        self.disminuirDinero(valorDeCompra)
        self.aumentarPuntos(valorDeCompra*0.1)
    }

    method cuponDisponible() = cupones.filter({unCupon=>unCupon.fueUsado()}).anyOne()

    method precioDelCarrito() = carrito.sum{unProducto=>unProducto.precio()}

    method disminuirDinero(unNumero){
        dinero -= unNumero
    }

    method aumentarPuntos(unNumero){
        puntos += unNumero
    }

    method reducirPuntos(unNumero){
        puntos -= unNumero
    }
    
    method esMoroso() = dinero < 0

    method eliminarCuponesUsados(){
        cupones.remove({unCupon=> not unCupon.estaDisponible()})
    }

    method actualizarNivel(){
        nivel = self.nivelCorrespondiente()
    }

    method nivelCorrespondiente(){
        if (puntos < 5000) return bronce
        else if (puntos < 15000) return plata
        else return oro
    }
}