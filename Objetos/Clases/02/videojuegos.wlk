object delfina {
  var diversion = 0
  var consolaEnMano = play
  
  method agarrar(unaConsola) {
    consolaEnMano = unaConsola
  }
  
  method diversion() = diversion
  
  method jugar(unJuego) {
    diversion+= unJuego.nivelDeDiversion(consolaEnMano)
    consolaEnMano.usar()
  }
}

object play {
  const jugabilidad = 10
  
  method jugabilidad() = jugabilidad
  
  method usar() {}
}

object portatil {
  var bateria = "alta"
  
  method jugabilidad() {
    if (bateria == "alta") {
      return 8
    } else {
      return 1
    }
  }
  
  method usar() {
    bateria = "baja"
  }
}

object arkanoid {
  method nivelDeDiversion(unaConsola) = 50
}

object mario {
  method nivelDeDiversion(unaConsola) {
    if (unaConsola.jugabilidad() > 5) {
      return 100
    } else {
      return 15
    }
  }
}

object pokemon {
  method nivelDeDiversion(unaConsola) = 10 * unaConsola.jugabilidad()
}