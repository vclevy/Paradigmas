%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
%cucaracha(nombre,tamaño,peso).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

esJugosita(Cucaracha):-
    comio(_, Cucaracha),
    comio(_, Cucaracha2),
    Cucaracha\=Cucaracha2,
    tamanio(Cucaracha,Tam),
    pesoTam(Tam,Cucaracha,Peso1),
    pesoTam(Tam,Cucaracha2,Peso2),
    Peso1>Peso2.

tamanio(cucaracha(_,Tam,_),Tam).
pesoTam(Tam,cucaracha(_,Tam,Peso),Peso).

esHormigofilico(Personaje):-
    comio(Personaje,hormiga(Hormiga1)),
    comio(Personaje,hormiga(Hormiga2)),
    Hormiga1\=Hormiga2.

esCucarachafobico(Personaje):-
    comio(Personaje,_),
    not(comio(Personaje,cucaracha(_,_,_))).

picarones(Picarones):-
    findall(Personaje,esPicaron(Personaje),Picarones).

esPicaron(pumba).

esPicaron(Personaje):-
    comio(Personaje,Cucaracha),
    esJugosita(Cucaracha).

esPicaron(Personaje):-
    comio(Personaje,vaquitaSanAntonio(remeditos,4)).

% PUNTO 2 (PERO YO QUIERO CARNE)

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

cuantoEngorda(Personaje,Peso):- % personajes no bichos
    findall(Kilo,pesoDeBichosDevorados(Personaje,Kilo),ListaDeKilos),
    sumlist(ListaDeKilos,Peso).

cuantoEngorda2(Personaje,Peso):- %bichos q persiguen
    findall(Kilo,pesoDePersonajesDevorados(Personaje,Kilo),ListaDeKilos),
    cuantoEngorda(Personaje,Peso1),
    sumlist(ListaDeKilos,Peso2),
    Peso is Peso1+Peso2.

pesoDeBichosDevorados(Personaje,Kilo):-
    comio(Personaje,Bicho),
    pesoDe(Bicho,Kilo).

pesoDe(hormiga(_),Peso):-
    pesoHormiga(Peso).
pesoDe(cucaracha(_,_,Peso),Peso).
pesoDe(vaquitaSanAntonio(_,Peso),Peso).

pesoDePersonajesDevorados(Personaje,Kilo):-
    persigue(Personaje,Personaje2),
    peso(Personaje2,Kilo).

cuantoEngorda3(Personaje,Peso):-
    findall(Kilo,pesoDePersonajesDevoradosLlenitos(Personaje,Kilo),ListaDeKilos), %peso de personajes q a su vez se comen a bichos
    cuantoEngorda(Personaje,Peso1), %peso de bichos q se come 
    sumlist(ListaDeKilos,Peso2),
    Peso is Peso1+Peso2.

pesoDePersonajesDevoradosLlenitos(Personaje,Kilo):-
    persigue(Personaje,Personaje2),
    cuantoEngorda(Personaje2,Kilo1),
    peso(Personaje2,Kilo2),
    Kilo is Kilo1+Kilo2.

