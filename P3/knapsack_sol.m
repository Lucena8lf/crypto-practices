function [v,valide] = knapsack_sol (s,obj)
%Función que comprueba si una mochila dada cumple un determinado
%objetivo con el algoritmo estudiado para mochilas supercrecientes. Es importante observar
%que aunque se sabe que el algoritmo siempre funciona para mochilas supercrecientes, pudiera
%también funcionar para algunos casos concretos de mochilas generales.
%
%Entradas:
%s: una mochila. La función debe comprobar que lo sea, así como que sea supercreciente.
%obj: el objetivo a alcanzar.
%Salidas:
%v: en caso de que el objetivo se cumpla es un vector indicando los valores de la mochila
%que permiten obtenerlo (sea o no la mochila supercreciente). En caso contrario v = 0.
%valide: misma salida que en la función anterior.

% Primero obtenemos valide de la funcion anterior
valide = knapsack(s);

if valide == -1
    v = 0;
    return
end

% Para aplicar el algortimo recorremos toda la mochila y vamos actualizando
% m mirando al final si hemos obtenido 0 para ver si existe solucion
[k n] = size(s);
v = zeros(k,n);

xi = 0;
for i=n:-1:1
    if obj >= s(i)
        xi = 1;
        % Guardamos los valores de la mochila que nos dan el objetivo
        % pedido en caso de tener solucion
        v(i) = 1;
    else
        xi = 0;
    end

    obj = obj - xi * s(i);
end

if obj ~= 0
    v = 0;
end