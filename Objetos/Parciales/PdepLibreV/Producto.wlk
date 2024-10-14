class Producto{
    const nombre
    const precioBase

    method precio() = precioBase * 1.21
    method nombreEnOferta() = "SUPER OFERTA " + nombre 
}

class Mueble inherits Producto{
    override method precio() = super()+1000
}

class Indumentaria inherits Producto{
    var esDeTemporadaActual // booleano

    method aumentoSegunTemporada(){
        if (esDeTemporadaActual){
            return self.precio()*0.1
        }
        else return 0
    }

    override method precio() = super()+self.aumentoSegunTemporada()
}

class Ganga inherits Producto{

    override method precio() = 0

    override method nombreEnOferta() =  super() + " COMPRAME POR FAVOR"

}


