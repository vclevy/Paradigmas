personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

esPeligroso(Personaje):-
    personaje(Personaje,mafioso(maton)).
esPeligroso(Personaje):-
    trabajaPara(Personaje,ElPeligroso),
    esPeligroso(ElPeligroso).

sonPareja(Persona1,Persona2):-
    pareja(Persona1,Persona2).
sonPareja(Persona1,Persona2):-
    pareja(Persona2,Persona1).
sonAmigos(Persona1,Persona2):-
    amigo(Persona1,Persona2).
sonAmigos(Persona1,Persona2):-
    amigo(Persona2,Persona1).

seRelacionan(Persona1,Persona2):-
    sonPareja(Persona1,Persona2).
seRelacionan(Persona1,Persona2):-
    sonAmigos(Persona2,Persona1).

duoTerrible(Personaje1,Personaje2):-
    seRelacionan(Personaje1,Personaje2),
    esPeligroso(Personaje1),esPeligroso(Personaje2).

estaEnProblemas(Persona):-
    trabajaPara(ElPeligroso,Persona),
    esPeligroso(ElPeligroso), sonPareja(ElPeligroso,Pareja),
    encargo(ElPeligroso,Persona,cuidar(Pareja)).

esCercano(Empleador,Empleado):-
    trabajaPara(Empleador,Empleado).
esCercano(Persona1,Persona2):-
    sonAmigos(Persona1,Persona2).

sanCayetano(Persona):-
    personaje(Persona,_),
    forall(esCercano(Persona,Cercano),encargo(Persona,Cercano,_)).

% Punto 4
cantidadDeEncargos(Persona,Cantidad):-
    findall(Encargo,encargo(_,Persona,Encargo),Encargos),
    length(Encargos,Cantidad).

masAtareado(Persona):-
    personaje(Persona,_),
    cantidadDeEncargos(Persona,CantidadMayor),
    forall((personaje(Personaje,_),cantidadDeEncargos(Personaje,MenorCantidad)),MenorCantidad<CantidadMayor).

%Punto 6
nivelDeRespeto(Personaje, Nivel):-
    personaje(Personaje,actriz(Peliculas)),
    length(Peliculas,Cantidad), Nivel is Cantidad/10.
nivelDeRespeto(Personaje,10):-
    personaje(Personaje,mafioso(resuelveProblemas)).
nivelDeRespeto(Personaje,1):-
    personaje(Personaje,mafioso(maton)).
nivelDeRespeto(Personaje,20):-
    personaje(Personaje,mafioso(capo)).

personajesRespetables(Respetables):-
    findall(Personaje,(personaje(Personaje,_),nivelDeRespeto(Personaje,Nivel),Nivel>9),Respetables).
