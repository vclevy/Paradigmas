%Base de conocimientos
trabaja(juan_perez, ingeniero_software, 40).
trabaja(maria_lopez, asistente_administrativo, 30).
trabaja(roberto_fernandez, contador, 45).
trabaja(laura_martinez, disenadora_grafica, 35).

estudia(juan_perez, ingenieria_informatica, universidad_nacional).
estudia(maria_lopez, administracion_de_empresas, universidad_nacional).
estudia(carlos_sanchez, medicina, universidad_estatal).
estudia(ana_garcia, derecho, universidad_autonoma).

%trabaja(Nombre,Trabajo,CantHoras).
%estudia(Nombre,Carrera,Universidad).

universidadObrera(Universidad):-
    estudia(_,_,Universidad),
    forall(estudia(Nombre,_,Universidad),trabaja(Nombre,_,_)).
    
carreraExigente(Carrera):-
    estudia(_,Carrera,_),
    forall(estudia(Nombre,Carrera,_), not(trabaja(Nombre,_,_))).

carreraExigente(Carrera):-
    estudia(_,Carrera,_),
    forall(estudia(Nombre,Carrera,_), not(estudia(Nombre,OtraCarrera,_))),
    OtraCarrera\=Carrera.

universidadMasTrabajadora(Universidad) :- %anda mal, me dice el nombre de todas las universidades
    estudia(_,_,Universidad),
    porcentajeTrabajadores(Universidad, PorcentajeMax),
    forall(
        (porcentajeTrabajadores(OtraUniversidad, OtroPorcentaje), Universidad \= OtraUniversidad),
        PorcentajeMax > OtroPorcentaje).

porcentajeTrabajadores(Universidad, Porcentaje) :-
    totalEstudiantes(Universidad, Total),
    totalTrabajadores(Universidad, Trabajadores),
        Porcentaje is (Trabajadores / Total) * 100. %supongo que el total nunca es 0

totalEstudiantes(Universidad, Total) :-
    findall(Nombre, estudia(Nombre, _, Universidad), Estudiantes),
    length(Estudiantes, Total).
        
totalTrabajadores(Universidad, Trabajadores) :-
    findall(Nombre, (estudia(Nombre, _, Universidad), trabaja(Nombre, _, _)), TrabajadoresList),
    length(TrabajadoresList, Trabajadores).

%vinculado(Carrera,Trabajo).

vinculado(ingenieria_informatica,ingeniero_software).
vinculado(administracion_de_empresas,asistente_administrativo).

trabajaEnAlgoVinculado(Nombre):-
    estudia(Nombre,Carrera,_),
    trabaja(Nombre,Trabajo,_),
    vinculado(Carrera,Trabajo).

demandada(Carrera):-
    estudia(_,Carrera,_),
    forall(estudia(Nombre,Carrera,_),trabajaEnAlgoVinculado(Nombre)).






