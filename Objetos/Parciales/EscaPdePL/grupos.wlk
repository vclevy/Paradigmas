import escapistas.*

class Grupo {
    const integrantes = []

    method puedenEscapar(unaSala) = integrantes.any({unIntegrante => unIntegrante.puedeEscapar(unaSala)})

    method puedenPagar(unaSala) = integrantes.all({unIntegrante => unIntegrante.puedePagar(unaSala)}) || self.sumaDeSaldos() > unaSala.precio()

    method sumaDeSaldos() = integrantes.sum({unIntegrante => unIntegrante.saldo()})

    method escapar(unaSala) {
      self.pagar(unaSala)
      self.hacerEscapar(unaSala)
    }

    method pagar(unaSala) {
        if (self.puedenPagar(unaSala)){
            const montoPorPersona = unaSala.precio() / integrantes.size()
            integrantes.forEach({unIntegrante => unIntegrante.pagar(montoPorPersona)})
        }
    }

    method hacerEscapar(unaSala) {
        integrantes.forEach({unIntegrante => unIntegrante.escapar(unaSala)})
    }
}