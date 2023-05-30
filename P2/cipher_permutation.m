function code=cipher_permutation(p,text)
%Función que cifra un texto a partir de una permutación aplicando el cifrado
%Hill en caso de ser posible. En otro caso muestra un mensaje de error.
%
%Entradas:
%p: el vector que debe ser una permutación. La función debe comprobarlo.
%text: el texto llano a cifrar.
%Salida: el criptograma usando Hill y la permutación, si es posible realizar el cifrado.

% Primeros comprobamos que p sea una permutacion al obtener su matriz
matrix = matrix_per(p);

% Aplicamos la transformacion: Y = MX, siendo M en nuestro programa
% 'matrix'

code = hill_cipher(matrix,text);