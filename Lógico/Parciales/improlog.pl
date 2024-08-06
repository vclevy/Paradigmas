integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(vientosDelEste, santi , bateria).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, saxo, 30).
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra,2).
nivelQueTiene(santi,voz,3).
nivelQueTiene(santi,bateria,4).
nivelQueTiene(lisa,saxo,4).
nivelQueTiene(lore,violin,4).
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
grupo(vientosDelEste,tipo(bigBand)).
grupo(sophieTrio,tipo(formacionParticular,[contrabajo,guitarra,violin])).
grupo(jazzmin,tipo(formacionParticular,[bateria,bajo,trompeta,piano,guitarra])).


% 1)
buenaBase(Grupo):-
    integrante(Grupo,Ritmico,InstRitmico), instrumento(InstRitmico,ritmico),
    integrante(Grupo,Armonico,InstArmonico), instrumento(InstArmonico,armonico),
    Armonico\=Ritmico.

% 2)
seDestaca(Persona,Grupo):- %Raro lo de vientos del este
    integrante(Grupo,Persona, Instrumento), nivelQueTiene(Persona,Instrumento,Nivel),
    NivelDestacado is Nivel+2,
    forall((integrante(Grupo,Otro,OtroInstrumento),nivelQueTiene(Otro,OtroInstrumento,OtrosNiveles), Otro\=Persona),
            OtrosNiveles<NivelDestacado).

% 4) 

hayCupo(Instrumento,Grupo):-
    grupo(Grupo,tipo(bigBand)),
    instrumento(Instrumento,melodico(viento)).
hayCupo(Instrumento,Grupo):-
    instrumento(Instrumento,_),
    instrumentosDelGrupo(Grupo,Instrumentos),
    not(member(Instrumento,Instrumentos)),
    sirve(Instrumento,Grupo).

instrumentosDelGrupo(Grupo,Instrumentos):-
    findall(Instrumento,integrante(Grupo,_,Instrumento), Instrumentos).

sirve(Instrumento,Grupo):-
    grupo(Grupo,tipo(formacionParticular,LosQueSirven)),
    member(Instrumento,LosQueSirven).

sirve(Instrumento,Grupo):-
    grupo(Grupo,tipo(bigBand)),
    member(Instrumento,[bateria,bajo,piano]).


% 5)

nivelMinimo(Grupo,1):-
    grupo(Grupo,tipo(bigBand)).
nivelMinimo(Grupo,Nivel):-
    grupo(Grupo,tipo(formacionParticular,Instrumentos)),
    length(Instrumentos, CantidadInstrumentos), Nivel is 7-CantidadInstrumentos.

puedeIncorporarse(Persona,Instrumento,Grupo):-
    integrante(_,Persona,_),
    not(integrante(Grupo,Persona,_)),
    hayCupo(Instrumento,Grupo),
    nivelMinimo(Grupo,Nivel),
    nivelQueTiene(Persona,Instrumento,NivelPersona),
    NivelPersona>= Nivel.
    
