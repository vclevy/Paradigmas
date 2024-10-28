class Sala{
    var nombre
    var dificultad

    method precio() = 10000

    method esDificil() = dificultad>7
}

class Anime inherits Sala{
    override method precio() = super() + 7000
}

class Historia inherits Sala{
    const enQueEstaBasada

    override method precio() = super() + 0.0314*dificultad

    override method esDificil() = super() && enQueEstaBasada != "Hechos reales"
    }
}

class Terror inherits Sala{
    const sustos

    override method precio() = super() + self.aumentoSegunSustos()

    method aumentoSegunSustos(){
        if (sustos>5){
            return self.precio()*0.2
        }
        else return 0
    }

    override method esDificil() = super() || sustos>5
}