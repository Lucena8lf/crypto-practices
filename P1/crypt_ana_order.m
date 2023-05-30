function [freq, freq_order]=crypt_ana_order(v)
%Función que obtiene las frecuencias de cada letra de un criptograma
%
%Entrada: el criptograma. Se introducirá como un array de caracteres, es decir, entre comillas
%simples.
%Salidas:
%freq: una matriz 27 × 2, cuya primera columna consiste en las frecuencias con las que aparece
%cada elemento de nuestro alfabeto en el criptograma y en la segunda se tienen los números de
%las letras correspondientes a esas frecuencias, ordenados según el orden usual de los caracteres
%en el alfabeto.
%freq order: la matriz 27 × 2 obtenida al ordenar de mayor a menor la primera columna de la
%matriz frecuencia.

if( ~ischar(v) )
    error("Debes introducir un texto!")
end

freq = zeros(27,2);
freq_order = zeros(27,2);
textLength = length(v);
abecedario = ['a':'n' abs('ñ') 'o':'z'];

format("shortG")

%num_rows = size(freq,1)
%num_columns = size(freq, 2)

distinctLetters = unique(v); % Te las ordena por orden alfabetico
distinctLettersLength = length(distinctLetters);
numberOccurrences = zeros(1,distinctLettersLength);


% Primero transformamos todo el texto a minusculas para evitar errores
v = lower(v);

% Contamos las ocurrencias y las almacenamos en un vector
for i=1:distinctLettersLength
    for j=1:textLength
        if( v(j) == distinctLetters(i) )
            numberOccurrences(i) = numberOccurrences(i) + 1;
        end
    end
end


% Ahora rellenamos la matriz de frecuencias en orden.
% No hace falta recorrerla entera con dos bucles ya que la conocemos y solo
% tiene dos columnas
cont = 1;
for i=1:size(freq, 1) % Rellenamos la matriz freq (Desde 1 hasta 27)
    if(i <= distinctLettersLength)
        for j=1:length(abecedario) % Recorremos el abecedario para conseguir el numero de la letra
            if(distinctLetters(i) == abecedario(j))
                freq(j,1) = numberOccurrences(cont) / textLength;  % Frecuencia con la que aparece en el texto
                cont = cont + 1;
            end
        end
    end

    freq(i,2) = i - 1; % Numero de la letra del alfabeto
end


% Ordenamos la segunda matriz de mayor a menor por la primera columna
freq_order = sortrows(freq, 'descend');
