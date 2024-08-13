%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).
descuento(arroz(_),1.50).
descuento(salchicas(Marca,_),0.5):-
    Marca\=vienisima.
descuento(lacteo(_,leche),2).
descuento(lacteo(Calidad,queso(_)),2):-
    primeraMarca(Calidad).

%compro(Cliente,Producto,Cantidad)
compro(juan,salchichas(vienisima,6),2).

dueno(laSerenisima, gandara).
dueno(gandara, vacalin).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esDePrimeraMarca(arroz(Marca)):-
    primeraMarca(Marca).
esDePrimeraMarca(lacteo(Marca,_)):-
    primeraMarca(Marca).
esDePrimeraMarca(salchicas(Marca,_)):-
    primeraMarca(Marca).

compradorCompulsivo(Persona):-
    compro(Persona,_,_),
    forall((esDePrimeraMarca(Producto),descuento(Producto,_)),compro(Persona,Producto,_)).

precioFinalProducto(Producto,PrecioFinal):-
    descuento(Producto,Dto),
    precioUnitario(Producto,Precio),
    PrecioFinal is Precio-Dto.
precioFinalProducto(Producto,PrecioFinal):-
    precioUnitario(Producto,PrecioFinal),
    not(descuento(Producto,_)).

precioCompraProducto(Persona,Producto,Precio):-
    compro(Persona,Producto,Cantidad),
    precioFinalProducto(Producto,PrecioFinal),
    Precio is PrecioFinal*Cantidad.

totalAPagar(Persona,Total):-
    compro(Persona,_,_),
    findall(Precio,precioCompraProducto(Persona,_,Precio),ListaPrecios),
    sumlist(ListaPrecios, Total).
    
% productoYMarca(lacteo,Marca):-
%     precioUnitario(lacteo(Marca,_),_).
% productoYMarca(arroz,Marca):-
%     precioUnitario(arroz(Marca),_).
% productoYMarca(salchichas,Marca):-
%     precioUnitario(salchichas(Marca,_),_).

% noEsMarcaUnica(Marca):-
%     productoYMarca(Producto,Marca),
%     productoYMarca(Producto,OtraMarca),
%     not(seRelacionan(Marca,OtraMarca)),
%     OtraMarca\=Marca.

clienteFiel(Persona,Marca):- %No se xq no anda
    noEsMarcaUnica(Marca), compro(Persona,_,_),
    forall(compro(Persona,Producto,_),productoYMarca(Producto,Marca)).

esDuenoDe(Empresa,OtraEmpresa):-
    dueno(Empresa,OtraEmpresa).
esDuenoDe(Empresa,OtraEmpresa):-
    dueno(Empresa,Intermediario),
    esDuenoDe(Intermediario,OtraEmpresa).

empresaDelProducto(lacteo(Empresa,_),Empresa).
empresaDelProducto(arroz(Empresa),Empresa).
empresaDelProducto(salchichas(Empresa,_),Empresa).

productoDeLaEmpresa(Producto,Empresa):-
    precioUnitario(Producto,_),
    empresaDelProducto(Producto,Empresa).
productoDeLaEmpresa(Producto,Empresa):-
    precioUnitario(Producto,_),
    empresaDelProducto(Producto,OtraEmpresa),
    esDuenoDe(Empresa,OtraEmpresa).

provee(Empresa,Productos):-
    findall(Producto,productoDeLaEmpresa(Producto,Empresa),Productos).
