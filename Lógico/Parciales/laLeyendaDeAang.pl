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
esPersonaje(bumi).
esPersonaje(suki).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).
controla(bumi,tierra).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(suki, nacionDelFuego(prision, 200)).

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not(controla(Personaje,_)).

/*esMaestroPrincipiante(Personaje):-
    controla(Personaje,_),
    forall(controla(Personaje,Elemento),esElementoBasico(Elemento)).*/

esMaestroPrincipiante(Personaje):-
    controla(Personaje,Elemento),
    not(elementoAvanzadoDe(_,Elemento)).

esMaestroAvanzado(Personaje):-
    esElAvatar(Personaje).

esMaestroAvanzado(Personaje):-
    controla(Personaje,Elemento),
    elementoAvanzadoDe(_,Elemento).

sigueA(aang,zuko).
sigueA(Personaje,OtroPersonaje):-
    visito(Personaje, _),
    visito(OtroPersonaje, _),
    Personaje\=OtroPersonaje,
    forall(visito(Personaje,Lugar),visito(OtroPersonaje,Lugar)).

esDignoDeConocer(Lugar):-
    visito(_,Lugar),
    esDigno(Lugar).

esDigno(temploAire(_)).
esDigno(tribuAgua(norte)).
esDigno(reinoTierra(_,Estructura)):-
    not(member(muro, Estructura)).
    
esPopular(Lugar):-
    visito(_,Lugar),
    findall(Personaje,visito(Personaje,Lugar),Visitas),
    length(Visitas,CantidadDeVisitas),
    CantidadDeVisitas>4.

