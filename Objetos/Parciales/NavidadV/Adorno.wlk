class Adorno{
    const peso
    const coeficienteDeSuperioridad
    const importancia

    method peso() = peso
    method importancia() = importancia
    method pesoBase() = peso*coeficienteDeSuperioridad
}

class Luz inherits Adorno{
    const lamparitas

    override method importancia() = super()*lamparitas
}

class FiguraElaborada inherits Adorno{
    const volumen

    override method importancia() = super()+volumen
}

const fechaActual = new Date()

class Guirnalda inherits Adorno{
    const anioQueFueComprada

    override method pesoBase() = super() - 100*(fechaActual.year()-anioQueFueComprada)
}
