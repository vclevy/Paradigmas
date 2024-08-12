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

hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

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

aspiranteMagico(Persona):-
    persona(Persona),
    esDescendienteDeMagio(Persona).

aspiranteMagico(Persona):-
    persona(Persona),
    fueSalvadoPorMagio(Persona).

esDescendienteDeMagio(Persona):-
    hijo(Persona,Padre),
    esMago(Padre).

esMago(Persona):- persona(alMando(Persona,_)).
esMago(Persona):- persona(novato(Persona)).
esMago(Persona):- persona(elElegido(Persona)).

fueSalvadoPorMagio(Persona):-
    salvo(OtraPersona,Persona),
    esMago(OtraPersona).

puedeDarOrdenes(UnaPersona,OtraPersona):-
    persona(alMando(UnaPersona,_)),
    persona(novato(OtraPersona)).
 
puedeDarOrdenes(UnaPersona,OtraPersona):-
    persona(alMando(UnaPersona,Rango)),
    persona(alMando(OtraPersona,OtroRango)),
    Rango>OtroRango.

puedeDarOrdenes(UnaPersona,OtraPersona):-
    persona(elElegido(UnaPersona)),
    persona(OtraPersona).

sienteEnvidia(Persona,Personas):-
    findall(Envidiado,envidia(Persona,Envidiado),Envidiados),
    list_to_set(Envidiados, Personas).
    
envidia(Persona,Envidiado):-
    esMago(Envidiado).

envidia(Persona,Envidiado):-
    not(aspiranteMagico(Persona)),
    aspiranteMagico(Envidiado).

envidia(Persona,Envidiado):-
    persona(novato(Persona)),
    persona(alMando(Envidiado,_)).   

/*soloLoGoza(Persona,Beneficio):-
    gozaBeneficio(Persona,Beneficio),
    not(gozaBeneficio(OtraPersona,Beneficio)),
    OtraPersona\=Persona.*/

soloLoGoza(Persona,Beneficio):-
    gozaBeneficio(Persona,Beneficio),
    findall(Maggio,(gozaBeneficio(Maggio,Beneficio),Persona\=Maggio),Gozadores),
    length(Gozadores, 1).
    