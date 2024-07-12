% dodain atiende lunes, miércoles y viernes de 9 a 15.
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

% lucas atiende los martes de 10 a 20
atiende(lucas, martes, 10, 20).

% juanC atiende los sábados y domingos de 18 a 22.
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).

% juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

% leoC atiende los lunes y los miércoles de 14 a 18.
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

% martu atiende los miércoles de 23 a 24.
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(dodain, Dia, HorarioInicio, HorarioFinal).
atiende(vale, Dia, HorarioInicio, HorarioFinal):-atiende(juanC, Dia, HorarioInicio, HorarioFinal).

quienAtiende(Persona, Dia, HorarioPuntual):-
    atiende(Persona, Dia, HorarioInicio, HorarioFinal),
    between(HorarioInicio, HorarioFinal, HorarioPuntual).
  
foreverAlone(Persona, Dia, HorarioDeterminado):-
    quienAtiende(Persona,Dia,HorarioDeterminado),
    not((quienAtiende(OtraPersona, Dia, HorarioPuntual), Persona \= OtraPersona)).
