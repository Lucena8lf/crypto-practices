function text = rsa_decipher (n, d, code)
%Función que descifra un vector numérico, usando el sistema RSA a partir
%de la clave privada proporcionada, devolviendo el texto llano.
%
%Entradas:
%n y d: los valores de la clave privada para el descifrado RSA.
%code: un vector numérico, que se supone cifrado según el sistema RSA.
%Salida: el texto llano.

% Lo que se nos pide es realizar el descifrado completo teniendo un mensaje
% cifrado con RSA

% Teniendo las dos funciones anteriores es muy sencillo realizarlo
% Primero obtenemos los bloques originales
v = rsa_num_decipher(n, d, code);

% Estos bloques originales los convertimos en letras
text = num_decipher(n, v);