
% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'qué', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'después', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','qué', 'onda', 'el','parcial', '?'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'después').
abreviatura('q', 'que').
abreviatura('q', 'qué').
abreviatura('bn', 'bien').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).

% Punto 1

participante(nico). participante(lucas). participante(maiu). participante(mama).

recibioMensaje(Mensaje,Receptor):-
    mensaje(Mensaje,Receptores),
    member(Receptor,Receptores), participante(Receptor).
recibioMensaje(Mensaje,Receptor):-
    participante(Receptor),
    mensaje(Mensaje,Receptor).

%Punto 2

demasiadoFormal(Mensaje):-
    masDeTantasPalabras(20,Mensaje),
    comienzaCon('¿',Mensaje),
    noTieneAbreviaturas(Mensaje).

masDeTantasPalabras(Cantidad,Mensaje):-
    length(Mensaje, Palabras), Palabras>Cantidad.

comienzaCon(Caracter,[Primera|_]):-
    Primera = Caracter.

noTieneAbreviaturas([]).
noTieneAbreviaturas([Palabra|Resto]):-
    not(abreviatura(Palabra,_)),
    noTieneAbreviaturas(Resto).
    
%Punto 3 me da paja

%Punto 4 

