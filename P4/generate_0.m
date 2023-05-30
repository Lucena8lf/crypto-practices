function gen = generate_0 (g,p)
%Se trata de una función que comprueba, mediante la definición de generador, si el número
%natural g es generador del grupo multiplicativo determinado por el primo p.
%
%Entradas:
%g: el número natural candidato a generador.
%p: el número primo que determina el grupo multiplicativo.
%Salidas:
%gen = 0 en caso de que no sea generador.
%gen = g en caso de que sea generador.

potencias = zeros(1,p-1);
gen = g;

% Antes de nada comprobamos si g es un numero natural
if g < 1 || g ~= round(g)
    error('El candidato a generador debe ser un número natural')
elseif ~isprime(p)
    error('El grupo multiplicativo debe ser determinado por un número primo');
end

% Al ser por la definición de generador calculamos todas las potencias de g y
% comprobamos si obtenemos todos los elementos del grupo
tic % Iniciamos contador
for i=1:(p-1)
    potencias(i) = power_mod(g,i,p);
end

if length(potencias) ~= length(unique(potencias)) % Si hay repetidos no ha obtenido todos los elementos del grupo
    gen = 0;
end

toc % Detenemos contador
