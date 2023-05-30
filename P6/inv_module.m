function inver=inv_module(A,m)
%Función que calcula la inversa modular de una matriz con coeficientes
%enteros
%
%Entradas:
%A: la matriz de la queremos calcular su inversa.
%m: el módulo de trabajo.
%Salida: la inversa modular de la matriz dada.


% Comprobamos que la matriz tenga elementos que solo sean enteros
if ismember(1,floor(A) ~= A)% Floor() redondea. Si contiene un 1 -> NO es matriz de enteros
    error('Todos los elementos de la matriz deben ser números enteros');
end

% 1. Calculamos la inversa modular del determinante de la matriz ->
% det(A)^-1 mod n
detA = round(det(A)); % Tenemos que utilizar round() porque nos devuelve un decimal

[G, C, ~] = gcd(mod(detA,m), m);
inverseDet = mod(C,m);

if G ~= 1
    error('La matriz no es inversible con el modulo dado');
end

% 2. Calculamos la adjunta traspueta de la matriz -> (Adj A)'
adjT = detA * inv(A);

% 3. A^-1 mod n = det(A)^-1 * (Adj A)' mod n
inver = mod(inverseDet * adjT,m);