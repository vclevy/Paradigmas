% festival(NombreDelFestival, Bandas, Lugar).

festival(lollapalooza, [gunsAndRoses, theStrokes, ..., littoNebbia], hipodromoSanIsidro).

% lugar(nombre, capacidad, precioBase).
% Relaciona un lugar con su capacidad y el precio base que se cobran las entradas ahí.
lugar(hipodromoSanIsidro, 85000, 3000).

% banda(nombre, nacionalidad, popularidad).
% Relaciona una banda con su nacionalidad y su popularidad.
banda(gunsAndRoses, eeuu, 69420).

% entradaVendida(NombreDelFestival, TipoDeEntrada).
% Indica la venta de una entrada de cierto tipo para el festival
% indicado.
% Los tipos de entrada pueden ser alguno de los siguientes:
%     - campo
%     - plateaNumerada(Fila)
%     - plateaGeneral(Zona).
entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

% plusZona(Lugar, Zona, Recargo)
% Relacion una zona de un lugar con el recargo que le aplica al precio de las plateas generales.
plusZona(hipodromoSanIsidro, zona1, 1500).

% Punto 1

itinerante(Festival):-
    festival(Festival,Bandas,Lugar1),
    festival(Festival,Bandas,Lugar2),
    Lugar1\=Lugar2.

% Punto 2

careta(personalFest).
careta(Festival):-
    festival(Festival,_,_),
    not(entradaVendida(Festival,campo)).

% Punto 3

nacAndPop(Festival):-
    festival(Festival,Bandas,_),
    not(careta(Festival)),
    forall(member(Banda,Bandas),(banda(Banda,argentina,Popularidad), Popularidad>1000)),



popularidad(Festival,PopularidadTotal):-
    festival(Festival,Bandas,_),
    findall(Popularidad,(member(Banda,Bandas),banda(Banda,_,Popularidad)),Popularidades),
    sumlist(Popularidades,PopularidadTotal).

% Punto 4
sobrevendido(Festival):-
    festival(Festival,_,Lugar),
    lugar(Lugar,Capacidad,_),
    findall(Entrada,entradaVendida(Festival,Entrada),TotalEntradas),
    length(TotalEntradas, EntradasVendidas),
    Capacidad<EntradasVendidas.


% Punto 5

recaudacionTotal(Festival,Recaudacion):-
    findall(Precio,(entradaVendida(Festival,Entrada),precioEntrada(Festival,Entrada,Precio)),PreciosEntradas),
    sumlist(PreciosEntradas,Recaudacion).

precioBase(Festival,Lugar,PrecioBase):-
    festival(Festival,_,Lugar),
    lugar(Lugar,_,PrecioBase).

precioEntrada(Lugar,campo,Entrada):-
    lugar(Lugar,_,Entrada).
precioEntrada(Lugar,plateaGeneral(Zona),Entrada):-
    lugar(Lugar,_,PrecioBase),
    plusZona(Lugar,Zona,Plus), Entrada is PrecioBase+Plus.
precioEntrada(Lugar,plateaNumerada(Numero),Entrada):-
    precioPorDistancia(Numero,Multiplicador),
    lugar(Lugar,_,PrecioBase),
    Entrada is Multiplicador*PrecioBase.

precioPorDistancia(Distancia,3):-
    Distancia>10.    
precioPorDistancia(Distancia,6):-
    Distancia=<10.

% Punto 6

tocaronJuntas(Banda1,Banda2):-
    festival(_,Bandas,_),
    member(Banda1,Bandas), member(Banda2,Bandas),
    Banda1\=Banda2.

mismoPalo(Banda1,Banda2):-
    tocaronJuntas(Banda1,Banda2).
mismoPalo(Banda1,Banda2):-
    tocaronJuntas(Banda1,BandaPopular),
    mismoPalo(BandaPopular,Banda2),
    banda(BandaPopular,_,MasPop),
    banda(Banda2,_,MenosPop),
    MenosPop<MasPop.


    

    
