function code = hill_cipher(A,text)
%Función que cifra un texto a partir de una matriz A mediante el cifrado
%Hill.
%
%Entradas:
%   A: la matriz que va a ser la clave.
%   text: el texto claro.
%Salida: el criptograma.

z27 = [0:26];
convertedNumbers = [];
matrixNumbers = [];
abecedario = ['a':'n' abs('ñ') 'o':'z'];
code = [];

% Comprobaciones previas

% Comprobamos que A sea cuadrada
[n m]=size(A);
if n ~= m 
error('La matriz debe ser cuadrada')
end

d = n;

% Comprobamos que A tiene inversa en Z27
try
    inver = inv_module(A,27);
catch
    error('La matriz pasada no tiene inversa en Z27');
end



% 1. Transformamos el texto llano en numeros
originalNumbers = letter_number(text);

% Si la longitud del texto no es multiplo de d rellenamos con 'w' el texto
% hasta que lo sea
while rem(length(originalNumbers),d) ~= 0
    originalNumbers(end + 1) = 23;
end

% 2. Dividimos los numeros del texto llano en bloques de longitud d y
% rellenamos la matriz

cont = 1;
while cont < length(originalNumbers)
    X = zeros(d,1);
    for c=1:d
        X(c,1) = originalNumbers(cont);
        cont = cont + 1;
    end

    % 3. Ciframos aplicando la transformacion: code = A * Xi
    res = mod(A * X, 27);
    matrixNumbers = [matrixNumbers res];

end

[f c] = size(matrixNumbers);

% Para trabajar mas comodos lo pasamos a un vector
for i=1:c
    for j=1:f
        convertedNumbers = [convertedNumbers matrixNumbers(j,i)];
    end
end

% 4. Volvemos a asignar letras


for i=1:length(convertedNumbers)
    for j=1:length(z27)
        if convertedNumbers(i)==z27(j)
            code=[code abecedario(j)];
            break
        end
    end
end
