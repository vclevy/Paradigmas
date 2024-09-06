object tom {
  var energia = 80
  var posicion = 0
  
  method posicion() = posicion
  
  method velocidad() = 5 + (energia / 10)
  
  method esMasVeloz(unRaton) = self.velocidad() > unRaton.velocidad()
  
  method distancia(unRaton) = unRaton.posicion() - self.posicion()
  
  method consumirEnergia(unRaton) {
    energia -= 0.max((0.5 * self.velocidad()) * self.distancia(unRaton))
  }
  
  method correrA(unRaton) {
    self.consumirEnergia(unRaton)
    posicion = unRaton.posicion()
  }
}

object jerry {
  var peso = 0
  var posicion = 10
  
  method posicion() = posicion
  
  method velocidad() = 10 - peso
}

object robotRaton {
  var posicion = 12
  
  method velocidad() = 8
  
  method posicion() = posicion
}

