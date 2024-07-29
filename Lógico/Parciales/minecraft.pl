jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Jugador, Item):-
    jugador(Jugador,Elementos,_),
    member(Item,Elementos).

sePreocupaPorSuSalud(Jugador):-
    tieneItem(Jugador,C1),
    tieneItem(Jugador,C2),
    comestible(C1),
    comestible(C2),
    C1\=C2.

cantidadDelItem(Jugador, Item, Cantidad):-
    jugador(Jugador,_,_),
    tieneItem(_, Item),
    findall(Item,tieneItem(Jugador,Item),LosItems),
    length(LosItems, Cantidad).
    
tieneMasDe(Jugador1,Item):- 
    cantidadDelItem(Jugador1,Item,CantidadJ1),
    forall((cantidadDelItem(Jugador2,Item,CantidadJ2),Jugador2\=Jugador1), CantidadJ1>CantidadJ2 ).

% Punto 2

hayMonstruos(Bioma):-
    lugar(Bioma,_,NivelOscuridad),
    NivelOscuridad > 6.

correPeligro(Jugador):-
    lugar(Bioma,Jugadores,_),
    member(Jugador,Jugadores), 
    hayMonstruos(Bioma).
correPeligro(Jugador):-
    comestible(Elemento),
    jugador(Jugador,Items,Hambre),
    not(member(Elemento,Items)),
    Hambre<4.

nivelPeligrosidad(Lugar,100):-
    hayMonstruos(Lugar).
nivelPeligrosidad(Lugar, Nivel):-
    not(HayMonstruos(Lugar)),
    porcentajeHambrientos(Lugar, Porcentaje),
    poblacionTotal(Lugar, Total),
    Nivel is Porcentaje / Total.


poblacionTotal(Lugar,Total):-
    lugar(Lugar,Poblacion,_),
    length(Poblacion,Total).

estaHambriento(Jugador):-
    jugador(Jugador,_,Hambre),
    Hambre<4