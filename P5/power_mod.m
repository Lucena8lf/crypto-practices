function pow = power_mod (b,e,m)
%Se trata de una función que aplica el método de potenciación rápida o binaria para calcular
%potencias modulares.
%
%Entradas:
%b: un número natural, la base de la potencia.
%e: un número natural, el exponente de la potencia.
%m: un número natural, el módulo de trabajo.
%Salida: un número natural, el resultado de la potencia b^e módulo m

pow = 1;

% Antes de nada comprobamos que todos los parametros que nos pasan sean numeros
% naturales
if b < 1 || e < 1 || m < 1 || b ~= round(b) || e ~= round(e) || m ~= round(m)
    error('Los números pasados deben ser números naturales');
end

% Primero escribimos el exponente como suma de potencias de base 2
% Para ello pasamos el numero a binario y vemos como quedaria
reverseBinario = fliplr(dec2bin(e)); % Lo invertimos para recorrerlo por el final

for i=1:length(reverseBinario)

    if i-1 == 0 % Si es 0 lo calculamos directamente
        res = b^(2^(i-1));
        res = uint64(mod(res,m));
    else % Si no lo calculamos en base al anterior
        res = valorAnterior^2;
        res = uint64(mod(res,m));
    end

    % Si la que hemos calculado nos sirve para el resultado final lo vamos
    % multiplicando
    if reverseBinario(i) == dec2bin(1)
            pow = pow*res;
            pow = mod(pow,m);
    end
    
    valorAnterior = res;
end