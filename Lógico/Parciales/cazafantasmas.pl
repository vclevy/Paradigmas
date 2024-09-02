herramientasRequeridas(ordenarCuarto, [reemplazable(aspiradora(100),escoba), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%Punto 1

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(winston,varitaDeNeutrones).

%Punto 2

satisfaceNecesidad(Personaje,Herramienta):-
    tieneHerramientaIndicada(Personaje,Herramienta).

tieneHerramientaIndicada(Personaje,Herramienta):-
    tiene(Personaje,Herramienta).
tieneHerramientaIndicada(Personaje,aspiradora(PotenciaNecesaria)):-
    tiene(Personaje,aspiradora(Potencia)),
    Potencia>=PotenciaNecesaria.
tieneHerramientaIndicada(Personaje,reemplazable(Herramienta1,_)):-
    tiene(Personaje,Herramienta1).
tieneHerramientaIndicada(Personaje,reemplazable(_,Herramienta2)):-
    tiene(Personaje,Herramienta2).

%Punto 3

puedeRealizarTarea(Persona,Tarea):-
    herramientasRequeridas(Tarea,_),
    tiene(Persona,varitaDeNeutrones).
puedeRealizarTarea(Persona,Tarea):-
    herramientasRequeridas(Tarea,HerramientasRequeridas), tiene(Persona,_),
    forall(member(Herramienta,HerramientasRequeridas),tieneHerramientaIndicada(Persona,Herramienta)).

%Punto 4

% tareaPedida(Cliente,Tarea,Superficie).
% precio(Tarea,PrecioXm2).
precio(limpiarBanio, 10).
tareaPedida(john, limpiarBanio, 80).
pedido(john,[limpiarBanio]).

precioPorTarea(Cliente,Tarea,PrecioPedido):-
    tareaPedida(Cliente,Tarea,Superficie),
    precio(Tarea,Precio), PrecioPedido is Precio*Superficie.

cobroTotal(Cliente,PrecioTotal):- %Supongo que cada cliente hace unicamente 1 pedido
    pedido(Cliente,Pedido),
    findall(Precio,(member(Tarea,Pedido),precioPorTarea(Cliente,Tarea,Precio)),ListaDePrecios),
    sumlist(ListaDePrecios,PrecioTotal).

%Punto 5

estaDispuesto(ray,Pedido):-
    pedido(_,Pedido),
    not(member(limpiarTecho,Pedido)).
estaDispuesto(winston,Pedido):-
    pedido(Cliente,Pedido),
    cobroTotal(Cliente,Precio), Precio>500.
estaDispuesto(egon,Pedido):-
    pedido(_,Pedido),
    not((member(Tarea,Pedido),tareaCompleja(Tarea))).
estaDispuesto(peter,Pedido):-
    pedido(_,Pedido).

tareaCompleja(limpiarTecho).
tareaCompleja(Tarea):-
    herramientasRequeridas(Tarea,Herramientas), 
    length(Herramientas,2).

%Punto 6

