import Asadito.CriterioDePasaje.*
import Asadito.CriterioDeComida.*
import Asadito.Comida.Comida

class Persona{
    var property posicion
    const property elementosCercanos
    var property criterioParaPasar
    var property criterioParaComer
    var property comidasQueIngirio

    method pedirA(unaPersona,unElemento){
        if(!unaPersona.tiene(unElemento)){
            throw new Exception(message="No tiene el item")
        }
        criterioParaPasar.pasarA(unaPersona,self,unElemento)
    }

    method tiene(unElemento) = elementosCercanos.contains(unElemento)

    method come(unaComida) = criterioParaComer.puedeComer(unaComida)

    method comer(unaComida){
        if(self.come(unaComida)){
            comidasQueIngirio.add(unaComida)
        }
    }

    method estaPipon() = comidasQueIngirio.any{unaComida=>unaComida.esPesada()}

    method laEstaPasandoBien(){
        return not comidasQueIngirio.isEmpty() && self.laPasaBien()
    }

    method laPasaBien()
} 

object osky inherits Persona(posicion=1,elementosCercanos=[],criterioParaPasar=ortiva,criterioParaComer=vegetariano,comidasQueIngirio=[]){
    override method laPasaBien() = true
}
object moni inherits Persona(posicion=1,elementosCercanos=[],criterioParaPasar=ortiva,criterioParaComer=vegetariano,comidasQueIngirio=[]){
    override method laPasaBien() = posicion == 11
}
object facu inherits Persona(posicion=1,elementosCercanos=[],criterioParaPasar=ortiva,criterioParaComer=vegetariano,comidasQueIngirio=[]){
    override method laPasaBien() = self.comidasQueIngirio().any({unaComida=>unaComida.esCarne()})
}

object vero inherits Persona(posicion=1,elementosCercanos=[],criterioParaPasar=ortiva,criterioParaComer=vegetariano,comidasQueIngirio=[]){
    override method laPasaBien() = self.elementosCercanos().size()<=3
}

