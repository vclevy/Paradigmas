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

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

esPeligroso(Personaje):-
    personaje(Personaje, Actividad),
    realizaActividadPeligrosa(Actividad).

esPeligroso(Personaje):-
    tieneEmpleadosPeligrosos(Personaje).

realizaActividadPeligrosa(ladron(Lugares)):-
    member(licorerias, Lugares).
    
realizaActividadPeligrosa(mafioso(maton)).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje, Empleado),
    personaje(Empleado, ActividadEmpleado),
    realizaActividadPeligrosa(ActividadEmpleado).

duoTemible(Personaje,OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    pareja(Personaje,OtroPersonaje). % se pdoría hacer un predicado q sea sonParejaOAmigos.

duoTemible(Personaje,OtroPersonaje):-
    esPeligroso(Personaje),
    esPeligroso(OtroPersonaje),
    amigo(Personaje,OtroPersonaje).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
    encargo(Jefe,Personaje,Tarea),
    esPeligroso(Jefe),
    encargoPeligroso(Jefe,Tarea).

estaEnProblemas(Personaje):-
    encargo(_,Personaje,buscar(Buscado,_)),
    personaje(Buscado,boxeador).

encargoPeligroso(Jefe,cuidar(Personaje)):-
    pareja(Jefe,Personaje).

sanCayetano(Personaje):-
    forall(tieneCerca(Personaje,Cercano),encargo(Personaje,Cercano,_)).

tieneCerca(Personaje,Cercano):-
    amigo(Personaje,Cercano).

tieneCerca(Personaje,Cercano):-
    trabajaPara(Personaje,Cercano).

masAtareado(Personaje):-
    personaje(Personaje,_),
    cantidadDeEncargos(Personaje,Cantidad),
    forall((cantidadDeEncargos(OtroPersonaje,CantidadMenor), Personaje \= OtroPersonaje), Cantidad > CantidadMenor).

cantidadDeEncargos(Personaje,Cantidad):-
    personaje(Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo),Encargos),
    length(Encargos, Cantidad).

nivelDeRespeto(actriz(Peliculas),Nivel):-
    length(Peliculas,CantidadDePeliculas),
    Nivel is CantidadDePeliculas/10.

nivelDeRespeto(mafioso(resuelveProblemas),10).
nivelDeRespeto(mafioso(maton),1).
nivelDeRespeto(mafioso(capo),20).

esPersonajeRespetable(Personaje):-
    personaje(Personaje,Actividad),
    nivelDeRespeto(Actividad,Nivel),
    Nivel>9.

personajesRespetables(PersonajesRespetables):-
    findall(Personaje,esPersonajeRespetable(Personaje),PersonajesRespetables).

hartoDe(Personaje1,Personaje2):- %personje 2 harto del 1
    personaje(Personaje1,_),
    personaje(Personaje2,_),
    forall(encargo(_,Personaje1,Tarea),requiereInteractuarCon(Personaje2,Tarea)).

requiereInteractuarCon(Personaje,cuidar(Personaje)).
requiereInteractuarCon(Personaje,buscar(Personaje,_)).
requiereInteractuarCon(Personaje,ayudar(Personaje)).

    












