function n = power_a (A, m)
%Función que calcula el mínimo valor del exponente de la potencia de A
%que módulo m es igual a la matriz identidad.
%
%Entradas:
%A: una matriz cuadrada de orden 2, con elementos enteros, y con inversa módulo m.
%m: un número natural, que representa nuestro módulo de trabajo.
%Salida: un número natural, que se corresponde con el valor del exponente para el que la
%correspondiente potencia de A módulo m es la identidad.

% Comprobamos que debe A sea cuadrada, de orden 2, con elementos enteros y debe tener inversa módulo el número de filas de photo
% Es cuadrada y de orden 2
[f c]=size(A);
if f ~= c
    error('La matrix A debe ser cuadrada');
elseif f ~= 2
    error('La matriz debe ser de orden 2');
end

% Comprobamos que la matriz tenga elementos que solo sean enteros
if ismember(1,floor(A) ~= A)
    error('Todos los elementos de la matriz deben ser números enteros');
end

% Comprobamos si la matriz es invertible con el módulo dado
detA = round(det(A)); % Tenemos que utilizar round() porque nos devuelve un decimal

[G, C, ~] = gcd(mod(detA,m), m);
inverseDet = mod(C,m);

if G ~= 1
    error('La matriz no es inversible con el modulo dado');
end

new_A = A;
n = 1;

% Aplicamos el algoritmo para calcular la potencia de matrices
while ~isequal(new_A,eye(f))
    new_A = mod(A * new_A,m);
    n = n + 1;
end