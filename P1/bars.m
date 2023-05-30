function compare=bars(v)
%Función que compara las frecuencias del criptograma con las frecuencias
%de las letras en castellano, mostrando la comparación de dos formas: mediante una matriz de
%datos y mediante un diagrama de barras.
%
%Entrada: el criptograma.
%Salida: una matriz 27 × 4 donde las columnas 1 y 3 son las frecuencias ordenadas de mayor
%a menor en castellano y en nuestro criptograma.
%Adicionalmente deben mostrarse dos diagramas de barras: el primero indicando las frecuencias de las letras en castellano y el segundo las frecuencias de cada letra en el criptograma.


if( ~ischar(v) )
    error("Debes introducir un texto!")
end

% Creamos matriz -> A=[fila1; fila2; ...; filaN]
spanish_frequencies = [0.1253 0; 0.0142 1; 0.0468 2; 0.0586 3; 0.1368 4; 0.0069 5; 0.0101 6; 0.0070 7; 0.0625 8; 0.0044 9; 0.0002 10; 0.0497 11; 0.0315 12; 0.0671 13; 0.0031 14; 0.0868 15; 0.0251 16; 0.0088 17; 0.0687 18; 0.0798 19; 0.0463 20; 0.0393 21; 0.0090 22; 0.0001 23; 0.0022 24; 0.0090 25; 0.0052 26];
compare = sortrows(spanish_frequencies,'descend');

% Llamamos a cryp_ana_order() para obtener las frecuencias del criptograma
% que nos han pasado
[freq, freq_order]=crypt_ana_order(v);

compare = [compare freq_order];

figure
% Primera grafica
subplot(2,1,1)
bar(spanish_frequencies(:,1),'r')
title('spanish frequencies');

% Segunda grafica
subplot(2,1,2)
bar(freq(:,1),'b')
title('code frequencies');