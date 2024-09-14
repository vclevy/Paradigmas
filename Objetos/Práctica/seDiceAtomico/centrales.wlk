object springfield {
    const velocidadDeVientos = 10
    const riquezaDelSuelo = 0.9
    const centrales = [burns,exBosque,elSuspiro]
    var necesidadEnergetica = 100 // ??
    method velocidadDeVientos() = velocidadDeVientos 
    method riquezaDelSuelo() = riquezaDelSuelo 
    method necesidadEnergetica(unaCantdiad) {necesidadEnergetica = unaCantdiad} 
    method produccionEnergeticaDe(unaCentral)= unaCentral.produccionEnergetica()
    method centralesContaminantes() = centrales.filter({unaCentral => unaCentral.esContaminante()})
    method cubreSusNecesidades() = self.produccionDe(centrales) > necesidadEnergetica
    method estaEnElHorno() = centrales.all({unaCentral => unaCentral.esContaminante()}) || self.produccionDe(self.centralesContaminantes()) > necesidadEnergetica/2
    method produccionDe(unasCentrales) = unasCentrales.map({unaCentral=>self.produccionEnergeticaDe(unaCentral)}).sum()
}
object albuquerque {
  const centrales = [hidroelectrica]
}
object burns {
    var varillaDeUranio = 100
    method varillaDeUranio(unaCantidad) { varillaDeUranio = unaCantidad }
    method produccionEnergetica() = 0.1 * varillaDeUranio // unidad: millon de kWh
    method esContaminante() = varillaDeUranio>20
}

object exBosque{
    var capacidadEnToneladas = 20
    method capacidadEnToneladas(unaCantidad) {capacidadEnToneladas = unaCantidad}
    method produccionEnergetica() = 0.5+((springfield.riquezaDelSuelo())*capacidadEnToneladas)
    method esContaminante() = true

}

object elSuspiro {
    const turbinas = [turbina1]
    method produccionEnergetica() = turbinas.map({unaTurbina=>unaTurbina.produccionTurbina()}).sum()
    method esContaminante() = false

}

object turbina1 {
    method produccionTurbina() = 0.2*(springfield.velocidadDeVientos())
}

object hidroelectrica {
    var caudalDelRio = 150
    method produccionEnergetica() = 2*caudalDelRio 
}