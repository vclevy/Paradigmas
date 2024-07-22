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

inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante,_),
    not(rata(_,Restaurante)).

chef(Empleado,Restaurante):-
    trabajaEn(Restaurante,Empleado),
    cocina(Empleado,_,_).

chefcito(Rata):-
    trabajaEn(Restaurante,linguini),
    rata(Rata, Hogar), Hogar = Restaurante.

cocinaBien(remy,_).
cocinaBien(Chef,Plato):-
    cocina(Chef,Plato,Experiencia),
    Experiencia>7.

% encargadoDe(Plato,Lugar,Chef) es con recursividad y no se x ahora

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

calorias(papasFritas,50).
calorias(pure,20).
calorias(ensalada,0).

grupo(chocotorta). %no hice el punto de grupo

saludable(Plato):-
    plato(Plato,postre(Kcals)),
    Kcals<75.
saludable(Plato):-
    plato(Plato,entrada(Lista)),
    length(Lista, Ingredientes),
    Kcals is Ingredientes*15,
    Kcals<75.
saludable(Plato):-
    plato(Plato,principal(Guarnicion,Mins)),
    calorias(Guarnicion,CalsExtra),
    Kcals is 5*Mins + CalsExtra,
    Kcals<75.
  
crititcaPositiva(Critico,Restaurante):-
    inspeccionSatisfactoria(Restaurante),
    criterio(Critico,Restaurante).

cantidadDeChefs(Restaurante,Chefs):-
    findall(Empleado,chef(Empleado,Restaurante),LosChefs),
    length(LosChefs,Chefs).

esEspecialista(Restaurante,Plato):-
    forall(chef(Empleado,Restaurante),cocinaBien(Empleado,Plato)).

criterio(antonEgo,Restaurante):-
    esEspecialista(Restaurante,ratatouille).
criterio(christophe,Restaurante):-
    cantidadDeChefs(Restaurante,Chefs), Chefs>3.
criterio(cormillot,Restaurante):-
    chef(Empleado,Restaurante),
    forall(cocina(Empleado,Plato,_),(saludable(Plato),tieneIngrediente(zanahoria,Plato))).

tieneIngrediente(Ingrediente,Plato):-
    plato(Plato,entrada(Lista)),
    member(Ingrediente, Lista).
tieneIngrediente(Ingrediente,Plato):-
    plato(Plato,principal(Guarnicion,_)),
    Guarnicion=Ingrediente.
%asumo que la carrotcake no existe y ningun postre tiene zanahoria

    
