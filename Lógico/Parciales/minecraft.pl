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
    not(hayMonstruos(Lugar)),
    porcentajeHambrientos(Lugar, Porcentaje),
    poblacionTotal(Lugar, Total),
    Nivel is Porcentaje / Total.
nivelPeligrosidad(Lugar, Nivel):-
    lugar(Lugar,_,NivelOscuridad),
    poblacionTotal(Lugar,0),
    Nivel is NivelOscuridad * 10.

poblacionTotal(Lugar,Total):-
    lugar(Lugar,Poblacion,_),
    length(Poblacion,Total).

estaHambrientoYEn(Jugador,Lugar):-
    jugador(Jugador,_,Hambre),
    lugar(Lugar,Personas,_),
    member(Jugador,Personas),
    Hambre<4.

porcentajeHambrientos(Lugar, Porcentaje):-
    findall(Jugador, estaHambrientoYEn(Jugador, Lugar),Hambrientos),
    length(Hambrientos,Porcentaje).

% Punto 3

item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

/*puedeConstruir(Jugador, Item):-         %itemSiple(elemento, cantidadNecesaria)
    item(Item,Materiales),
    tieneLosMateriales(Jugador, Materiales).

tieneLosMateriales(Jugador, Materiales):-
    jugador(Jugador, ItemsJugador,_),
    */
    
  % Verifica si un jugador puede construir un ítem.
puedeConstruir(Jugador, Item) :-
    item(Item, Requisitos),
    puedeCumplirRequisitos(Jugador, Requisitos).

% Verifica si un jugador puede cumplir con todos los requisitos para construir un ítem.
puedeCumplirRequisitos(_, []).
puedeCumplirRequisitos(Jugador, [Requisito|OtrosRequisitos]) :-
    cumpleRequisito(Jugador, Requisito),
    puedeCumplirRequisitos(Jugador, OtrosRequisitos).

% Verifica si un jugador cumple con un requisito (ya sea ítem simple o compuesto).
cumpleRequisito(Jugador, itemSimple(Item, Cantidad)) :-
    cantidadDelItem(Jugador, Item, CantidadPoseida),
    CantidadPoseida >= Cantidad.
cumpleRequisito(Jugador, itemCompuesto(ItemCompuesto)) :-
    puedeConstruir(Jugador, ItemCompuesto).
