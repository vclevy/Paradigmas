object manic {
  var estrellas = 10
  var globos = 60
  
  method encontrarEstrellas() {
    estrellas += 8
  }
  
  method regalarEstrellas() {
    estrellas = 0.max(estrellas - 1)
  }
  
  method estrellas() = estrellas
  
  method estrellas(unaCantidad) {
    estrellas = unaCantidad
  }
  
  method tieneTodoListo() = estrellas >= 4
  
  method globos() = globos
  
  method tieneSuficientesGlobos() = globos > 50
  
  method comprarGlobos(unaCantidad) {
    globos += unaCantidad
  }
}

object chuy {
  var globos = 60
  
  method tieneTodoListo() = true
  
  method tieneSuficientesGlobos() = globos > 50
  
  method comprarGlobos(unaCantidad) {
    globos += unaCantidad
  }
}

object capy {
  var globos = 60
  var latas = 0
  
  method latas() = latas
  
  method recolectarLatas() {
    latas += 1
  }
  
  method reciclarLatas() {
    latas = 0.max(latas - 5)
  }
  
  method tieneTodoListo() = latas.even()
  
  method comprarGlobos(unaCantidad) {
    globos += unaCantidad
  }
}

object fiesta {
  var property quienOrganiza = manic
  
  method estaPreparada() = quienOrganiza.tieneTodoListo() && quienOrganiza.tieneSuficientesGlobos()
}