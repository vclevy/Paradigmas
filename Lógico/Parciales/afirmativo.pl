%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


%Punto 1

frecuenta(vega,quilmes).
frecuenta(Agente,buenosAires):-
    tarea(Agente,_,_).
frecuenta(Agente,marDelPlata):-
    tarea(Agente,vigilar(Lugares),_),
    member(negocioDeAlfajores,Lugares).
frecuenta(Agente,Lugar):-
    tarea(Agente,_,Lugar).

% Punto 2

inaccesible(Lugar):-
    ubicacion(Lugar),
    not(frecuenta(_,Lugar)).

%Punto 3

afincado(Agente):-
    tarea(Agente,_,Lugar),
    forall(tarea(Agente,_,MismoLugar),MismoLugar=Lugar).

%Punto 4

esJefeDe(Persona,OtraPersona):-
    jefe(Persona,OtraPersona).
esJefeDe(Persona,OtraPersona):-
    jefe(Persona,Intermediario),
    esJefeDe(Intermediario,OtraPersona).

cadenaDeMando([Uno,Otro]):-
    esJefeDe(Uno,Otro).
cadenaDeMando([Jefe,Jefecito|Resto]):-
    esJefeDe(Jefe,Jefecito),
    cadenaDeMando([Jefecito|Resto]).

%Punto 5

puntajeTarea(vigilar(Lugares),Puntaje):-
    length(Lugares,Cantidad),
    Puntaje is Cantidad*5.
puntajeTarea(ingerir(_,Tamano,Cantidad),Puntaje):-
    Puntaje is -(10*Tamano*Cantidad).
puntajeTarea(apresar(_,Recompensa),Puntaje):-
    Puntaje is Recompensa/2.
puntajeTarea(asuntosInternos(Investigado),Puntaje):-
    puntajeAgente(Investigado,PuntosInvestigado),
    Puntaje is 2*PuntosInvestigado.

puntajeAgente(Agente,PuntajeTotal):-
    tarea(Agente,_,_),
    findall(Puntaje,(tarea(Agente,Tarea,_),puntajeTarea(Tarea,Puntaje)),Puntajes),
    sumlist(Puntajes,PuntajeTotal).
    
agentePremiado(AgentePremiado):-
    puntajeAgente(AgentePremiado,PuntajeMaximo),
    forall((puntajeAgente(OtroAgente,PuntajeMenor),OtroAgente\=AgentePremiado),PuntajeMenor<PuntajeMaximo).
