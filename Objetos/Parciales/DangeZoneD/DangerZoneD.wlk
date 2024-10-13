object isis {
  
}

class Empleado{
    var property salud
    var property habilidades  

    method incapacitado() 
}

class Espia inherits Empleado{
    const saludCritica = 15

    method aprenderHabilidad(habilidad) {
      habilidades.add(habilidad)
    }

    override method incapacitado()= salud<saludCritica
}


class Oficinista inherits Empleado{
    var property estrellas
    var property saludCritica = 40-5*estrellas

    method pasarMision(){
        estrellas += 1
    }
}