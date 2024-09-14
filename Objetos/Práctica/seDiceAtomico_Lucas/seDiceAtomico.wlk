object springfield {
  const velocidadViento = 10
  const riqueza = 0.9
  var centrales = [centralAtomicaBurns, centralDeCarbonExBosque]

  method centralesContaminantes() = centrales.filter({unaCentral => unaCentral.contamina()})

  method cubreSusNecesidades(energiaNecesaria) = self.suministroTotal() > energiaNecesaria

  method suministroTotal() = centrales.map({unaCentral => unaCentral.produccionEnergetica()}).sum()

  method estaEnElHorno() = self.suministroContaminantes()/self.suministroTotal() > 0.5 || self.todasLasCentralesSonContaminantes()

  method todasLasCentralesSonContaminantes() = centrales.all({unaCentral => unaCentral.contamina()})

  method suministroContaminantes() = self.centralesContaminantes().map({unaCentral => unaCentral.produccionEnergetica()}).sum()

  method centralQueMasProduce() = centrales.max({unaCentral => unaCentral.produccionEnergetica()})
}

object albuquerque {
  const caudal = 150
  var centrales = centralHidroelectrica

  method centralQueMasProduce() = centralHidroelectrica
}

object centralHidroelectrica {
 method produccionEnergetica(unCaudal) =  2 * unCaudal
}

object centralAtomicaBurns {
  var cantidadDeVarillas = 1

  method produccionEnergetica() = cantidadDeVarillas * 0.1
  method contamina() = cantidadDeVarillas > 20 
}

object centralDeCarbonExBosque {
  var capacidad = 0
  var riqueza = 0               // TODO: Hacer que la riqueza dependa de la ciudad en la que está la central

  method produccionEnergetica() = 0.5 + capacidad * riqueza
  method contamina() = true 
}

object centralEolicaElSuspiro {
  var turbinas = [0]

  method produccionEnergetica() = turbinas.sum()
  method contamina() = false
}