
class SuscripcionPorCategoria{
    const categoria
    const precio

    method precio() = precio
    method puedeJugar(unJuego){
        return unJuego.perteneceACategoria(categoria)
    }
}

object premium {
    const precio = 50
    method precio() = precio

    method puedeJugar(unJuego) = true
}

object base{
    const precio = 25
    method precio() = precio

    method puedeJugar(unJuego){
        return unJuego.saleMenosQue(30)
    }
}

const infantil = new SuscripcionPorCategoria(precio = 10,categoria = "Infantil")
const prueba = new SuscripcionPorCategoria(precio = 10,categoria = "demo")
