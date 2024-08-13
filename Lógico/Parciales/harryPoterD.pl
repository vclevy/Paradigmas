% Parte 1
%magos(Nombre,Sangre,Caracteristicas,CasaQueOdia).

mago(harry, mestiza, [coraje, amistoso, orgullo, inteligencia]).
mago(draco, pura, [inteligencia, orgullo]).
mago(hermione, impura, [inteligencia, orgullo , responsabilidad]).

casaQueOdia(harry,slytherin).
casaQueOdia(draco,hufflepuff).

caracteristicasSombrero(gryffindor,coraje).
caracteristicasSombrero(slytherin,orgullo).
caracteristicasSombrero(slytherin,inteligencia).
caracteristicasSombrero(ravenclaw,inteligencia).
caracteristicasSombrero(ravenclaw,responsabilidad).
caracteristicasSombrero(hufflepuff,amistoso).

% Punto 1 
permiteEntrar(gryffindor,Mago):-
    mago(Mago,_,_).
permiteEntrar(ravenclaw,Mago):-
    mago(Mago,_,_).
permiteEntrar(hufflepuff,Mago):-
    mago(Mago,_,_).
permiteEntrar(slytherin,Mago):-
    mago(Mago,Sangre,_),
    Sangre\= impura.

% Punto 2 
caracterApropiado(Mago,Casa):-
    mago(Mago,_, CaracteristicasMago), caracteristicasSombrero(Casa,_),
    forall(caracteristicasSombrero(Casa,Caracteristica),member(Caracteristica,CaracteristicasMago)).

% Punto 3 
puedeIr(hermione,gryffindor).
puedeIr(Mago,Casa):-
    caracterApropiado(Mago,Casa),
    permiteEntrar(Casa,Mago),
    not(casaQueOdia(Mago,Casa)).

% Punto 4 

mismaCasaQueElSiguiente([]).
mismaCasaQueElSiguiente([_]).
mismaCasaQueElSiguiente([Mago1,Mago2|Resto]):-
    puedeIr(Mago1, Casa),
    puedeIr(Mago2, Casa),
    Mago1\=Mago2,
    mismaCasaQueElSiguiente([Mago2 | Resto]).

esAmistoso(Mago):-
    mago(Mago,_,Caracteristicas),
    member(amistoso,Caracteristicas).
todosAmistosos([]).
todosAmistosos([Mago1|Resto]):-
    esAmistoso(Mago1),
    todosAmistosos(Resto).

cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    mismaCasaQueElSiguiente(Magos).

% Parte 2

accion(andarDeNocheFueraDeCama,-50).
accion(irALugarProhibido(bosque),-50).
accion(irALugarProhibido(seccionRestringidaBiblioteca),-10).
accion(irALugarProhibido(tercerPiso),-75).
accion(ganarPartidaAjedrezMagico,50).
accion(salvarASusAmigos,50).
accion(ganarleAVoldemort,75).
accion(responderEnClase(_,Dificultad,Profesor),Dificultad):-
    Profesor \= snape.
accion(responderEnClase(_,Dificultad,Profesor),Puntaje):-
    Profesor = snape, Puntaje is Dificultad/2.

acciones(harry,andarDeNocheFueraDeCama).
acciones(hermione,irALugarProhibido(tercerPiso)).
acciones(harry,irALugarProhibido(tercerPiso)).
acciones(harry,irALugarProhibido(bosque)).
acciones(draco,irAMazmorras).
acciones(ron,ganarPartidaAjedrezMagico).
acciones(hermione,salvarASusAmigos).
acciones(harry,ganarleAVoldemort).
acciones(hermione,responderEnClase(comoLevitarPluma,25,flitwick)).
acciones(hermione,responderEnClase(preguntaBezoar,20,snape)).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% Punto 1

buenAlumno(Mago):-
    esDe(Mago,_),
    forall((acciones(Mago,Accion),accion(Accion,Puntaje)),Puntaje>0).

accionRecurrente(Accion):-
    acciones(Mago1,Accion),
    acciones(Mago2,Accion),
    Mago1\=Mago2.

%Punto 2

puntajeTotal(Casa,Total):-
    esDe(_,Casa),
    findall(Puntos,(esDe(Mago,Casa),acciones(Mago,Accion),accion(Accion,Puntos)), TotalPuntos),
    sumlist(TotalPuntos, Total).

%Punto 3

casaGanadora(Casa):-
    puntajeTotal(Casa,TotalCasa),
    forall((esDe(_,Casas),puntajeTotal(Casas,TotalOtrasCasas),Casa\=Casas),TotalOtrasCasas<TotalCasa).