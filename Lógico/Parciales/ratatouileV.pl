rata(remy, gusteaus). 
rata(emile, bar). 
rata(django, pizzeria). 

cocina(linguini, ratatouille, 3). 
cocina(linguini, sopa, 5). 
cocina(colette, salmonAsado, 9). 
cocina(horst, ensaladaRusa, 8).

trabajaEn(gusteaus, linguini). 
trabajaEn(gusteaus, colette). 
trabajaEn(gusteaus, skinner). 
trabajaEn(gusteaus, horst). 
trabajaEn(cafeDes2Moulins, amelie).

inspeccionSatisfactoria(Restoran):-
    trabajaEn(Restoran,_),
    not(rata(_,Restoran)).

chef(Persona,Restoran):-
    cocina(Persona,_,_),
    trabajaEn(Restoran,Persona).

chefcito(Rata):-
    rata(Rata,Hogar),
    trabajaEn(Hogar,linguini).

cocinaBien(Persona,Plato):-
    cocina(Persona,Plato,Experiencia),
    Experiencia>7.

cocinaBien(remy,_).

encargadoDe(Plato,Restoran,Persona):-
    trabajaEn(Restoran, Persona),
    cocina(Persona,Plato,Experiencia),
    forall((cocina(Chef,Plato,Nivel),trabajaEn(Chef,Restoran)),Nivel<Experiencia).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato):-
    plato(Plato,Tipo),
    calorias(Tipo,CaloriasDePlato),
    CaloriasDePlato<75.

calorias(entrada(Ingredientes),CaloriasDePlato):-
    length(Ingredientes,CantidadDeIngredientes),
    CaloriasDePlato is CantidadDeIngredientes*15.

calorias(principal(Guarnicion,Tiempo),CaloriasDePlato):-
    caloriasDeCoccion(Tiempo,Coccion),
    caloriasDeGuarnicion(Guarnicion,Aporte),
    CaloriasDePlato is Coccion+Aporte.

calorias(postre(CaloriasDePlato),CaloriasDePlato).

caloriasDeCoccion(Tiempo,Coccion):-
    Coccion is Tiempo*5.

caloriasDeGuarnicion(papasFritas,50).
caloriasDeGuarnicion(pure,20).
caloriasDeGuarnicion(ensalada,0).

/*saludable(Plato):-
    plato(Plato,_),
    grupo(Plato). */

criticaPositiva(Restoran,Critico):-
    trabajaEn(Restoran,_),
    inspeccionSatisfactoria(Restoran),
    reseniaPositiva(Critico,Restoran).

reseniaPositiva(antonEgo,Restoran):-
   especialistaEn(ratatouille,Restoran).

reseniaPositiva(christophe,Restoran):-
    findall(Chef,trabajaEn(Restoran,Chef),ListaDeChefs),
    length(ListaDeChefs,CantidadDeChefs),
    CantidadDeChefs>3.

reseniaPositiva(cormillot,Restoran):-
    forall(platosDeUnRestoran(Restoran,Plato), saludable(Plato)),
    forall(entradasDeRestoran(Restoran,Plato),tieneZanahoria(Plato)).

especialistaEn(Plato,Restoran):-
    forall(chef(Persona,Restoran),cocinaBien(Persona,Plato)).

platosDeUnRestoran(Restoran,Plato):-
    trabajaEn(Restoran,Persona),
    cocina(Persona,Plato,_).

entradasDeRestoran(Restoran,Plato):-
    platosDeUnRestoran(Restoran,Plato),
    plato(Plato,entrada(_)).

tieneZanahoria(Plato):-
    plato(Plato,entrada(Ingredientes)),
    member(zanahoria,Ingredientes).




   




