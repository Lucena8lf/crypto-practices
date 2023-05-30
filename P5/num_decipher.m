function text = num_decipher (n, blocks)
%Función que transforma un vector numérico en letras (usando dos dígitos
%por letra). Para ello debe completar los bloques con 0's a la izquierda para que todos tengan
%lontigud dígitos(n) − 1, concatenarlos, agruparlos de dos en dos, eliminar los posibles 30's y/o
%0 que puedan haber al final y pasar a letras.
%
%Entradas:
%n: un número natural, necesario para determinar la longitud correcta de los bloques.
%blocks: un vector numérico.
%Salida: una cadena de texto

z27 = [0:26];
z27_2 = strings([1,26]);
abecedario = ['a':'n' abs('ñ') 'o':'z'];
text = [];

% Hacemos dobles los número de nuestro z27
for i=1:26
    aux = num2str(z27(i));
    if i < 10
        aux = strcat(num2str(0), aux);
    end
    z27_2(i) = aux;
end

% Todos los bloques deberán tener una longitud dígitos(n) - 1. Por lo que
% lo comprobamos
new_blocks = [];
for i = 1:length(blocks)
    ni_letra = num2str(blocks(i));
    while length(ni_letra) ~= numel(num2str(n)) - 1
        ni_letra = strcat(num2str(0), ni_letra);
    end
    new_blocks = [new_blocks ni_letra];
end

% Ya los tenemos concatenados, por lo que los agrupamos de dos en dos
blocks2 = reshape(new_blocks, 2, []).';

% Eliminamos los posibles 30's o 0's al final
%while blocks2(end,:) == '30' | blocks2(end, :) == '00'
    %blocks2(end, :) = [];
%end

% Transformamos en letras
for i=1:length(blocks2)
    for j=1:length(z27_2)
        if blocks2(i,:)==z27_2(j)
            text=[text abecedario(j)];
            break
        end
    end
end