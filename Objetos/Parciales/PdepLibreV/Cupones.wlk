class Cupon{
    var fueUsado = false
    const porcentajeDescuento

    method estaDisponible() = ! fueUsado

    method descuentoAplicado(unNumero) = unNumero * porcentajeDescuento

    method usar(){
        fueUsado = true
    }
}
