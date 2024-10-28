import EscaPdeP.Maestria.*
import EscaPdeP.Sala.*
class Escapista{
    var maestria
    var salasDeLasQueSalio
    var saldo
    
    method puedeSalirDe(unaSala){
        maestria.puedeEscaparDe(unaSala,self)
    }

    method hizoMuchasSalas() = salasDeLasQueSalio > 6

    method subirDeMaestria(){
        if(self.es(profesional)){
            throw new Exception(message="No se puede ser mas crack")
        }
        if(self.hizoMuchasSalas()){
            maestria = profesional
        }
    }

    method es(unaMaestria) = maestria == unaMaestria


    method salasDeLasQueSalio() = salasDeLasQueSalio.map{unaSala=>unaSala.nombre()}.asSet()

    method pagar(unaCantidad){
        saldo-=unaCantidad
    }

    method saldo() = saldo

    method puedePagar(unaSala) = saldo > unaSala.precio()

    method escapa(unaSala){
        salasDeLasQueSalio.add(unaSala)
    }
}