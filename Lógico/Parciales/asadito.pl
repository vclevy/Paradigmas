% define quiénes son amigos de nuestro cliente
amigo(mati). 
amigo(pablo). 
amigo(leo).
amigo(fer). 
amigo(flor).
amigo(ezequiel). 
amigo(marina).
% define quiénes no se pueden ver
noSeBanca(leo, flor). 
noSeBanca(pablo, fer).
noSeBanca(fer, leo). 
noSeBanca(flor, fer).
% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).
% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(15,9,2011), mixta).
asado(fecha(15,9,2011), mondiola).
asado(fecha(15,9,2011), chinchu).
asado(fecha(22,9,2011), chori). 
asado(fecha(22,9,2011), waldorf). 
asado(fecha(22,9,2011), vacio). 
% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), pablo). 
asistio(fecha(15,9,2011), leo). 
asistio(fecha(15,9,2011), flor). 
asistio(fecha(15,9,2011), fer). 
asistio(fecha(22,9,2011), marina).
asistio(fecha(22,9,2011), pablo).
asistio(fecha(22,9,2011), flor).
asistio(fecha(22,9,2011), mati).
% definimos qué le gusta a cada persona
leGusta(mati, chori). 
leGusta(mati, vacio). 
leGusta(mati, waldorf). 
leGusta(fer, mondiola). 
leGusta(fer, vacio).
leGusta(pablo, asado).
leGusta(flor, mixta).

asadoViolento(Fecha):-
    asistio(Fecha,Asistente),
    forall(asistio(Fecha,Asistente),(asistio(Fecha,OtroAsistente),noSeBanca(Asistente,OtroAsistente))).

calorias(Nombre,Calorias):-
    comida(Comida),
    nombre(Comida,Nombre),
    caloriasSegunTipo(Comida,Calorias).

nombre(achura(Nombre, _),Nombre).
nombre(ensalada(Nombre, _),Nombre).
comida(morfi(Nombre),Nombre).

caloriasSegunTipo(ensalada(_, Ingredientes),Calorias):-
    length(Ingredientes,Calorias).
caloriasSegunTipo(achura(_, Calorias),Calorias).
caloriasSegunTipo(morfi(asado),200).

asadoFlojito(Fecha):-
    asistio(Fecha,_),
    findall(Cal,caloriasDeAsado(Fecha,Cal),Calorias),
    sumlist(Calorias, CantidadDeCalorias),
    CantidadDeCalorias<400.

caloriasDeAsado(Fecha,Cal):-
    asado(Fecha,Comida),
    calorias(Comida,Cal).

hablo(fecha(15,09,2011), flor, pablo). 
hablo(fecha(15,09,2011), pablo, leo). 
hablo(fecha(15,09,2011), leo, fer). 
hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(22,09,2011), marina, pablo).
reservado(marina).

chismeDe(Fecha,UnaPersona,OtraPersona):-
    asistio(Fecha,UnaPersona),
    asistio(Fecha,OtraPersona),
    conoceAlgunChismeDe(Fecha,OtraPersona,UnaPersona).

conoceAlgunChismeDe(Fecha,OtraPersona,UnaPersona):-
    hablo(Fecha,UnaPersona,OtraPersona).

/*conoceAlgunChismeDe(Fecha,OtraPersona,UnaPersona):-
    hablo(Fecha,OtraPersona,NuevaPersona),
    hablo(Fecha,NuevaPersona,UnaPersona),
    not(reservado(NuevaPersona)).*/

    
conoceAlgunChismeDe(Fecha,OtraPersona,UnaPersona):-
    hablo(Fecha,OtraPersona,NuevaPersona),
    writeln(['NuevaPersona:', NuevaPersona]), % Debugging statement
    hablo(Fecha,NuevaPersona,UnaPersona),
    writeln(['UnaPersona:', UnaPersona]), % Debugging statement
    not(reservado(NuevaPersona)),
    writeln(['NuevaPersona is not reservado:', NuevaPersona]). % Debugging statement


    