esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes
esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado
elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios,enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje,_)).

esMaestroPrincipiante(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Elemento),
    not(elementoAvanzadoDe(_,Elemento)).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).

sigueA(zuko,aang).
sigueA(Seguidor,Seguido):-
    visito(Seguido,_),
    visito(Seguidor,_),
    Seguido \= Seguidor,
    forall(visito(Seguido,Lugar),visito(Seguidor,Lugar)).

esDignoDeConocer(Lugar):-
    visito(_,Lugar),
    esDigno(Lugar).

esDigno(temploAire(_)).
esDigno(tribuAgua(norte)).
esLugarDigno(reinoTierra(_,Estructura)):-
    not(member(muro,Estructura)).

lugar(reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo,sectorMedio])).
lugar(reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
lugar(nacionDelFuego(palacioReal, 1000)).
lugar(tribuAgua(norte)).
lugar(tribuAgua(sur)).
lugar(tribuAgua(este)).
lugar(tribuAgua(oeste)).
lugar(temploAire(norte)).
lugar(temploAire(sur)).
lugar(temploAire(este)).
lugar(temploAire(oeste)).


esPopular(Lugar):-
    personasQueVisitaron(Lugar,Personajes),
    length(Personajes, Tamanio),
    Tamanio > 4.
    
        
personasQueVisitaron(Lugar,Personajes):-
    lugar(Lugar),
    findall(Personaje,visito(Personaje,Lugar),Personajes).

esPersonaje(bumi).
