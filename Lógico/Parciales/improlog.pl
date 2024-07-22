integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).

integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(vientosDelEste, santi , bateria)
integrante(jazzmin, santi, bateria).
nivelQueTiene(sophie, violin,5).
nivelQueTiene(santi, guitarra,2).
nivelQueTiene(santi,voz,3).
nivelQueTiene(santi,bateria,4).
nivelQueTiene(lisa,saxo,4).
nivelQueTiene(lore,violion,4).
nivelQueTiene(luis, trompeta, 1). 
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

buenaBase(Grupo):-
    integrante(Grupo,Persona1,Instrumento1),
    instrumento(Instrumento1,ritmico),
    integrante(Grupo,Persona2,Instrumento2),
    instrumento(Instrumento2,armonico),
    Persona1 \= Persona2.

mismoGrupo(Persona1,Persona2,Grupo):-
    integrante(Grupo,Persona1,_),
    integrante(Grupo,Persona2,_).

dosPuntosMas(Persona1,Persona2,Grupo):-
    mismoGrupo(Persona1,Persona2,Grupo)
    nivelQueTiene(Persona1,_,Nivel1),
    nivelQueTiene(Persona2,_,Nivel2),
    Total is Nivel1 +2,
    Total >= Nivel2.

seDestaca(Persona,Grupo):-
    forall(mismoGrupo(Persona,OtraPersona,Grupo),dosPuntosMas(Persona,OtraPersona,Grupo)),
    Persona \= OtraPersona.
/*
seDestaca(Persona):-
    nivelDe(Persona, _, NivelDestacado),
    NivelAComparar is NivelDestacado-2,
    
    forall(integrante(Grupo,OtraPersona,Instrumento),NivelDestacado>)
    */