% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). 
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina).

puedeSerSuspendido(Jugador):-
    tomo(Jugador,Bebida),
    esBebidaQueSuspende(Bebida).

esBebidaQueSuspende(sustancia(Sustancia)):-
    sustanciaProhibida(Sustancia).

esBebidaQueSuspende(compuesto(Compuesto)):-
    composicion(Compuesto,Sustancias),
    findall(Sustancia,(member(Sustancia,Sustancias),sustanciaProhibida(Sustancia)),Componentes),
    length(Componentes,Cantidad),
    Cantidad>0.

esBebidaQueSuspende(producto(Producto,Cantidad)):-
    maximo(Producto,MaximoPermitido),
    Cantidad>MaximoPermitido.

amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

malaInfluencia(UnJugador,OtroJugador):-
    puedeSerSuspendido(UnJugador),
    puedeSerSuspendido(OtroJugador),
    seConocen(UnJugador,OtroJugador).

seConocen(UnJugador, OtraPersona):-
    amigo(UnJugador,OtraPersona).
seConocen(UnJugador, OtraPersona):-
    amigo(UnJugador, Alguien),
    seConocen(Alguien, OtraPersona).

atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
    atiende(Medico,_),
    forall(atiende(Medico,Jugador),puedeSerSuspendido(Jugador)).

nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

cuantaFalopaTiene(Jugador,Cantidad):-
    tomo(Jugador,_),
    findall(Falopa,falopa(Jugador,Falopa),CantidadDeFalopa),
    sum_list(CantidadDeFalopa,Cantidad).

falopa(Jugador,Falopa):-
    tomo(Jugador,Bebida), 
    falopaEnBebida(Bebida,Falopa).

falopaEnBebida(producto(_, _),0).
falopaEnBebida(sustancia(Sustancia),Cantidad):-
    nivelFalopez(Sustancia,Cantidad).
/*falopaEnBebida(compuesto(Compuesto),Cantidad):-
    composicion(Compuesto,Componentes),
    findall(Falopez,(member(Componente,Componentes), nivelFalopez(Componente,Falopez)),CantidadDeFalopez),
    sum_list(CantidadDeFalopez, Cantidad).*/

falopaEnBebida(compuesto(Compuesto),Cantidad):-
    composicion(Compuesto,Componentes),
    findall(Falopez,nivelDeComponentes(Componentes,Falopez),CantidadDeFalopez),
    sum_list(CantidadDeFalopez, Cantidad).

nivelDeComponentes(Componentes,Falopez):-
    member(Componente,Componentes),
    nivelFalopez(Componente,Falopez).

