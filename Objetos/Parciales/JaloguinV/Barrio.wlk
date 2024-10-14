import jaloguin.Personas.Ninio
class Barrio{
    const habitantes

    method topTresAsustadores() = habitantes.sortedBy({unHabitante, otroHabitante => unHabitante.bolsa() > otroHabitante.bolsa()}).take(3)

    method elementosUtilizados() = habitantes.filter({unHabitante=> unHabitante.tieneMasDeXCaramelos(10)}).map({unHabitante => unHabitante.elementosPuestos()}).asSet()
}