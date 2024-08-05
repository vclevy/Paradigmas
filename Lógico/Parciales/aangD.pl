% esPersonaje/1 nos permite saber qué personajes tendrá el juego

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
esPersonaje(suki).
esPersonaje(bumi).

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
visito(bumi, reinoTierra(baSingSe,[muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(suki, nacionDelFuego(prisionMaximaSeguridad, 200)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento),controla(Personaje,Elemento)).

controlaAlgunBasico(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Basico), esElementoBasico(Basico).

controlaAlgunAvanzado(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Avanzado), elementoAvanzadoDe(_,Avanzado).

noEsMaestro(Personaje):-
    esPersonaje(Personaje),
    not((controlaAlgunBasico(Personaje),controlaAlgunAvanzado(Personaje))).

maestroPrincipiante(Personaje):-
    controlaAlgunBasico(Personaje),
    not(controlaAlgunAvanzado(Personaje)).

maestroAvanzado(Personaje):-
    esElAvatar(Personaje).
maestroAvanzado(Personaje):-
    controlaAlgunAvanzado(Personaje).

sigueA(aang,zuko).
sigueA(Personaje,Seguidor):-
    esPersonaje(Personaje),esPersonaje(Seguidor),
    lugaresVisitadosPor(Personaje,LugaresPersonaje), lugaresVisitadosPor(Seguidor,LugaresSeguidor),
    intersection(LugaresPersonaje,LugaresSeguidor,Interseccion), Interseccion=LugaresPersonaje, 
    Personaje\=Seguidor.
    
    
lugaresPorZona(Personaje,Lugar):-
    visito(Personaje,reinoTierra(Lugar,_)).
lugaresPorZona(Personaje,Lugar):-
    visito(Personaje,nacionDelFuego(Lugar,_)).
lugaresPorZona(Personaje,Lugar):-
    visito(Personaje,tribuAgua(Direccion)),
    atom_concat(Direccion, ' tribuAgua', Lugar).
lugaresPorZona(Personaje,Lugar):-
    visito(Personaje,temploAire(Direccion)),
    atom_concat(Direccion, ' temploAire', Lugar).

lugaresVisitadosPor(Personaje,Lugares):-
    findall(Lugar,lugaresPorZona(Personaje,Lugar),Lugares).

esDignoDeConocer(Lugar):-
    visito(_,temploAire(Lugar)).
esDignoDeConocer(temploAire(norte)).
esDignoDeConocer(Lugar):-
    visito(_,reinoTierra(Lugar,Elementos)),
    not(member(muro,Elementos)).

esPopular(Lugar):-
    lugaresPorZona(_,Lugar),
    findall(Personaje,lugaresPorZona(Personaje,Lugar),Visitas),
    length(Visitas, Total),
    Total>4.