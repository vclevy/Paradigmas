%canta(nombreCancion, cancion)
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

esNovedoso(Cantante) :- 
    sabeAlMenosDosCanciones(Cantante),
    tiempoTotalCanciones(Cantante, Tiempo),
    Tiempo < 15.
    
sabeAlMenosDosCanciones(Cantante) :-
    canta(Cantante, UnaCancion),
    canta(Cantante, OtraCancion),
    UnaCancion \= OtraCancion.
    
tiempoTotalCanciones(Cantante, TiempoTotal) :-
    findall(TiempoCancion, tiempoDeCancion(Cantante, TiempoCancion), Tiempos), sumlist(Tiempos,TiempoTotal).

tiempoDeCancion(Cantante,TiempoCancion):-  
    canta(Cantante,Cancion),
    tiempo(Cancion,TiempoCancion).
  
tiempo(cancion(_, Tiempo), Tiempo).
  
esAcelerado(Cantante):-
    forall(tiempoDeCancion(Cantante,Tiempo), Tiempo =< 4).

%concierto(nombre,pais,fama,tipo)

concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
concierto(magicalMirai, japon, 3000, gigante(3,10)).
concierto(vocalektVisions, eeuu, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

puedeParticiparEn(_,hatsuneMiku).
puedeParticiparEn(Concierto,Cantante):-
    canta(Cantante,_),
    concierto(Cantante,_,_,Requisitos),
    cumpleRequisitos(Cantante, Requisitos).

cumpleRequisitos(Cantante, gigante(CantidadDeCanciones,TiempoMinimo)):-
    cantidadCanciones(Cantante, Cantidad),
	Cantidad >= CantCanciones,
	tiempoTotalCanciones(Cantante, Total),
	Total > TiempoMinimo.


cantidadCanciones(Cantante, Cantidad) :- 
    findall(Cancion, canta(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad).

cumpleRequisitos(Cantante, mediano(TiempoMaximo)):-
	tiempoTotalCanciones(Cantante, Total),
	Total < TiempoMaximo.

cumpleRequisitos(Cantante, pequenio(TiempoMinimo)):-
    canta(Cantante, Cancion),
    tiempo(Cancion,Tiempo),
    Tiempo>TiempoMinimo.


    masFamoso(Cantante) :-
        nivelFamoso(Cantante, NivelMasFamoso),
        forall(nivelFamoso(_, Nivel), NivelMasFamoso >= Nivel).
    
    nivelFamoso(Cantante, Nivel):- 
    famaTotal(Cantante, FamaTotal), 	
    cantidadCanciones(Cantante, Cantidad), 
    Nivel is FamaTotal * Cantidad.
    
    famaTotal(Cantante, FamaTotal):- 
    canta(Cantante,_),
    findall(Fama, famaConcierto(Cantante, Fama), CantidadesFama), 	
    sumlist(CantidadesFama, FamaTotal).
    
    famaConcierto(Cantante, Fama):-
    puedeParticipar(Cantante,Concierto),
    fama(Concierto, Fama).
    
    fama(Concierto,Fama):- 
    concierto(Concierto,_,Fama,_).
    
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).



        
        

