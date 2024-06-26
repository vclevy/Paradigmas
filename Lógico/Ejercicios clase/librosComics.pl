% BASE DE CONOCIMIENTOS

escribio(elsaBornemann, socorro).
escribio(neilGaiman, sandman).
escribio(alanMoore, watchmen).
escribio(brianAzarello, cienBalas).
escribio(warrenEllis, planetary).
escribio(frankMiller, elCaballeroOscuroRegresa).
escribio(frankMiller, batmanAnioUno).
escribio(neilGaiman, americanGods).
escribio(neilGaiman, buenosPresagios).
escribio(terryPratchett, buenosPresagios).
escribio(isaacAsimov, fundacion).
escribio(isaacAsimov, yoRobot).
escribio(isaacAsimov, elFinDeLaEternidad).
escribio(isaacAsimov, laBusquedaDeLosElementos).
escribio(joseHernandez, martinFierro).
escribio(stephenKing, it).
escribio(stephenKing, misery).
escribio(stephenKing, carrie).
escribio(stephenKing, elJuegoDeGerald).
escribio(julioCortazar, rayuela).
escribio(jorgeLuisBorges, ficciones).
escribio(jorgeLuisBorges, elAleph).
escribio(horacioQuiroga, cuentosDeLaSelva).
escribio(horacioQuiroga, cuentosDeLocuraAmorYMuerte).

% Si es cierto que alguien escribió determinada obra.
% Quién/es escribieron una obra.
% Qué obra/s escribió cierta persona.
% Si es cierto que cierta persona escribió alguna obra, sin importar cuál.
% Si es cierto que cierta obra existe.

% Queremos agregar la información de cuáles de las obras son cómics. 
%Por ejemplo, quiero preguntar si sandman es un cómic.

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

% Queremos saber si alguien es artista del noveno arte: 
% lo es cuando escribió algún cómic.

/* esArtistaDelNovenoArte(neilGaiman).
esArtistaDelNovenoArte(alanMoore). */

% r <= p ^ q
esArtistaDelNovenoArte(Artista):-
    esComic(Obra),
    escribio(Artista,Obra).

  % Variable: libre.
  % Variable: ligada o unificada.

/*
1. Queremos saber si determinada obra es un best-seller, es decir, si tiene más de 50.000 copias vendidas.
2. Queremos saber si es reincidente un/a autor/a, que es cuando escribió más de una obra.
3.  Queremos saber si conviene contratar a un/a artista, que es cuando es reincidente o escribió un bestseller.
4. Queremos saber si a gus le gusta una obra. A Gus le gusta todo lo que escribió Asimov y sandman.
5. Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su autor/a es Uruguay o Argentina.
6. Ver si es un libro: cuando fue escrito pero no es cómic
*/

% copiasVendidas(Obra,Cantidad)
copiasVendidas(socorro, 10000).
copiasVendidas(sandman, 20000).
copiasVendidas(watchmen, 30000).
copiasVendidas(cienBalas, 40000).
copiasVendidas(planetary, 50000).
copiasVendidas(elCaballeroOscuroRegresa, 60000).
copiasVendidas(batmanAnioUno, 70000).
copiasVendidas(americanGods, 80000).
copiasVendidas(buenosPresagios, 90000).
copiasVendidas(buenosPresagios, 10000).
copiasVendidas(fundacion, 20000).
copiasVendidas(yoRobot, 30000).
copiasVendidas(elFinDeLaEternidad, 30000).
copiasVendidas(laBusquedaDeLosElementos, 40000).
copiasVendidas(martinFierro, 50000).
copiasVendidas(it, 60000).
copiasVendidas(it, 70000).
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

esBestSeller(Obra) :-
    copiasVendidas(Obra, Cantidad),
    Cantidad > 50000.

esReincidente(Autore) :-
    escribio(Autore, UnaObra),
    escribio(Autore, OtraObra),
    UnaObra \= OtraObra.

convieneContratar(Artista) :-
    esReincidente(Artista).

convieneContratar(Artista) :-
    escribio(Artista, Obra),
    esBestSeller(Obra).

leGustaAGus(Obra) :-
    escribio(isaacAsimov, Obra).

leGustaAGus(sandman).

esLibro(Obra) :-
    esObra(Obra),
    not(esComic(Obra)).

esObra(Obra) :-
    escribio(_, Obra).

%Teniendo en cuenta la base de conocimientos que vimos en clase, traer resuelto para la clase que viene el siguiente pedido: Queremos saber si una obra es rioplatense, que es cuando la nacionalidad de su artista es platense (Uruguay o Argentina).

nacionalidad(elsaBornemann, argentina).
nacionalidad(jorgeLuisBorges, argentina).
nacionalidad(joseHernandez, argentina).
nacionalidad(julioCortazar, argentina).
nacionalidad(horacioQuiroga, uruguay).

esObraRioPlatense2(Obra):-
  escribio(Artista, Obra),
  esArtistaRioPlatense(Artista).

esArtistaRioPlatense(Artista):-
  nacionalidad(Artista, argentina).

esArtistaRioPlatense(Artista):-
  nacionalidad(Artista, uruguay).

