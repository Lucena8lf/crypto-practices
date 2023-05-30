function gen = generate (g,p)
%Se trata de una función que comprueba, mediante el criterio alternativo estudiado en clase,
%si el número natural g es generador del grupo multiplicativo determinado por el primo p.
%
%Entradas:
%g: el número natural candidato a generador.
%p: el número primo que determina el grupo multiplicativo.
%Salidas:
%gen = 0 en caso de que no sea generador.
%gen = g en caso de que sea generador.

gen = g;

% Antes de nada comprobamos si g es un numero natural y si p es un numero
% primo
if g < 1 || g ~= round(g)
    error('El candidato a generador debe ser un número natural');
elseif ~isprime(p)
    error('El grupo multiplicativo debe ser determinado por un número primo');
end

% Iniciamos contador
tic

% Primero factorizamos p-1
factors = factor(p-1);

% Ahora para cada factor estudiamos el generador como g^(p-1/qi) mod p. Si
% obtenemos como resultado de lo anterior 1 significara que no es generador.
for i=1:length(factors)
    e = uint64((p-1)/factors(i));
    
    pow = power_mod(g,e,p);

    if pow == 1
        gen = 0;
    end
    
end

% Detenemos contador
toc
