object nano {
  var energia = 100
  const responsable = "Ro"
  
  method energia() = energia
  
  method responsable() = responsable
  
  method comer(unosGramos) {
    energia += 2 * unosGramos
  }
  
  method galopar(unaDistancia) {
    energia -= unaDistancia
  }
  
  method estaFeliz() = true

  method curar() {
		self.galopar(3)
		self.comer(3000)
		self.galopar(5)
	}

}

object pepita {
  var energia = 100
  const responsable = "Gus"
  var dondeEsta = "General las Heras"
  
  method energia() = energia
  
  method responsable() = responsable
  
  method dondeEsta() = dondeEsta
  
  method comer(unosGramos) {
    energia += unosGramos / 2
  }
  
  method volarHacia(unaCiudad) {
    dondeEsta = unaCiudad
    energia /= 2
  }
  
  method estaFeliz() = dondeEsta == "Lihuel Calel"

  method curar() {
		self.volarHacia("Lihuel Calel")
	}

}

object kali {
  var energia = 100
  const responsable = "Dani"
  var edad = 15
  
  method energia() = energia
  
  method responsable() = responsable
  
  method edad() = edad
  
  method comer(unosGramos) {
    energia += unosGramos
  }
  
  method cumplirAnios() {
    edad += 1
  }
  
  method estaFeliz() = energia > 30

  method curar() {
		self.comer(400)
	}
}