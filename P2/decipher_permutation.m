function text=decipher_permutation(p,code)
%Función que descifra un criptograma conociendo la permutación utilizada
%como clave.
%
%Entradas:
%p: el vector que debe ser una permutación. La función debe comprobarlo.
%code: el criptograma.
%Salida: el texto llano.

z27 = [0:26];
convertedNumbers = [];
matrixNumbers = [];
abecedario = ['a':'n' abs('ñ') 'o':'z'];
text = [];

% Comprobamos que el vector sea una permutacion y obtenemos su matrix en
% caso afirmativo
matrix = matrix_per(p);

% Primero calculamos M^-1
inver = inv_module(matrix,27);

% 1. Transformamos el criptograma en numeros de Z27
originalNumbers = letter_number(code);

% 2. Dividimos los numeros del texto llano en bloques de longitud d y
% rellenamos la matriz

[n m]=size(inver);
d = n;

cont = 1;
while cont < length(originalNumbers)
    Y = zeros(d,1);
    for c=1:d
        Y(c,1) = originalNumbers(cont);
        cont = cont + 1;
    end

    % 3. Aplicamos la transformacion: X = M^-1 Y
    res = mod(inver * Y, 27);
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
            text=[text abecedario(j)];
            break
        end
    end
end