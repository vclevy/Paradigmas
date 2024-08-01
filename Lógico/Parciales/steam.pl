juego(accion(callOfDuty),5).
juego(accion(batmanAA),10).
juego(mmorpg(wow,5000000),30).
juego(mmorpg(lineage2,6000000),15).
juego(puzzle(plantsVsZombies,40,media),10).
juego(puzzle(tetris,10,facil),0).

oferta(callOfDuty,10).
oferta(plantsVsZombies,50).

usuario(nico,[batmanAA,plantsVsZombies,tetris],[compra(lineage2)]).
usuario(fede,[],[regalo(callOfDuty,nico),regalo(wow,nico)]).
usuario(clara,[],[regalo(callOfDuty,cande)]). %añadido x mí para probar adicto a descuentos
usuario(cande,[],[regalo(callOfDuty,clara)]).
usuario(rasta,[lineage2],[]).
usuario(agus,[],[]).
usuario(valen,[plantsVsZombies,tetris],[compra(lineage2)]).
usuario(felipe,[plantsVsZombies],[compra(tetris)]).

cuantoSale(Juego,PrecioFinal):-
    juego(Juego,Precio),
    estaDeOferta(Juego,Porcentaje),
    PrecioFinal is Precio*(1-(Porcentaje/100)).

cuantoSale(Juego,PrecioFinal):-
    juego(Juego,PrecioFinal),
    not(estaDeOferta(Juego,_)).

estaDeOferta(Juego,Porcentaje):-
    juego(Juego,_),
    nombre(Juego,Nombre),
    oferta(Nombre,Porcentaje).
    
nombre(accion(Nombre),Nombre).
nombre(mmorpg(Nombre,_),Nombre).
nombre(puzzle(Nombre,_,_),Nombre).

juegoPopular(Juego):-
    juego(Juego,_),
    esPopular(Juego).

esPopular(accion(_)).
esPopular(mmorpg(_, Usuarios)):-
    Usuarios > 1000000.
esPopular(puzzle(_, _,facil)).
esPopular(puzzle(_, 25,_)).

tieneUnBuenDescuento(Juego):-
    nombre(Juego, Nombre),
    oferta(Nombre, Descuento),
    Descuento > 5.

buenDescuento(Juego):- %con el nombre, no el functor!
    oferta(Juego, Descuento),
    Descuento > 5.

buenaAdquisicion(compra(Juego)):-
    buenDescuento(Juego).

buenaAdquisicion(regalo(Juego,_)):-
    buenDescuento(Juego).

adictoALosDescuentos(Usuario) :-
    usuario(Usuario, _, Adquisiciones),
    forall(member(Adquisicion, Adquisiciones), buenaAdquisicion(Adquisicion)).

fanaticoDe(Genero,Usuario):-
    usuario(Usuario,Juegos,_),
    esDe(Genero,member(Juego,Juegos)),
    esDe(Genero,member(OtroJuego,Juegos)),
    Juego\=OtroJuego.

monotematico(Genero,Usuario):-
    usuario(Usuario,Juegos,_),
    poseeUnicoGenero(Genero,Juegos).

poseeUnicoGenero(Genero,Juegos):-
    forall(member(Juego, Juegos), esDe(Genero,Juego)).

esDe(accion,Juego):-
    juego(accion(Juego),_).

esDe(mmorpg,Juego):-
    juego(mmorpg(Juego,_),_).

esDe(puzzle,Juego):-
    juego(puzzle(Juego,_,_),_).

sonBuenosAmigos(UnAmigo,OtroAmigo):-
    usuario(UnAmigo,_,Adquisiciones1),
    usuario(OtroAmigo,_,Adquisiciones2),
    regalaJuegoPopular(Adquisiciones1,OtroAmigo),
    regalaJuegoPopular(Adquisiciones2,UnAmigo).

regalaJuegoPopular(Adquisiciones,Amigo):-
    member(regalo(Juego,Amigo),Adquisiciones),
    juegoPopular(Juego). %no funciona pq le estoy pasando el nombre no el functor

cuantoGastara(Usuario,Dinero):-
    usuario(Usuario,_,Adquisiciones),
    findall(Plata,dineroDeJuegos(Adquisiciones,Plata),ListaDePlata),
    sumlist(ListaDePlata, Dinero).

dineroDeJuegos(Adquisiciones,Plata):-
    









