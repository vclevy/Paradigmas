class Minion {
    var color = amarillo
    var armas = []
    var bananas
    var maldadesQueHizo = 0

    method maldadesQueHizo() = maldadesQueHizo

    method noHizoMaldades() = maldadesQueHizo == 0

    method esPeligroso() = color.esPeligroso(self)

    method absorberSuero() {
        if (color == amarillo) {
            armas = []
            bananas -= 1
            color = violeta
        } else {
            bananas -= 1
            color = amarillo
        }
    } 

    method nivelDeConcentracion() = color.nivelDeConcentracion(self)

    method cantidadDeArmas() = armas.size()

    method potenciaDelArmaMasFuerte() = armas.max({unArma => unArma.potencia()})

    method cantidadDeBananas() = bananas

    method otorgarArma(unArma) {
        armas.add(unArma)
    } 

    method alimentar(unasBananas) {
        bananas + unasBananas
    } 
}

object amarillo {
    method esPeligroso(unMinion) = unMinion.cantidadDeArmas() > 2

    method nivelDeConcentracion(unMinion) = unMinion.potenciaDelArmaMasFuerte() + unMinion.cantidadDeBananas()

}

object violeta {
    method esPeligroso(_unMinion) = true

    method nivelDeConcentracion(unMinion) = unMinion.cantidadDeBananas()
}