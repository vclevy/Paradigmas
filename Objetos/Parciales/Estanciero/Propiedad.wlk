import estanciero.Casillero.*

class Propiedad{
    const precioInicial
    var property duenio = banco

    method cayo(unJugador){
        if (duenio == banco){
            unJugador.comprarPropiedad(self)
            self.duenio(unJugador)
        }
        else if (duenio === unJugador){}
        else{
            unJugador.pagarA(duenio,self.renta())
        }
    }

    method precioInicial() = precioInicial

    method renta() // abstracto

    method sosEmpresa()

    method cantidadDeEmpresasDelDuenio() = duenio.cantidadDeEmpresas()
}

class Campo inherits Propiedad{
    const provincia
    const valorDeRentaFijo
    const costoDeConstruccionDeEstancia
    var cantidadDeEstancias

    override method renta() = (2 ** cantidadDeEstancias) * valorDeRentaFijo
    
    method puedeContruir(unJugador) = unJugador.tieneTodaLaProvincia(provincia) && unJugador.construyeParejoEn(provincia)

    method construyeEstancia(unJugador){
        unJugador.pagarEstancia(costoDeConstruccionDeEstancia)
        self.aumentarEstancias(1)
    }

    method aumentarEstancias(unNumero){
        cantidadDeEstancias+=unNumero
    }
    
    method costoDeConstruccionDeEstancia() = costoDeConstruccionDeEstancia

    
}

class Empresa inherits Propiedad{

    var valorDeDado

    override method renta() = valorDeDado*30000*self.cantidadDeEmpresasDelDuenio()

    method cayo(unJugador){
        unJugador.tirarDados()
        unJugador.pagar(self.renta())
    }
}