function text = decipher_knapsack_s (s,code)
%Función que descifra un criptograma conociendo la mochila supercreciente
%utilizada como clave.
%
%Entradas:
%s: la mochila usada como clave que debe ser supercreciente.
%code: el criptograma.
%Salida: el texto llano.

binaryNumbers = [];
text = [];

% 1. Antes de nada comprobamos que la mochila sea supercreciente
valide = knapsack(s);

if valide == -1 || valide == 0
    error('La mochila debe ser supercreciente');
end

% 2. Para cada valor de la clave (texto cifrado) hallamos los elementos de la mochila que
%    lo satisfacen:

% Nos ayudamos de la funcion knapsack_sol para obtener los valores de la
% mochila que permiten obtener cada numero
for i=1:length(code)
    value = [];

    [v ~] = knapsack_sol(s,code(i));
    binaryNumbers = [binaryNumbers v];
end

binaryNumbers = dec2bin(binaryNumbers); % Lo transformamos para evitar problemas con el tipo de datos luego

% 3. Agrupamos en bloques de 8 bits
% Antes hacemos que el vector sea multiplo de 8 eliminando por la derecha
% hasta que se cumpla
while rem(length(binaryNumbers),8) ~= 0
    binaryNumbers(end) = [];
end

binary8Groups = reshape(binaryNumbers, 1, 8, []);

[n m k] = size(binary8Groups);

% 4. Convertimos en caracteres según el código ASCII
for i=1:k
    group = binary8Groups(:,:,i);
    
    letra = char(bin2dec(group));
    
    text = [text letra];
end