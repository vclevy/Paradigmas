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

%1

esCrack(Chef):-
    cocinaEn(Lugar1,Chef),
    cocinaEn(Lugar2,Chef),
    Lugar1\=Lugar2,
    elabora(Chef,padThai).

esOtaku(Chef):-
    cocinaEn(Lugar,Chef),
    tieneEstilo(Lugar,oriental(japon)).

esTop(Plato):-
    receta(Plato,_,_),
    forall(elabora(Chef,Plato),esCrack(Chef)).

ingredienteDificil(trufa).
ingredienteDificil(souffleDeQueso).

esDificil(Plato):-
    receta(Plato,Duracion,_),
    Duracion>120.
esDificil(Plato):-
    receta(Plato,_,Ingredientes),
    ingredienteDificil(Dificil),
    member(Dificil,Ingredientes).

seMereceLaMichelin(Restaurante):-
    esCrack(Chef), cocinaEn(Restaurante,Chef),
    estiloMichelinero(Restaurante).

estiloMichelinero(Restaurante):-
    tieneEstilo(Restaurante,oriental(tailandia)).
estiloMichelinero(Restaurante):-
    tieneEstilo(Restaurante,bodegon(palermo,_)).
estiloMichelinero(Restaurante):-
    tieneEstilo(Restaurante,italiano(Pastas)), Pastas>5.
estiloMichelinero(Restaurante):-
    tieneEstilo(Restaurante,mexicano(Elementos)),
    member(habanero,Elementos), member(rocoto,Elementos).

platosQueElabora(Chef,Cantidad):-
    elabora(Chef,_),
    findall(Plato,elabora(Chef,Plato),Platos),
    length(Platos,Cantidad).
%Vamos a suponer que podria haber mas de 1 chef por restaurante
chefAmplio(Restaurante,Chef):-
    cocinaEn(Restaurante,Chef),
    platosQueElabora(Chef,MayorCantidad),
    forall((cocinaEn(Restaurante,OtroChef),platosQueElabora(OtroChef,CantidadMenor),OtroChef\=Chef),CantidadMenor=<MayorCantidad).

tieneMayorRepertorio(Restaurante1,Restaurante2):-
    chefAmplio(Restaurante1,Chef1),chefAmplio(Restaurante2,Chef2),
    platosQueElabora(Chef1,Cantidad1), platosQueElabora(Chef2,Cantidad2),
    Cantidad1>Cantidad2.

calificacion(Restaurante,Calificacion):-
    cocinaEn(Restaurante,Chef), platosQueElabora(Chef,Platos),
    Calificacion is 5*Platos.