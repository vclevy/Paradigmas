import minions.*
import armas.*
class Villano {
    var minions = []

    method nuevoMinion() {
        minions.add(new Minion(bananas = 5, armas = [new RayoCongelante(potencia = 10)]))
    }

    method minionMasUtil() = minions.max({unMinion => unMinion.maldadesQueHizo()})

    method minionsInutiles() = minions.filter({unMinion => unMinion.noHizoMaldades()})
}

