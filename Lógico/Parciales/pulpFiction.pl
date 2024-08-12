
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

esPeligroso(Personaje):-
    personaje(Personaje,Actividad),
    actividadPeligrosa(Actividad).

esPeligroso(Personaje):-
    personaje(Personaje,_),
    tieneEmpleadosPeligrosos(Personaje).

actividadPeligrosa(mafioso(maton)).
actividadPeligrosa(ladron(Lugares)):-
    member(licorerias,Lugares).

tieneEmpleadosPeligrosos(Personaje):-
    trabajaPara(Personaje,Empleado),
    esPeligroso(Empleado).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

duoTemible(UnPersonaje,OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    relativos(UnPersonaje,OtroPersonaje).

relativos(UnPersonaje,OtroPersonaje):-
    amigo(UnPersonaje,OtroPersonaje).

relativos(UnPersonaje,OtroPersonaje):-
    pareja(UnPersonaje,OtroPersonaje).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnProblemas(butch).
estaEnProblemas(Personaje):-
    personaje(Personaje,_),
    trabajaPara(Empleador,Personaje),
    esPeligroso(Empleador),
    debeCuidarParejaDe(Empleador,Personaje).

estaEnProblemas(Personaje):-
    encargo(_, Personaje, buscar(OtroPersonaje,_)),
    esBoxeador(OtroPersonaje).

esBoxeador(OtroPersonaje):-
    personaje(OtroPersonaje,boxeador).

debeCuidarParejaDe(Empleador,Personaje):-
    encargo(Empleador,Personaje,cuidar(Pareja)),
    pareja(Empleador,Pareja).

sanCayetano(Personaje):-
    personaje(Personaje,_),
    encargo(Personaje,_,_), % si tiene al menos un encargo
    forall(personaCercana(Personaje,Cercano),encargo(Personaje,Cercano,_)).

personaCercana(Personaje,Cercano):-
    amigo(Personaje,Cercano).

personaCercana(Personaje,Cercano):-
    trabajaPara(Personaje,Cercano).

masAtareado(Personaje):-
    personaje(Personaje,_),
    encargosDe(Personaje,CantidadDeEncargos),
    forall((encargosDe(OtroPersonaje,Cantidad),OtroPersonaje\=Personaje),Cantidad<CantidadDeEncargos).

encargosDe(Personaje,Cantidad):-
    personaje(Personaje,_),
    findall(Encargo,encargo(_,Personaje,Encargo),Encargos),
    length(Encargos,Cantidad).

personajesRespetables(Personajes):-
    findall(Personaje,esRespetable(Personaje),Personajes).

esRespetable(Personaje):-
    personaje(Personaje,Actividad),
    nivelDeRespeto(Actividad,Respeto),
    Respeto>9.

nivelDeRespeto(actriz(Peliculas),Respeto):-
    length(Peliculas,CantidadDePeliculas),
    Respeto is CantidadDePeliculas/10.

nivelDeRespeto(mafioso(resuelveProblemas),10).
nivelDeRespeto(mafioso(maton),1).
nivelDeRespeto(mafioso(capo),20).

hartoDe(UnPersonaje,OtroPersonaje):-
    personaje(UnPersonaje,_),
    personaje(OtroPersonaje,_),
    forall(encargo(_,UnPersonaje,Encargo),requiereInteractuarConPersonajeOAmigo(Encargo,OtroPersonaje)).

requiereInteractuarConPersonajeOAmigo(cuidar(Personaje),Personaje).
requiereInteractuarConPersonajeOAmigo(cuidar(OtroPersonaje),Personaje):-
    amigo(OtroPersonaje,Personaje).

requiereInteractuarConPersonajeOAmigo(buscar(Personaje,_),Personaje).
requiereInteractuarConPersonajeOAmigo(buscar(OtroPersonaje,_),Personaje):-
    amigo(OtroPersonaje,Personaje).

requiereInteractuarConPersonajeOAmigo(ayudar(Personaje),Personaje).
requiereInteractuarConPersonajeOAmigo(ayudar(OtroPersonaje),Personaje):-
    amigo(OtroPersonaje,Personaje).

caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(UnPersonaje,OtroPersonaje):-
    personaje(UnPersonaje,_),
    personaje(OtroPersonaje,_),
    relativos(UnPersonaje,OtroPersonaje).