%Base de conocimientos
atiende(dodain,lunes,horario(9,15)).
atiende(dodain,miercoles,horario(9,15)).
atiende(dodain,viernes,horario(9,15)).

atiende(lucas,martes,horario(10,20)).

atiende(juanC,sabado,horario(18,22)).
atiende(juanC,domingo,horario(18,22)).

atiende(juanFdS,jueves,horario(10,20)).
atiende(juanFdS,viernes,horario(12,20)).

atiende(leoC,lunes,horario(14,18)).
atiende(leoC,miercoles,horario(14,18)).

atiende(martu,miercoles,horario(23,24)).

%Punto 1
atiende(vale,DiaVale,HorarioVale):-
    atiende(dodain,DiaDodain,HorarioDodain),
    DiaVale = DiaDodain, HorarioVale = HorarioDodain.
atiende(vale,DiaVale,HorarioVale):-
    atiende(juanC,DiaJuanC,HorarioJuanC),
    DiaVale = DiaJuanC, HorarioVale = HorarioJuanC.

%no es necesario expresar que nadie hace el mismo horario que leoC porque prolog trabaja con 
%universo cerrado, todo lo que no se especifica, es falso.
% como maiu esta pensando si hacerlo o no, todavia no es un hecho por lo que prologo no deberia
% tomarlo como verdadero.

%Punto 2 - anda raro
estaEseDia(Persona,Dia):-
    atiende(Persona,Dia,_).

estaEseHorario(Persona,Hora):-
    atiende(Persona,_,horario(Inicio,Fin)),
    between(Inicio,Fin,Hora).
    
estaAtendiendo(Persona,Dia,Hora):-
    estaEseDia(Persona,Dia),
    estaEseHorario(Persona,Hora).

