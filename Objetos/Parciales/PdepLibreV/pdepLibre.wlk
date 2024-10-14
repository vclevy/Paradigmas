import PdepLibre.Usuario.*
import PdepLibre.Producto.*

object pdepLibre{
    const productos = []
    const usuarios = #{}

    method penalizarMorosos(){
        self.usuariosMorosos().forEach({unUsuario=>unUsuario.reducirPuntos(1000)})
    }

    method usuariosMorosos() = usuarios.filter{unUsuario=>unUsuario.esMoroso()}

    method eliminarCuponesUsados(){
        usuarios.forEach({unUsuario=>unUsuario.eliminarCuponesUsados()})
    }

    method nombresDeProductosEnOferta() = productos.map({unProducto=>unProducto.nombreEnOferta()})

    method actualizarNivelDeUsuario(){
        usuarios.forEach({unUsuario=>unUsuario.actualizarNivel()})
    }
}