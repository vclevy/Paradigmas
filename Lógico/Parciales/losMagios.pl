persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).
persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

%hechos
hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

% salvo(Persona,Magio)
salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica), 
% dispersion(descripcion), economico(descripcion, monto).
gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).

%Punto 1
aspiranteMagio(Persona):-
    hijo(Persona, Nombre),
    esMagio(Nombre).
aspiranteMagio(Persona):-
    salvo(Persona, Nombre),
    esMagio(Nombre).

% esMagio(alMando(Nombre,Nivel)):-
%     persona(alMando(Nombre,Nivel)).
% esMagio(novato(Nombre)):-
%     persona(novato(Nombre)).
% esMagio(elElegido(Nombre)):-
%     persona(elElegido(Nombre)).

esMagio(Persona):-
    persona(TipoDeMagio),
    esAlgunTipoDeMagio(TipoDeMagio, Persona).

esAlgunTipoDeMagio(alMando(Persona,_), Persona).
esAlgunTipoDeMagio(novato(Persona), Persona).
esAlgunTipoDeMagio(elElegido(Persona), Persona).

%Punto 2

puedeDarOrdenes(UnMagio,OtroMagio):-
    persona(elElegido(UnMagio)),
    esMagio(OtroMagio).
puedeDarOrdenes(UnMagioAlMando, UnMagioNovato):-
   persona(alMando(UnMagioAlMando,_)),
   persona(novato(UnMagioNovato)).
puedeDarOrdenes(UnMagio, OtroMagio):-
    persona(alMando(UnMagio,Nivel1)),
    persona(alMando(OtroMagio,Nivel2)), Nivel1>Nivel2.

% Punto 3

sienteEnvidia(Persona, PersonasQueEnvidia):-
    persona(Persona),
    findall(PersonaEnvidiada, envidiaA(Persona, PersonaEnvidiada), PersonasQueEnvidia).

envidiaA(Aspirante,Magio):-
    aspiranteMagio(Aspirante),
    esMagio(Magio).
envidiaA(NoAspirante,Aspirante):-
    not(aspiranteMagio(NoAspirante)),
    aspiranteMagio(Aspirante).
envidiaA(Novato, MagioAlMando):-
    persona(novato(Novato)),
    persona(alMando(MagioAlMando,_)).

%Punto 4
masEnvidioso(Persona):-
    cantidadDePersonasQueEnvidia(Persona, Cantidad),
    forall((cantidadDePersonasQueEnvidia(OtraPersona, OtraCantidad), Persona \= OtraPersona), OtraCantidad < Cantidad).

cantidadDePersonasQueEnvidia(Persona, Cantidad):-
    sienteEnvidia(Persona, PersonasQueEnvidia),
    length(PersonasQueEnvidia, Cantidad).



/* Punto 4
cantidadEnvidias(Persona, Cantidad) :-
    sienteEnvidia(Persona, PersonasQueEnvidia),
    length(PersonasQueEnvidia, Cantidad).

maximaCantidadEnvidias(MaximaCantidad) :-
    findall(Cantidad, (persona(Persona), cantidadEnvidias(Persona, Cantidad)), Cantidades),
    max_member(Cantidades, MaximaCantidad).

masEnvidioso(Persona) :-
    maximaCantidadEnvidias(MaximaCantidad),
    cantidadEnvidias(Persona, MaximaCantidad).*/

%Punto 5

soloLoGoza(Persona, Beneficio):-
    gozaBeneficio(Persona, Beneficio),
    not((gozaBeneficio(OtraPersona, Beneficio), OtraPersona \= Persona)).

% Punto 6

tipoDeBeneficioMasAprovechado(Tipo):-
   
cantidadAprovechadoPorTipo(Tipo, Cantidad):-
    findall(Tipo,(gozaBeneficio(_,Beneficio),tipoDeBeneficio(Beneficio,Tipo)),Gozadores),
    length(Gozadores,Cantidad).

tipoDeBeneficio(confort(_),confort).
tipoDeBeneficio(economico(_,_),economico).
tipoDeBeneficio(dispersion(_),dispersion).
    
    