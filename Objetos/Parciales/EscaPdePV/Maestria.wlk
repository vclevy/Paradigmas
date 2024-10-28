import EscaPdeP.Escapista.Escapista
object amateur{
    method puedeEscaparDe(unaSala,unEscapista){
        return not unaSala.esDificil() && unEscapista.hizoMuchasSalas()
    }
}

object profesional{
    method puedeEscaparDe(unaSala,unEscapista) = true
}