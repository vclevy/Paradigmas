class Jugador{
    var dinero
    const propiedades
    var property casilleroActual

    method caerEn(unCasillero){
        unCasillero.cae(self)
    }

    method comprarPropiedad(unaPropiedad){
        if (dinero<unaPropiedad.precioInicial()){
            throw new Exception(message="no hay suficiente dinero")
        }
        propiedades.add(unaPropiedad)
    }

    method construirEstanciaEn(unCampo){
        if(!unCampo.puedeContruir(self)){
            throw new Exception(message="no se puede construir")
        }
        unCampo.construyeEstancia(self)
    }

    method pagarEstancia(unNumero){
        dinero -= unNumero
    }

    method tieneTodaLaProvincia(unaProvincia) = propiedades.intersection(unaProvincia.campos()) == unaProvincia.campos()

    method construyeParejoEn(unaProvincia) { } // no entiendo

    method cantidadDeEmpresas() = propiedades.count({unaPropiedad=>unaPropiedad.sosEmpresa()})

    method rentaAPagarPor(unaPropiedad) = unaPropiedad.renta()

    method pagarA(unAcreedor,unaCantidad){
      if (dinero<unaCantidad){
            throw new Exception(message="no hay suficiente dinero")
        }  
       unAcreedor.aumentarDinero(unaCantidad) 
       self.disminuirDinero(unaCantidad)
    }

    method aumentarDinero(unaCantidad){
        dinero+=unaCantidad
    }

    method disminuirDinero(unaCantidad){
        dinero-=unaCantidad
    }

    method moverseSobre(unosCasilleros){
    unosCasilleros.forEach({unCasillero=>unCasillero.paso(self)})
    self.caerEn(unosCasilleros.last())
    casilleroActual(unosCasilleros.last())
    }


}

