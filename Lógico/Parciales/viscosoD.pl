%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)). %nombre,peso
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)). %nombre tamano peso
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
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

cucaracha(Nombre, Tamano, Peso) :- comio(_, cucaracha(Nombre, Tamano, Peso)).

jugosita(cucaracha(Nombre, Tamano, Peso)) :-
    cucaracha(Nombre, Tamano, Peso),
    cucaracha(OtraNombre, Tamano, OtroPeso),
    Nombre \= OtraNombre,
    Peso > OtroPeso.

hormigolifico(Personaje):-
    comio(Personaje,_),
    findall(Nombre,comio(Personaje,hormiga(Nombre)),Hormigas),
    length(Hormigas,Cuantas), Cuantas>=2.

cucarachofobico(Personaje):-
    comio(Personaje,_),
    not(comio(Personaje,cucaracha(_,_,_))).

esPicaron(pumba).
esPicaron(Personaje):-
    comio(Personaje,Cucaracha),
    jugosita(Cucaracha).
esPicaron(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,4)).

losPicarones(Picarones):-
    findall(Nombre,esPicaron(Nombre),Picarones).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).
persigue(scar, mufasa).

pesa(cucaracha(_,_,Peso),Peso).
pesa(vaquitaSanAntonio(_,Peso),Peso).
pesa(hormiga(_),Peso):-
    pesoHormiga(PesoHormiga),
    Peso is PesoHormiga.

/*engorda(Personaje,Engorda):-
    bichosComidos(Personaje,PesosBichos),
    animalesComidos(Personaje,PesosPresa),
    Engorda is PesosPresa + PesosBichos.
bichosComidos(Personaje,Engorda):-
    comio(Personaje,_),
    findall(Peso,(comio(Personaje,Bicho),pesa(Bicho,Peso)),Pesos),
    sumlist(Pesos, Engorda).
bichosComidos(Personaje,0):- not(comio(Personaje,_)).
animalesComidos(Personaje,Engorda):-
    persigue(Personaje,_),
    findall(PesoPresa,(persigue(Personaje,Presa),peso(Presa,PesoPresa)),PesosPresa),
    findall(PesoBichos,(persigue(Personaje,Presa),bichosComidos(Presa,PesoBichos)),PesosBichos),
    sumlist(PesosPresa, Presas),
    sumlist(PesosBichos,Bichos),
    Engorda is Bichos+Presas.
animalesComidos(Personaje,0):- not(persigue(Personaje,_)).*/
noAdora(Personaje, AOtro):- persigue(Personaje,AOtro).
noAdora(Personaje, AOtro):- comio(Personaje,AOtro).

rey(Rey):-
    persigue(_,Rey),
    findall(Personaje,noAdora(Personaje,Rey),Haters),
    length(Haters,1).

    