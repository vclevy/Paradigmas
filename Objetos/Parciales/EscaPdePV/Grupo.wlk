import EscaPdeP.NoHayDineroException.NoHayDineroException
import EscaPdeP.Escapista.Escapista
class Grupo{
    var escapistas = #{}

    method puedenEscapar(unaSala) = escapistas.any{unEscapista=>unEscapista.puedeSalirDe(unaSala)}

    method montoPorPersonaDe(unaSala) = unaSala.precio() / escapistas.size()

    method pagar(unaSala){
        const unaCantidad = self.montoPorPersonaDe(unaSala)

        escapistas.forEach{unEscapista=>unEscapista.pagar(unaCantidad)}
    }

    method saldoDeGrupo() = escapistas.sum{unEscapista=>unEscapista.saldo()}

    method puedenPagar(unaSala) = self.saldoDeGrupo() > unaSala.precio() || escapistas.all{unEscapista=>unEscapista.puedePagar(unaSala)}

    method escaparDe(unaSala){
        if(!self.puedenPagar(unaSala)){
            throw new NoHayDineroException()
        }
        if(!self.puedenEscapar(unaSala)){
            throw new Exception(message="No pueden escapar")
        }
        self.pagar(unaSala)
        escapistas.forEach{unEscapista=>unEscapista.escapa(unaSala)}
    }
}