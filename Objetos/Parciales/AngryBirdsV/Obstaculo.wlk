class Obstaculo{
    const resistencia

    method resistencia() = resistencia
    
}

class CerditoArmado inherits Obstaculo{
    const armadura

    override method resistencia() = 10*armadura.resistencia()
}


class Armadura{
    const resistenciaArmadura

    method resistenciaArmadura() = resistenciaArmadura
}

const casco = new Armadura(resistenciaArmadura=3)
const escudo = new Armadura(resistenciaArmadura=3)