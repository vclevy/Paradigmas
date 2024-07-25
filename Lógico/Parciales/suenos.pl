cree(gabriel,campanita).
cree(gabriel,magoDeOz).
cree(gabriel,cavenaghi).

cree(juan,conejoDePascua).

cree(macarena,reyesMagos).
cree(macarena,magoCapria).
cree(macarena,campanita).

suenio(gabriel,ganarLoteria([5,9])).
suenio(gabriel,futbolista(arsenal)).
suenio(juan,cantante(100000)).
suenio(macarena,cantante(10000)).

equipoChico(arsenal).
equipoChico(aldosivi).

esAmbiciosa(Persona):-
    suenio(Persona,_),
    findall(Dificultad,(suenio(Persona,Suenio),dificultad(Suenio,Dificultad)),ListaDificultades),
    sumlist(ListaDificultades,SumaDeDificultades),
    SumaDeDificultades>20.

dificultad(cantante(Ventas),6):-
    Ventas>500000.
dificultad(cantante(Ventas),4):-
    Ventas=<500000.
dificultad(ganarLoteria(Lista),Dificultad):-
    length(Lista, Nros), Dificultad is 10*Nros.
dificultad(futbolista(Equipo),3):-
    equipoChico(Equipo).
dificultad(futbolista(Equipo),16):-
    not(equipoChico(Equipo)).

quimica(Persona,Personaje):-
    cree(Persona,Personaje),
    tienenQuimica(Persona,Personaje).

tienenQuimica(Persona,campanita):-
    suenio(Persona,Suenio),
    dificultad(Suenio,Dificultad),
    Dificultad<5.

tienenQuimica(Persona,Personaje):-
    Personaje\=campanita,
    not(esAmbiciosa(Persona)),
    forall(suenio(Persona,Suenio),suenioPuro(Suenio)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(Discos)):-
    Discos<200000.

amigos(campanita,reyesMagos).
amigos(campanita,conejoDePascua).
amigos(conejoDePascua,cavenaghi).

% pajcua mojca mojquito majculino majcota dijco

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).

puedeAlegrar(Personaje,Persona):-
    suenio(Persona,_),
    quimica(Persona,Personaje),
    noEnfermo(Persona,Personaje).

noEnfermo(_,Personaje):-
    not(enfermo(Personaje)).  
      
noEnfermo(Persona,Personaje):-
    enfermo(Personaje),
    amigo(Personaje,Amigo),
    not(enfermo(Amigo)).