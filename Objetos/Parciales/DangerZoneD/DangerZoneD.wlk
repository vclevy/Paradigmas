object isis {
  
}

class Empleado{
    var property salud
    var property habilidades  
    var property jefe  

    method incapacitado()
    method puedeUsarHabilidad(habilidad){
        not self.incapacitado() && habilidades.contains(habilidad)
    } 
    method enfrentarMision(danio){
      salud -= danio
    }
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

    method ascender(){
        //const oficinista = new Oficinista (salud = self.salud(),habilidades = self.habilidades(), jefe = self.jefe(), estrellas = self.estrellas())
       // return oficinista
}
    method pasarMision(){
        estrellas += 1
    }
}

class Equipo {
    const miembros = []

    method agregarMiembro(empleado) {
        miembros.add(empleado)
    }

    method resolverMision(peligrosidad) {
        miembros.forEach({empleado => empleado.enfrentarMision(peligrosidad/3)})
    }
}

class Mision {
//     const dificultad
//     const habilidadesMision
}