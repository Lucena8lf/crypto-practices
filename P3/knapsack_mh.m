function [publ_k,priv_k] = knapsack_mh (s)
%Función que permite al usuario (el receptor) generar una pareja de claves
%pública y privada adecuada a partir de una mochila supercreciente.
%
%Entrada: una mochila supercreciente.
%Salidas:
%publ_k: la mochila trampa creada a partir de la mochila supercreciente s y de los valores
%de mu y w. El valor mu debe introducirlo el usuario, por lo que se lo debe pedir la función y
%debe comprobar que sea adecuado. El valor w lo buscará la función asegurándose que tenga
%inverso módulo mu y que no tenga factores comunes con los elementos de s.
%priv_k: un vector fila con dos elementos: mu y el inverso de w módulo mu.

publ_k = [];
mu = 0;
w = 0;

% Comprobamos que la mochila sea supercreciente
valide = knapsack(s);

if valide == -1 || valide == 0
    error('La mochila debe ser supercreciente');
end

% Pedimos el valor de mu al usuario
minMu = 2*s(end);
while mu < minMu
    mu = input(['\nIntroduce el valor de mu, el cual debe ser un numero natural mayor o igual a ' num2str(minMu) ': ']);
end

% Buscamos un w adecuado
% Para ello elegimos x ∈ [2, mu − 2] y tomamos w = x/MCD(m,x)
for i=2:mu-2
    [factor_c ~] = common_factors(i,s);
    if gcd(mu,i) == 1 && factor_c == 0
        w = i/gcd(mu,i);
    end
end

disp(w)

% 1. Obtenemos la clave privada
% La clave privada sera un vector fila con dos elementos: mu y el inverso de w módulo mu
[G D] = gcd(w,mu); % D = inverso de w
inverW = mod(D,mu); % inverW = inverso de w en modulo mu
priv_k = [mu inverW];

% 2. Obtenemos la clave publica
% Para obtener la clave publica multiplicamos w por cada elemento de la mochila
%supercreciente y lo pasamos a modulo mu
for i=1:length(s)
    bi = mod(w * s(i),mu);
    publ_k = [publ_k bi];
end