productoXL:: String->String
productoXL unProducto = unProducto ++ " XL"

esProductoCorriente:: String->Bool
esProductoCorriente unProducto = head unProducto == 'A' || head unProducto == 'E' || head unProducto == 'I' ||
    head unProducto == 'O' || head unProducto == 'U'

esProductoCodiciado:: String->Bool
esProductoCodiciado unProducto = length unProducto > 10

aplicarCostoDeEnvio:: Float->Float->Float
aplicarCostoDeEnvio unPrecio costoDeEnvio = unPrecio+costoDeEnvio

contarLetras:: String->Int
contarLetras unProducto = length unProducto

entregaSencilla:: String->Bool;
entregaSencilla unaFecha = (even.contarLetras) unaFecha

esProductoDeLujo:: String->Bool
esProductoDeLujo unProducto = elem 'X' unProducto || elem 'Z' unProducto || elem 'x' unProducto || elem 'z' unProducto

aplicarDescuento:: Float->Float->Float
aplicarDescuento precio descuento = precio - (precio * (descuento / 100))

esProductoElite:: String->Bool
esProductoElite unProducto = esProductoCodiciado unProducto && esProductoDeLujo unProducto && length unProducto < 10

precioTotal :: Float -> Float -> Float -> Float -> Float
precioTotal precioUnitario unaCantidad descuento costoDeEnvio = 
    (aplicarCostoDeEnvio costoDeEnvio . aplicarDescuento descuento) (precioUnitario * unaCantidad)

--precioTotal precioUnitario unaCantidad descuento costoDeEnvio = 
--    aplicarCostoDeEnvio (aplicarDescuento (precioUnitario * unaCantidad) descuento) costoDeEnvio
--tambien podria ser de esa forma, pero sin composición de funciones.
