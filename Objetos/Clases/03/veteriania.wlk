import animales.*

object huellitas {
  const botiquin = ["Venda", "Venda", "Venda", "Alcohol", "Gasa"]
  const pacientes = #{nano, pepita, kali}
  
  method botiquin() = botiquin
  
  method agregarAlBotiquin(cosaAAgregar) {
    self.agregarA(botiquin, cosaAAgregar) // botiquin.add(cosaAAgregar)
  }
  
  method necesitaComprarVendas() {
    botiquin.count({ unElemento => unElemento == "Venda" }) < 3
  }
  
  method pacientes() = pacientes
  
  method agregarPaciente(unPaciente) {
    self.agregarA(pacientes, unPaciente) //  pacientes.add(unPaciente)
  }
  
  method agregarA(unaColeccion, unValor) {
    unaColeccion.add(unValor)
  }
  
  method darDeAlta(unPaciente) {
    pacientes.remove(unPaciente)
  }
  
  method cantidadDePacientes() = pacientes.size()
  
  method pacientesRecuperados() = pacientes.filter(
    { unPaciente => unPaciente.estaFeliz() }
  )
  
  method responsablesDePacientes() = pacientes.map({ unPaciente => unPaciente.responsable() }).asSet()
  
  method pacienteMasEnergetico() = pacientes.max({unPaciente => unPaciente.energia()})

  method curarATodos(){
		pacientes.forEach({ unPaciente => unPaciente.curar()})}

}