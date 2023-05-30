%Programa con el que se generan las claves pública y privada necesarias para
%cifrar con RSA. Para ello:
%- Se debe pedir al usuario los valores de los primos p y q. Una sugerencia, para facilitar
%la introducción de estos valores, es pedirle al programa que muestre en primer lugar un
%listado de números primos hasta un cierto valor.
%- Si los números anteriores son lo suficientemente grandes, puede
%considerarse e = 1 + 2^2^4 = 65537. En caso contrario, o bien se puede solicitar el valor al usuario o se puede
%generar cualquier valor válido para e de la manera que se considere más oportuna.

% Pedimos los valores de p y q y comprobamos que sean correctos
% Mostramos los 1000 primeros como ayuda para el usuario
fprintf('\nComo ayuda para la introducción de los valores p y q se mostrarán los primeros 1000 números primos:\n');
prim = [1 primes(1000)];
disp(prim);

p = input('\nIntroduce el valor del primo p: ');
while ~isprime(p)
    fprintf('El valor de p debe ser un número primo. Por favor, introduzca de nuevo el valor de p.\n');
    p = input('Introduce el valor del primo p: ');
end

q = input('\nIntroduce el valor del primo q: ');
while ~isprime(q)
    fprintf('El valor de q debe ser un número primo. Por favor, introduzca de nuevo el valor de q.\n');
    q = input('Introduce el valor del primo q: ');
end

% Calculamos n y lo mostramos
n = p * q;
fprintf('\nEl valor de n es n = p * q = %d\n',n);

% Calculamos phi
phi = (p-1) * (q-1);

% Elegimos el valor de e
fprintf(['\nEl valor de e de la clave pública debe satisfacer tanto que e < phi(n) como que MCD(e, phi(n)) = 1. O, ' ...
    'equivalentemente, que MCD(e, p-1) = MCD(e, q-1) = 1.\n']);

% Si tanto p como q son muy grandes escogeremos e = 1 + 2^2^4 = 65537. Sino
% dejaremos elegirlo al usuario
if p > 1000 && q > 1000
    e = 65537;
else
    e = input('\nIntroduzca un valor de e válido de acuerdo a la condiciones mencionadas: ');
    while gcd(e, phi) ~= 1 || e >= phi
        fprintf('El valor de e no es válido. Recuerda que e < phi(n) y MCD(e, phi(n) = 1.\n');
        e = input('Por favor, introduce de nuevo el valor de e: ');
    end
end

fprintf('\nHa sido elegido e = %d\n',e);

% Calculamos d
[g c] = gcd(e, phi);
d = mod(c, phi);
fprintf('\nd es el inverso de e módulo phi(n). Por lo tanto: d = %d\n', d);

% Imprimimos ambas claves
fprintf('\nCLAVE PÚBLICA (n, e) = (%d, %d)\n',n,e);
fprintf('\nCLAVE PRIVADA (n, d) = (%d, %d)\n',n,d);