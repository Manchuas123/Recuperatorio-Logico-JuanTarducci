
% punto 1

%vive(Duenio,Propiedad)

%casa(Metros)
%departamento(CantidadDeAmbientes,CantidadDeBaños)
%loft(AnioEnElQueSeConstruyo)

vive(juan,casa(120)).
vive(nico,departamento(3,2)).
vive(alf,departamento(3,1)).
vive(julian,loft(2000)).
vive(vale,departamento(4,1)).
vive(fer,casa(110)).

%seQuiereMudar(rocio,casa(90)). no lo agregamos por principio de universo cerrado

%zonaDondeVive(Persona,Zona)
barrio(alf,almagro).
barrio(juan,almagro).
barrio(nico,almagro).
barrio(julian,almagro).
barrio(vale,flores).
barrio(fer,flores).

%agrego a la base de conocimientos info del punto 4

%tasacion(duenio,valor).
tasacion(juan,150000).
tasacion(nico,80000).
tasacion(alf,75000).
tasacion(julian,140000).
tasacion(vale,95000).
tasacion(fer,60000).

% punto 2

esCopada(casa(Metros)):- Metros > 100.
esCopada(departamento(CantAmbientes,_)):- CantAmbientes > 3.
esCopada(departamento(_,CantBanios)):- CantBanios > 1.
esCopada(loft(AnioContruido)):- AnioContruido > 2015.

esCopado(UnBarrio):-
    barrio(_,UnBarrio),
    forall((barrio(UnaPersona,UnBarrio),vive(UnaPersona,UnaPropiedad)),esCopada(UnaPropiedad)).

% punto 3

esBarata(loft(Anio)):- Anio < 2005.
esBarata(casa(Metros)):- Metros < 90.
esBarata(departamento(CantAmbientes,_)):- CantAmbientes < 3. %suponiendo que la cantidad de ambientes nunca puede ser negativa

esCaro(UnBarrio):-
    barrio(_,UnBarrio),
    forall((barrio(UnaPersona,UnBarrio),vive(UnaPersona,UnaPropiedad)),not(esBarata(UnaPropiedad))).

% punto 4

podemosComprar(UnasPropiedades,CantPlata,Resto):-
    %length(UnasPropiedades,Tamanio), Tamanio > 0,
    cantidadAGastar(UnasPropiedades,TotalAPagar),
    CantPlata - TotalAPagar > 0,
    Resto is CantPlata - TotalAPagar.

cantidadAGastar(UnasPropiedades,Cantidad):-
    findall(Valor,(member(Propiedad,UnasPropiedades),valorDe(Propiedad,Valor)),ListaDeCostos),
    sumlist(ListaDeCostos,Cantidad).

valorDe(Propiedad,Valor):-
    vive(UnPropietario,Propiedad),
    tasacion(UnPropietario,Valor).

generarPropiedades(UnasPropiedades):-
    findall(Propiedad,vive(_,Propiedad),UnasPropiedades).




%podemosComprar(UnasPropiedades,CantPlata,Resto):-
%    generarPropiedades(UnasPropiedades),
%    cantidadAGastar(UnasPropiedades,TotalAPagar),
%    CantPlata - TotalAPagar > 0,
%    Resto is CantPlata - TotalAPagar.

%generarPropiedades(UnasPropiedades,CantPlata):-
%    findall(Propiedad,(vive(_,Propiedad),sePuedeComprar(Propiedad,CantPlata), CantPlata > 0),UnasPropiedades).

%sePuedeComprar(Propiedad,CantPlata):-
%    valorDe(Propiedad,Valor),
%    Valor =< CantPlata,
%    CantPlata is CantPlata - Valor.