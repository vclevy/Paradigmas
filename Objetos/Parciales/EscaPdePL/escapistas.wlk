class Escapista {
    var maestria
    var salasDeLasQueSalio = []
    var saldo

    method saldo() = saldo

    method puedeEscapar(unaSala) = maestria.puedeEscapar(unaSala, self)

    method puedePagar(unaSala) = unaSala.precio() < saldo

    method subirMaestria() {
      if (maestria == amateur && self.hizoMuchasSalas())
      maestria = profesional
    }

    method hizoMuchasSalas() = salasDeLasQueSalio.size() >= 6

    method salasDeLasQueSalio() = salasDeLasQueSalio.asSet()

    method escapar(unaSala) {
      salasDeLasQueSalio.add(unaSala)
    }
}

object amateur {
    method puedeEscapar(unaSala, unEscapista) = not(unaSala.esDificil()) && unEscapista.hizoMuchasSalas()
}

object profesional {
    method puedeEscapar(_unaSala, _unEscapista) = true
}
