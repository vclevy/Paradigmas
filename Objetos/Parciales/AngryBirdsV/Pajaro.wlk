import AngryBirdsV.Huevo.*

class Pajaro{
    var ira = 0

    method ira(nuevaIra){
        ira=nuevaIra
    }

    method enojarse(){
        self.ira(ira*2)
    }

    method fuerza()

    method esFuerte() = self.fuerza()>50

    method tranquilizar(){
        ira-=5
    }

    method esHomenajeado() = true //booleano

    method puedeDerribar(unObstaculo) = self.fuerza() > unObstaculo.resistencia()

    method derribar(unObstaculo,unaIsla){
        if(self.puedeDerribar(unObstaculo)){
            unaIsla.obstaculos().remove(unObstaculo)
        }
    }
}

class Comun inherits Pajaro{
    override method fuerza() = ira*2

}

const red = new Rencoroso(cantidadDeEnojos=0,multiplicador=10)

object bomb inherits Pajaro{
    const maximoDeFuerza = 9000

    override method fuerza() = 9000.max(2*ira)
}

object chuck inherits Pajaro{
    var velocidad = 0

    override method fuerza() = self.fuerzaSegunVelocidad()

    method fuerzaSegunVelocidad(){
        if (velocidad<80){
            return 150
        }
        else {
            return 150 + (velocidad-80)*5
        }
    }

    override method enojarse(){
        velocidad=velocidad*2
    }

    override method tranquilizar(){} //*nada lo tranquiliza
}

class Rencoroso inherits Pajaro{
    const cantidadDeEnojos
    const multiplicador

    override method fuerza() = ira*multiplicador*cantidadDeEnojos
}

const terence = new Rencoroso(cantidadDeEnojos=3,multiplicador=1)

object matilda inherits Pajaro{
    const huevos = []

    override method fuerza() = 2*ira +  self.fuerzaDeHuevos()

    method fuerzaDeHuevos() = huevos.sum{unHuevo=>unHuevo.fuerza()}
    
    override method enojarse(){
        self.ponerHuevoDeDosKilos()
    }

    method ponerHuevoDeDosKilos(){
        huevos.add(huevo2)
    }
}




