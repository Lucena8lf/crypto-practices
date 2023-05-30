function code=affine(k,d,text)
%Función que cifra el mensaje por el método afín
%
%Entradas:
%k: la clave multiplicativa. El programa debe comprobar que es un número de Z27 y que
%mcd(k, 27) = 1.
%d: el desplazamiento. También debe ser un número de Z27.
%text: el texto claro que se quiere encriptar.
%Salida: el criptograma.


% Comprobamos que k y d sea un numero de Z27
z27 = [0:26];
convertedNumbers = [];
abecedario = ['a':'n' abs('ñ') 'o':'z'];
code = [];

if( ismember(k, z27) == 0 || ismember(d, z27) == 0)
    error("k y d deben ser un numero en Z27!")
end

if( gcd(k,27)~=1 ) % Comprobamos si son co-primos
    error("El MCD de k y 27 debe ser 1 para poder realizar el cifrado!")
end

% Una vez todos los parametros son correctos, comenzamos el cifrado
% 1. Transformamos el texto en numeros de Z27
originalNumbers = letter_number(text);

% 2. Ciframos mediante x → k x + d mod 27. Cambiaremos cada letra del
% array que tenemos
for i=1:length(originalNumbers)
    newValue = k * originalNumbers(i) + d;
    % Calculamos el valor en modulo 27
    newValue = mod(newValue, 27);
    convertedNumbers = [convertedNumbers newValue];
end

% 3. Volvemos a asignar letras

for i=1:length(convertedNumbers)
    for j=1:length(z27)
        if convertedNumbers(i)==z27(j)
            code=[code abecedario(j)];
            break
        end
    end
end