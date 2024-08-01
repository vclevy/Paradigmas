%no esta terminadao

comercioAdherido(iguazu, grandHotelIguazu). 
comercioAdherido(iguazu, gargantaDelDiabloTour). 
comercioAdherido(bariloche, aerolineas). 
comercioAdherido(iguazu, aerolineas).

%factura(Persona, DetalleFactura).
%Detalles de facturas posibles: 
% hotel(ComercioAdherido, ImportePagado) 
% excursion(ComercioAdherido, ImportePagadoTotal, CantidadPersonas) 
%vuelo(NroVuelo,NombreCompleto) 
factura(estanislao, hotel(grandHotelIguazu, 2000)). 
factura(estanislao, hotel(grandHotelIguazu, 1000)). 
factura(antonieta, excursion(gargantaDelDiabloTour, 5000, 4)). 
factura(antonieta, vuelo(1515, antonietaPerez)). 
factura(delfi, hotel(grandHotelIguazu, 0)). 
factura(delfi, vuelo(1515, delfi)). 


valorMaximoHotel(5000).

%registroVuelo(NroVuelo,Destino,ComercioAdherido,Pasajeros,Precio) 
registroVuelo(1515, iguazu, aerolineas, [estanislaoGarcia, antonietaPerez, danielIto], 10000).

devolver(Persona,Monto):-
    facturasValidas(Persona,Total),
    facturasInvalidas(Persona,TotalInvalidas),
    lugaresVisitados(Persona,Lugares),
    Monto is Total + TotalInvalidas + (Lugares * 1000),
    Monto<100000.

% Predicado para obtener el número de ciudades distintas que una persona ha visitado
lugaresVisitados(Persona, Lugares) :-
    findall(Ciudad, (factura(Persona, Detalle), comercioDeFactura(Detalle, Comercio), comercioAdherido(Ciudad, Comercio)), ListaCiudades),
    list_to_set(ListaCiudades, CiudadesUnicas),
    length(CiudadesUnicas, Lugares).
    
facturasValidas(Persona,Total):- 
    findall(Monto,montoDeFacturaValida(Persona,Monto),ListaDeValidas),
    sumlist(ListaDeValidas,Total).

facturasInvalidas(Persona,0):- 
    findall(Factura,invalidas(Persona,Factura),ListaDeInvalidas),
    length(ListaDeInvalidas, CantidadDeInvalidas),
    CantidadDeInvalidas = 0.

facturasInvalidas(Persona,-15000):- 
    findall(Factura,invalidas(Persona,Factura),ListaDeInvalidas),
    length(ListaDeInvalidas, CantidadDeInvalidas),
    CantidadDeInvalidas>0.
    
invalidas(Persona,Factura):-
    factura(Persona,Factura),
    facturaInvalida(Factura).

montoDeFacturaValida(Persona,Monto):-
    factura(Persona,Factura),
    not(facturaInvalida(Factura)),
    devolucion(Factura,Monto).

devolucion(hotel(_,Precio),Monto):-
    Monto is Precio *0.5.

devolucion(excursion(_,Precio,Cantidad),Monto):-
    Monto is (Precio *0.8)/Cantidad.

devolucion(vuelo(NroVuelo,_),Monto):-
    registroVuelo(NroVuelo,Destino,_,_,Precio),
    Destino \= buenosAires,
    Monto is Precio *0.3.

devolucion(vuelo(NroVuelo,_),0):-
    registroVuelo(NroVuelo,buenosAires,_,_,_).

facturaInvalida(Factura):-
    factura(_,Factura),
    esTrucha(Factura).

esTrucha(Factura):-
  comercioDeFactura(Factura,Comercio),
  not(comercioAdherido(_,Comercio)).

esTrucha(Factura):- %caso hotel
    seExcede(Factura).

esTrucha(Factura):-
    pasajeroNoEnVuelo(Factura).
  
pasajeroNoEnVuelo(vuelo(NumeroVuelo,Pasajero)):-
    registroVuelo(NumeroVuelo,_,_,Pasajeros,_),
    not(member(Pasajero,Pasajeros)).

seExcede(hotel(_,Precio)):-
    valorMaximoHotel(Valor),
    Valor<Precio.

comercioDeFactura(hotel(Comercio,_),Comercio).
comercioDeFactura(excursion(Comercio,_,_),Comercio).

estafadores(Personas):-
    findall(Persona,estafadora(Persona),Personas).

estafadora(Persona):-
    factura(Persona,_),
    forall(factura(Persona,Detalles),facturaEstafa(Detalles)).

facturaEstafa(Detalle):-
    factura(_,Detalle),
    monto(Detalle,0).

facturaEstafa(Detalles):-
    facturaInvalida(Detalles).

monto(hotel(_,Monto),Monto).
monto(excursion(_,Monto,_),Monto).

%registroVuelo(NroVuelo,Destino,ComercioAdherido,Pasajeros,Precio) 

destinoDeTrabajo(Destino):-
    forall(registroVuelo(_,Destino,_,_,_),vueloDeTrabajo(Destino)).

vueloDeTrabajo(Destino):-
    registroVuelo(_,Destino,_,_,_),
    not((factura(_,hotel(NombreHotel,_)),comercioAdherido(Destino,NombreHotel))).

vueloDeTrabajo(Destino):-
    findall(NombreHotel,(factura(_,hotel(NombreHotel,_)),comercioAdherido(Destino,NombreHotel)),ListaHoteles),
    list_to_set(ListaHoteles,SinRepetidos),
    length(SinRepetidos,1).