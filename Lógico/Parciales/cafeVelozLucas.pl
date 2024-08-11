% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).

jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). 
maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina).

% Punto 1
/*tomo(pasarella, Sustancia):-
    not(tomo(maradona, Sustancia)).
tomo(pedemonti, Sustancia):-
    tomo(chamot, Sustancia),
    tomo(maradona, Sustancia).
*/
% Punto 2
puedeSerSuspendido(Jugador):-
    tomoAlgoProhibido(Jugador).
puedeSerSuspendido(Jugador):-
    tomoCantidadExcesivaDe(_,Jugador).

tomoAlgoProhibido(Jugador):-
    tomo(Jugador, LoQueTomo),
    noSePuedeTomar(LoQueTomo).

noSePuedeTomar(sustancia(Sustancia)):-
    sustanciaProhibida(Sustancia).
noSePuedeTomar(compuesto(NombreCompuesto)):-
    composicion(NombreCompuesto, SustanciasQueLoForman),
    member(UnaSustancia, SustanciasQueLoForman),
    sustanciaProhibida(UnaSustancia).

tomoCantidadExcesivaDe(Producto, Jugador):-
    tomo(Jugador, producto(Producto, CantidadQueTomo)),
    maximo(Producto, MaximoPermitido),
    CantidadQueTomo > MaximoPermitido.

% Punto 3
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

malaInfluencia(UnJugador, OtroJugador):-
    puedeSerSuspendido(UnJugador),
    puedeSerSuspendido(OtroJugador),
    seConocen(UnJugador, OtroJugador).

seConocen(UnJugador, OtraPersona):-
    amigo(UnJugador,OtraPersona).
seConocen(UnJugador, OtraPersona):-
    amigo(UnJugador, Alguien),
    seConocen(Alguien, OtraPersona).

% Punto 4
% atiende(Medico, Jugador)
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
    atiende(Medico, Jugador),
    puedeSerSuspendido(Jugador).

% Punto 5                    MEDIO RARI
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

%cuantaFalopaTiene(Jugador, NivelAlteracion):-
    %findall(AlteracionDeUnProducto, alteracionQueGenera(Jugador, %AlteracionDeUnProducto), Alteraciones),
 %   sumlist(Alteraciones, NivelAlteracion).

%alteracionQueGenera(Jugador, AlteracionProducto):-
%    tomo(Jugador)
    
% Punto 6
medicoConProblemas(Medico):-
    atiende(Medico,_),
    findall(Paciente, (atiende(Medico, Paciente),pacienteConflictivo(Paciente)), PacientesConflictivos),
    length(PacientesConflictivos, CantidadPacientesConflictivos),
    CantidadPacientesConflictivos > 3.

pacienteConflictivo(Paciente):-
    puedeSerSuspendido(Paciente).
pacienteConflictivo(Paciente):-
    seConocen(Paciente, maradona).

% Punto 7
programaTVFantinesco(Jugadores):-
    findall(Jugador, puedeSerSuspendido(Jugador), JugadoresProblematicos),
    list_to_set(JugadoresProblematicos, Jugadores).
    