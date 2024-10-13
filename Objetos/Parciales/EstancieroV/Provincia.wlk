class Provincia{
    var property campos

    method jugadoresQueTienenCampos() = campos.map({unCampo=>unCampo.duenio()}).asSet()
    
}