import Text.Show.Functions

data Participante = UnParticipante{
    nombre::String,
    dinero::Int,
    tactica::String,
    propiedades::[Propiedad],
    acciones::[Accion]
}  deriving (Show)

type Propiedad = (Nombre, Precio) 
type Nombre = String
type Precio = Int
nombrePropiedad :: Propiedad -> Nombre
nombrePropiedad (nombreProp,_) = nombreProp
precioPropiedad :: Propiedad -> Precio
precioPropiedad (_, precio) = precio
type Accion = Participante->Participante 

carolina::Participante
carolina= UnParticipante "Carolina" 500 "Accionista" [] [pasarPorElBanco, pagarAAccionistas]

manuel::Participante
manuel= UnParticipante "Manuel" 500 "Oferente singular" [] [pasarPorElBanco, enojarse]

pasarPorElBanco::Accion
pasarPorElBanco unParticipante = modificarDinero (+40) (unParticipante {tactica="Comprador Compulsivo"})

modificarDinero:: (Int->Int) -> Participante -> Participante
modificarDinero unaFuncion unParticipante = unParticipante {dinero= unaFuncion (dinero unParticipante)}

enojarse::Accion
enojarse unParticipante = modificarDinero (+50) (unParticipante {acciones = acciones unParticipante ++ [gritar]})

gritar::Accion
gritar unParticipante = unParticipante {nombre = "AHHHH " ++ nombre unParticipante}

subastar:: Propiedad -> Accion
subastar unaPropiedad unParticipante 
    | tactica unParticipante == "Oferente singular" || tactica unParticipante == "Accionista" =
        modificarDinero (subtract (precioPropiedad unaPropiedad)) (agregarPropiedad unParticipante unaPropiedad) 
    |otherwise = unParticipante 

agregarPropiedad :: Participante -> Propiedad -> Participante
agregarPropiedad unParticipante unaPropiedad = unParticipante {propiedades = propiedades unParticipante ++ [unaPropiedad] }

cobrarAlquileres::Accion
cobrarAlquileres unParticipante = modificarDinero (+ (sum (listaDeCarasYBaratas unParticipante))) unParticipante 

listaDeCarasYBaratas :: Participante -> [Int]
listaDeCarasYBaratas unParticipante = map (barataOCara) (propiedades unParticipante)

barataOCara:: Propiedad -> Int
barataOCara unaPropiedad | precioPropiedad unaPropiedad < 150 = 10 
                         | otherwise = 20

{- 
listaDeCarasYBaratas :: Participante -> [Int]
listaDeCarasYBaratas unParticipante = map (\(nombre, precio) -> calcularPrecio precio) (propiedades unParticipante)
    where calcularPrecio precio
            | precio < 150 = 10
            | otherwise = 20 -} --otra forma con funcion lambda pero se utiliza where


pagarAAccionistas :: Accion
pagarAAccionistas unParticipante 
    | tactica unParticipante == "Accionista" = modificarDinero (+200) unParticipante
    | otherwise = modificarDinero (subtract 100) unParticipante

