
class ArbolNavidenio{
    var regalos
    var tarjetas
    var adornos
    
    method capacidadParaContenerRegalos()

    method agregarRegalo(unRegalo){
        if (!self.hayEspacio()){
            throw new Exception(message="No hay suficiente espacio!")
        }
        regalos.add(unRegalo)
    }

    method hayEspacio() = regalos.size() < self.capacidadParaContenerRegalos()

    method beneficiarios() = (regalos+tarjetas).map({unaCosa=>unaCosa.destinatario()})

    method costoDeRegalos() = regalos.sum({unRegalo=>unRegalo.precio()})

    method importancia() = adornos.sum({unAdorno=>unAdorno.importancia()})

    method esPotentoso() = self.hayMuchosRegalosLindos() || self.hayUnaGranTarjeta()

    method hayMuchosRegalosLindos() = regalos.count({unRegalo=>unRegalo.esUnRegaloTeQuierenMucho()}) > 5

    method hayUnaGranTarjeta() = tarjetas.any({tarjeta => tarjeta.esCara()})

    method adornoMasPesado() = adornos.max({unAdorno=>unAdorno.peso()})
}
class ArbolNatural inherits ArbolNavidenio{
    const vejez
    const tamanioTronco

    override method capacidadParaContenerRegalos() = vejez*tamanioTronco
}

class ArbolArtificial inherits ArbolNavidenio{
    const cantidadDeVaras

    override method capacidadParaContenerRegalos() = cantidadDeVaras
}