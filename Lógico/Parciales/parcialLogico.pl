% receta(Plato, Duración, Ingredientes)
receta(empanadaDeCarneFrita, 20, [harina, carne, cebolla, picante, aceite]).
receta(empanadaDeCarneAlHorno, 20, [harina, carne, cebolla, picante]).
receta(lomoALaWellington, 125, [lomo, hojaldre, huevo, mostaza]).
receta(pastaTrufada, 40, [spaghetti, crema, trufa]).
receta(souffleDeQueso, 35, [harina, manteca, leche, queso]).
receta(tiramisu, 30, [vainillas, cafe, mascarpone]).
receta(rabas, 20, [calamar, harina, sal]).
receta(parrilladaDelMar, 40, [salmon, langostinos, mejillones]).
receta(sushi, 30, [arroz, salmon, sesamo, algaNori]).
receta(hamburguesa, 15, [carne, pan, cheddar, huevo, panceta, trufa]).
receta(padThai, 40, [fideos, langostinos, vegetales]).

% elabora(Chef, Plato)
elabora(guille, empanadaDeCarneFrita).
elabora(guille, empanadaDeCarneAlHorno).
elabora(vale, rabas).
elabora(vale, tiramisu).
elabora(vale, parrilladaDelMar).
elabora(ale, hamburguesa).
elabora(lu, sushi).
elabora(mar, padThai).

% cocinaEn(Restaurante, Chef)
cocinaEn(pinpun, guille).
cocinaEn(laPececita, vale).
cocinaEn(laParolacha, vale).
cocinaEn(sushiRock, lu).
cocinaEn(olakease, lu).
cocinaEn(guendis, ale).
cocinaEn(cantin, mar).

% tieneEstilo(Restaurante, Estilo)
tieneEstilo(pinpun, bodegon(parqueChas, 6000)).
tieneEstilo(laPececita, bodegon(palermo, 20000)).
tieneEstilo(laParolacha, italiano(15)).
tieneEstilo(sushiRock, oriental(japon)).
tieneEstilo(olakease, oriental(japon)).
tieneEstilo(cantin, oriental(tailandia)).
tieneEstilo(cajaTaco, mexicano([habanero, rocoto])).
tieneEstilo(guendis, comidaRapida(5)).

% italiano(CantidadDePastas)
% oriental(País)
% bodegon(Barrio, PrecioPromedio)
% mexicano(VariedadDeAjies)
% comidaRapida(cantidadDeCombos)

esCrack(Chef):-
    cocinaEn(Restoran,Chef),
    cocinaEn(OtroRestoran,Chef),
    Restoran\=OtroRestoran.

esCrack(Chef):-
    elabora(Chef,padThai).

esOtaku(Chef):-
    cocinaEn(_,Chef),
    forall(cocinaEn(Restoran,Chef),esJapones(Restoran)).

esJapones(Restoran):-
    tieneEstilo(Restoran,oriental(japon)).

esTop(Plato):-
    elabora(_,Plato),
    forall(elabora(Chef,Plato),esCrack(Chef)).

esDificil(souffleDeQueso).
esDificil(Plato):-
    receta(Plato,_,Ingredientes),
    member(trufa,Ingredientes).
esDificil(Plato):-
    receta(Plato,Duracion,_),
    Duracion>120.

/*
esDificil(souffleDeQueso).
esDificil(Plato):-
    receta(Plato,Duracion,Ingredientes),
    esDificilDeRealizar(Plato,Duracion,Ingredientes).

esDificilDeRealizar(_,_,Ingredientes):-
    member(trufa,Ingredientes).

esDificilDeRealizar(_,Duracion,_):-
    Duracion>120. 
también se podría realizar de esta forma, pero esDificilDeRealizar toma los mismos parámetros que receta.*/

seMereceLaMichelin(Restoran):-
    cocinaEn(Restoran,Chef),
    esCrack(Chef),
    tieneEstilo(Restoran,Estilo),
    estiloMichelinero(Estilo).

estiloMichelinero(oriental(tailandia)).
estiloMichelinero(bodegon(palermo,_)).
estiloMichelinero(italiano(Pastas)):-
    Pastas>5.
estiloMichelinero(mexicano((Ajies))):-
    member(habanero,Ajies),
    member(rocoto,Ajies).

tieneMayorRepertorio(UnRestoran,OtroRestoran):-
    cocinaEn(UnRestoran,UnChef),
    cocinaEn(OtroRestoran,OtroChef),
    cantidadDePlatos(UnRestoran, UnChef, UnaCantidadDePlatos),
    cantidadDePlatos(OtroRestoran, OtroChef, OtraCantidadDePlatos),
    UnaCantidadDePlatos>OtraCantidadDePlatos.

cantidadDePlatos(UnRestoran,UnChef,Cantidad):-
    findall(Plato,platoDeRestoran(UnChef,UnRestoran,Plato),UnosPlatos),
    length(UnosPlatos,Cantidad).

platoDeRestoran(Chef,Restoran,Plato):-
    cocinaEn(Restoran, Chef),
    elabora(Chef,Plato).

calificacionGastronomica(Restoran,Calificacion):-
    cocinaEn(Restoran,Chef),
    cantidadDePlatos(Restoran,Chef, CantidadDePlatos),
    Calificacion is CantidadDePlatos*5.









