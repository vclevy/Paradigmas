% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% consumible(sustancia(efedrina)).
% consumible(compuesto(cafeVeloz)).
% consumible(producto(cocacola,_)).
% consumible(producto(gatoreit,_)).
% consumible(producto(naranju,_)).
% consumible(sustancia(cocaina)).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
tomo(passarella,Tomo):-
    tomo(_,Tomo),
    not(tomo(maradona,Tomo)).
tomo(pedemonti,Tomo):-
    tomo(chamot,Tomo).
tomo(pedemonti,Tomo):-
    tomo(maradona,Tomo).

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). sustanciaProhibida(cocaina).

%Punto 2

tomoSustanciaProhibida(Jugador):-
    tomo(Jugador,Prohibida),
    sustanciaProhibida(Prohibida).
tomoCompuestoConSustProhibida(Jugador):-
    tomo(Jugador,Compuesto),
    composicion(Compuesto,Sustancias),
    member(Prohibida,Sustancias), sustanciaProhibida(Prohibida).
tomoEnExceso(Jugador):-
    tomo(Jugador,producto(Producto,Cantidad)),
    maximo(Producto,Max), Cantidad>Max.

puedeSerSuspendido(Jugador):-
    tomoSustanciaProhibida(Jugador).
puedeSerSuspendido(Jugador):-
    tomoCompuestoConSustProhibida(Jugador).
puedeSerSuspendido(Jugador):-
    tomoEnExceso(Jugador).

% 3
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

sonAmigos(UnJugador,OtroJugador):-
    amigo(UnJugador,OtroJugador).
sonAmigos(UnJugador,OtroJugador):-
    amigo(OtroJugador,UnJugador).

seConocen(UnJugador,OtroJugador):-
    sonAmigos(UnJugador,OtroJugador).
seConocen(UnJugador,OtroJugador):-
    sonAmigos(UnJugador,Intermediario),
    sonAmigos(Intermediario,OtroJugador).

malaInfluencia(UnJugador,OtroJugador):-
    seConocen(UnJugador,OtroJugador),
    puedeSerSuspendido(UnJugador), puedeSerSuspendido(OtroJugador).

% 4
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
    atiende(Medico,_),
    forall(atiende(Medico,Jugador),puedeSerSuspendido(Jugador)).

%5
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).
nivelFalopez(Compuesto,NivelTotal):-
    composicion(Compuesto,Sustancias),
    findall(Nivel,(member(Sustancia,Sustancias),nivelFalopez(Sustancia,Nivel)), Niveles),
    sumlist(Niveles, NivelTotal).


cuantaFalopaTiene(Jugador,Cantidad):-
    findall(Nivel,(tomo(Jugador,Consumible),nivelFalopez(Consumible,Nivel)),Niveles),
    sumlist(Niveles,Cantidad).
    
    
