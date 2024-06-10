type Titulo = String
type Autor = String
type CantidadDePaginas = Int
type Libro = (Titulo, Autor, CantidadDePaginas)

elVisitante :: Libro
elVisitante = ("El Visitante", "Stephen King", 592)
snk:: Libro
snk = ("Shingeki no Kyojin", "Hajime Isayama", 120)
fundacion:: Libro
fundacion = ("Fundacion", "Isaac Asimov", 230)
sandman:: Libro
sandman = ("Sandman", "Neil Gaiman", 105)
eragon:: Libro
eragon = ("Eragon", "Christopher Paolini", 544)
eldest:: Libro
eldest = ("Eldest", "Christopher Paolini", 704)
brisignr:: Libro
brisignr = ("Brisignr", "Christopher Paolini", 700)
legado:: Libro
legado = ("Legado", "Christopher Paolini", 811)

cantidadDePaginas :: Libro -> Int   --ACCESO A CANTDEPAGS
cantidadDePaginas (_, _, cantidadDePaginas) = cantidadDePaginas
autor :: Libro -> String
autor (_, autor, _) = autor --ACCESO A AUTOR
titulo :: Libro -> String
titulo (titulo, _, _) = titulo --ACCESO A TITULO

type Biblioteca = [Libro]
miBiblioteca:: Biblioteca
miBiblioteca = [elVisitante, snk, fundacion, sandman, eragon, eldest, brisignr, legado]
sagaEragon:: Biblioteca
sagaEragon = [eragon, eldest, brisignr, legado]

promedioDeHojas :: Biblioteca -> Int
promedioDeHojas biblioteca =  (cantidadDePaginasTotal biblioteca) `div`  (cantidadDeLibros biblioteca)

cantidadDePaginasTotal :: Biblioteca -> Int
cantidadDePaginasTotal biblioteca = sum (map cantidadDePaginas biblioteca)

cantidadDeLibros:: Biblioteca -> Int
cantidadDeLibros biblioteca = length biblioteca

esLecturaObligatoria :: Libro->Bool
esLecturaObligatoria unLibro = esDe unLibro "Stephen King" || esDeLaSagaEragon unLibro || esFundacion unLibro

esDe :: Libro -> String -> Bool
esDe unLibro unAutor = autor unLibro == unAutor

esDeLaSagaEragon :: Libro -> Bool
esDeLaSagaEragon unLibro = unLibro `elem` sagaEragon

esFundacion :: Libro -> Bool
esFundacion unLibro = unLibro == fundacion 

esFantasiosa :: Biblioteca -> Bool
esFantasiosa biblioteca = tieneLibroDe biblioteca "Christopher Paolini" || tieneLibroDe biblioteca "Neil Gaiman"

tieneLibroDe:: Biblioteca -> String -> Bool
tieneLibroDe biblioteca nombreAutor = elem nombreAutor (map autor biblioteca)

nombreDeLaBiblioteca:: Biblioteca -> String
nombreDeLaBiblioteca biblioteca = (sacarleLasVocales.juntarLosTitulos) biblioteca

juntarLosTitulos :: Biblioteca -> String
juntarLosTitulos biblioteca = foldl1 (++) (map titulo biblioteca)

{-concatenatoriaDeTitulos :: Biblioteca -> String
concatenatoriaDeTitulos unaBiblioteca = concatMap titulo unaBiblioteca-} -- OTRA RESOLUCIÓN, APLICANDO CONCATMAP Q HACE LO MISMO

sacarleLasVocales :: String -> String
sacarleLasVocales unaCadena = filter (not . esVocal) unaCadena -- filter devuelve lo q cumple con la condición, en este caso, no es vocal

esVocal :: Char -> Bool
esVocal unCaracter = elem unCaracter "aeiouAEIOU"

esBibliotecaLigera:: Biblioteca -> Bool
esBibliotecaLigera biblioteca = (esMenorA40.listaDePaginas) biblioteca

listaDePaginas :: Biblioteca -> [Int]
listaDePaginas biblioteca = map cantidadDePaginas biblioteca

esMenorA40 :: [Int] -> Bool
esMenorA40 listaDePags = all (< 40) listaDePags

