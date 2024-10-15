// No se que boronga hice intentando pushear mi parcial y perdi el archivo Peliculas.wlk
// Copio el de valen porque tengo los huevos inflados y ademas es bastante parecido a lo que hice
// Me pase los import por las bolas

class Pelicula {
    const nombre
    const elenco

    method sueldoDeElenco() = elenco.sum{unArtista=>unArtista.sueldo()}

    method presupuesto() = self.sueldoDeElenco()*1.7

    method ganancias() = self.cuantoRecaudo() - self.presupuesto() 

    method cuantoRecaudo() = 1000000

    method cantidadDeIntegrantes() = elenco.size()

    method esEconomica() = self.presupuesto() < 500000

    method nombre() = nombre

    method rodar(){
        elenco.forEach{unArtista=>unArtista.actuar()}
    }
}

class PeliculaDeDrama inherits Pelicula{

    override method cuantoRecaudo() = super() + 100000*(nombre.size())
}
class PeliculaDeAccion inherits Pelicula{
    const vidriosRotos

    override method presupuesto() = super() + 1000*vidriosRotos

    override method cuantoRecaudo() = super() + 50000*self.cantidadDeIntegrantes()
}


class PeliculaDeTerror inherits Pelicula{
    const cuchos

    override method cuantoRecaudo() = super() + 20000*cuchos
    
}

class PeliculaDeComedia inherits Pelicula{
}



