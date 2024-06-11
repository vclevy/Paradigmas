% Hechos: características de algunos animales
tiene(aardvark, piel_gruesa).
tiene(aardvark, come_hormigas).
tiene(cocodrilo, piel_gruesa).
tiene(cocodrilo, vive_en_agua).
tiene(cocodrilo, come_carnes).

% Reglas: definición de relaciones
mamifero(Animal) :- tiene(Animal, piel_gruesa), \+ tiene(Animal, vive_en_agua).
come_carnes(Animal) :- tiene(Animal, come_carnes).
come_hormigas(Animal) :- tiene(Animal, come_hormigas).

% Consultas comunes
/*
?- mamifero(aardvark).
true.

?- mamifero(cocodrilo).
false.

?- come_carnes(cocodrilo).
true.

?- come_hormigas(aardvark).
true.
*/
