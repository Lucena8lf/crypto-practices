function code = knapsack_cipher (s,text)
%Función que cifra un mensaje a partir de una mochila (no necesariamente
%supercreciente).
%
%Entradas:
%s: la mochila que será nuestra clave. La función debe comprobar que es realmente una
%mochila (no necesariamente supercreciente).
%text: el texto a cifrar.
%Salida: el vector numérico que se corresponde con el mensaje cifrado.

% Antes de comenzar el proceso de cifrado comprobamos que es realmente una mochila
valide = knapsack(s);

if valide == -1
    error('Para cifrar el mensaje se debe introducir una mochila valida');
end

binaryNumbers = [];
code = [];

% 1. Convertimos el texto llano a 8 bits mediante ASCII
asciiText = abs(text);
for i=1:length(asciiText)
    binaryNumbers = [ binaryNumbers dec2bin(asciiText(i),8)];
end

% 2. Reagrupamos en bloques de 5 dígitos, añadiendo 1s si es necesario
% Primero añadimos los 1s para que la longitud sea multiplo de 5
while rem(length(binaryNumbers),5) ~= 0
    binaryNumbers(end + 1) = dec2bin(1);
end

% Agrupamos en bloque de 5 digitos
binary5Groups = reshape(binaryNumbers, 1, 5, []);

% 3. Sustituimos en la mochila cada bloque
for i=1:length(binary5Groups)
    value = 0;

    group = binary5Groups(:,:,i);
    for j=1:5 % Comprobamos en cada bloque cuales son 1 para sumar esos valores de la mochila
        if group(j) == dec2bin(1)
            value = value + s(j);
        end
    end
    
    code = [code value];

end

