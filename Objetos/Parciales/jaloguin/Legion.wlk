class Legion{
    var miembros

    method capacidadDeAsustar() = miembros.sum({unMiembro=>unMiembro.capacidadDeAsustar()})

    method caramelos() = miembros.sum({unMiembro=>unMiembro.bolsa()})
}