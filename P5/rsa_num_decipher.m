function v = rsa_num_decipher (n, d, code)
%Función que descifra un vector numérico, usando el sistema RSA a partir
%de la clave privada proporcionada, y devuelve un vector numérico (el paso previo a convertir
%los dígitos en caracteres).
%
%Entradas:
%n y d: los valores de la clave privada para el descifrado RSA.
%code: un vector numérico, que se supone cifrado según el sistema RSA.
%Salida: el vector numérico obtenido tras aplicar el descifrado con RSA.

% Para recuperar los bloques originales a cada bloque Ci
% le aplicamos la transformación Mi = Ci^d mod n
v = zeros(1,length(code));
for i=1:length(code)
    v(i) = power_mod(code(i), d, n);
end
