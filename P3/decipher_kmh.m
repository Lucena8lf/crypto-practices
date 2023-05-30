function text = decipher_kmh (s,code,mu,invw)
%Función que permite al usuario (el receptor) descifrar un mensaje cifrado
%con su clave pública.
%
%Entradas:
%s: una mochila supercreciente.
%code: el criptograma recibido.
%mu y invw: los elementos de la clave privada, obtenidos a partir de la función anterior.
%Salida: el texto claro.

multCode = [];
binaryNumbers = [];
text = [];

% Comprobamos que la mochila sea supercreciente
valide = knapsack(s);

if valide == -1 || valide == 0
    error('La mochila debe ser supercreciente');
end

% 1. Para descifrar primero multiplicamos el texto cifrado por invw
for i=1:length(code)
    newValue = mod(invw * code(i), mu);
    multCode = [multCode newValue];
end

% 2. Resolvemos para cada uno de estos valores el problema de la
% mochila supercreciente
for i=1:length(multCode)
    value = [];

    [v ~] = knapsack_sol(s,multCode(i));
    binaryNumbers = [binaryNumbers v];
end

binaryNumbers = dec2bin(binaryNumbers);

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