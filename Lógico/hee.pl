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

esComic(sandman).
esComic(cienBalas).
esComic(watchmen).
esComic(planetary).
esComic(elCaballeroOscuroRegresa).
esComic(batmanAnioUno).

esArtistaDelNovenoArte(Artista):-
    escribio(Artista,Obra),
    esComic(Obra).

copiasVendidas(socorro, 100000).
copiasVendidas(sandman, 200000).
copiasVendidas(watchmen, 300000).
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
copiasVendidas(misery, 70000).
copiasVendidas(carrie, 80000).
copiasVendidas(elJuegoDeGerald, 90000).
copiasVendidas(rayuela, 10000).
copiasVendidas(ficciones, 20000).
copiasVendidas(elAleph, 30000).
copiasVendidas(cuentosDeLaSelva, 40000).
copiasVendidas(cuentosDeLocuraAmorYMuerte, 50000).

esBestSeller(UnaObra) :-
  copiasVendidas(UnaObra, CantidadVendida),
  CantidadVendida > 50000.

esBestSeller(UnaObra) :-
  copiasVendidas(cuentosDeLaSelva, CantidadVendida),
  copiasVendidas(UnaObra, CantidadVendida).

esReincidente(Artista) :-
  escribio(Artista, UnaObra),
  escribio(Artista, OtraObra),
  UnaObra \= OtraObra.

convieneContratar(Artista) :-
  esReincidente(Artista).

convieneContratar(Artista) :-
  escribio(Artista, UnaObra),
  esBestSeller(UnaObra).

leGustaA(gus, sandman).

leGustaA(gus, UnaObra):-
	escribio(isaacAsimov, UnaObra).

esLibro(Obra) :-
  escribio(_,Obra),
  not(esComic(Obra)).

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

/*
esObraRioPlatense3(Obra):-
  escribio(Artista, Obra),
  nacionalidad(Artista, Nacionalidad),
  esNacionalidadRioPlatense(Nacionalidad).

esNacionalidadRioPlatense(argentina).
esNacionalidadRioPlatense(uruguay).
*/

%∀ x / P(x) -> Q(x)
%forall(antecedente, consecuente)

soloEscribioComics(Artista):-
  escribio(Artista, _), %Generador. Hace que mi predicado sea inversible
  forall(escribio(Artista, Obra), esComic(Obra)).

%functores de tipo de libro
%novela(Genero, CantidadDeCapitulos)
%libroDeCuentos(CantidadDeCuentos)
%cientifico(Disciplina)
%bestSeller(Precio, CantidadDePaginas)
%fantastica(ElementosMágicos)

%esDeTipo/2
esDeTipo(it, novela(terror, 11)).
esDeTipo(cuentosDeLaSelva, libroDeCuentos(10)).
esDeTipo(elUniversoEnUnaTabla, cientifico(quimica)).
esDeTipo(elUltimoTeoremaDeFermat, cientifico(matematica)).
esDeTipo(yoRobot, bestSeller(700,253)).
esDeTipo(sandman, fantastica([yelmo, bolsaDeArena, rubi])).

estaBueno(Libro):-
  esDeTipo(Libro, Tipo),
  esTipoCopado(Tipo).

esTipoCopado(novela(terror, _)).

esTipoCopado(novela(policial, Capitulos)):-
    Capitulos < 12.

esTipoCopado(libroDeCuentos(Cuentos)):-
  Cuentos>10.

esTipoCopado(cientifico(fisicaCuantica)).

esTipoCopado(bestSeller(Precio,Paginas)):-
  Precio/Paginas < 50.

esTipoCopado(fantastica(ElementosMagicos)):-
	member(rubi, ElementosMagicos).

cantidadDePaginas(Libro, Paginas):-
  esDeTipo(Libro, Tipo),
  paginasDeUnTipo(Tipo, Paginas).

paginasDeUnTipo(cientifico(_), 1000).

paginasDeUnTipo(bestSeller(_, Paginas), Paginas).

paginasDeUnTipo(novela(_,CantidadCapitulos), Paginas):-
  Paginas is CantidadCapitulos * 20.

paginasDeUnTipo(libroDeCuentos(CantidadDeCuentos), Paginas):-
  Paginas is CantidadDeCuentos * 5.

puntajeDeUnArtista(Puntaje, Artista):-
	cantidadDeBestSellers(Artista, Cantidad),
	Puntaje is Cantidad * 3.

% Necesitamos hacer un findall el cual toma 3 parámetros: el formato, la condición y la lista
cantidadDeBestSellers(Artista, Cantidad):-
  bestSellersDeUnArtista(Artista, BestSellers),
  length(BestSellers, Cantidad).

bestSellersDeUnArtista(Artista, BestSellers):-
  escribio(Artista, _),
  findall(Obra, escribioBestSeller(Artista, Obra), BestSellers).

escribioBestSeller(Artista, Obra):-
	escribio(Artista, Obra),
	esBestSeller(Obra).

promedioDeCopiasVendidas(Artista, Promedio):-
  escribio(Artista, _),
	findall(CopiasVendidas, copiasDeArtista(Artista, CopiasVendidas), CopiasDeLasObras),
	length(CopiasDeLasObras, CantidadDeObrasEscritas),
  sum_list(CopiasDeLasObras, SumaTotalDeVentas),
	Promedio is SumaTotalDeVentas / CantidadDeObrasEscritas.

copiasDeArtista(Artista, CopiasVendidas):-
	escribio(Artista, Obra),
	copiasVendidas(Obra, CopiasVendidas).