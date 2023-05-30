function affine_cryptanalysis(v)
%Función que realiza el criptoanálisis de un mensaje cifrado por el método
%afín, desconociendo las claves empleadas
%
%Entrada: el criptograma.
%Salida: se espera una salida interactiva.
%La función compara las máximas frecuencias, hace un intento de descrifrar el mensaje,
%nos lo muestra y nos pregunta si queremos probar con otras claves.
%Si la respuesta es afirmativa pasa a comparar otras dos frecuencias y nos muestra otro
%posible texto claro etc. En el momento en que la respuesta sea negativa debe mostrar el texto
%claro y el valor correcto de las claves.

% 1. Primero debemos encontrar las posibles parejas. Para ello comparamos
% las maximas frecuencias del criptograma con las del alfabeto español

spanish_frequencies = [0.1253 0; 0.0142 1; 0.0468 2; 0.0586 3; 0.1368 4; 0.0069 5; 0.0101 6; 0.0070 7; 0.0625 8; 0.0044 9; 0.0002 10; 0.0497 11; 0.0315 12; 0.0671 13; 0.0031 14; 0.0868 15; 0.0251 16; 0.0088 17; 0.0687 18; 0.0798 19; 0.0463 20; 0.0393 21; 0.0090 22; 0.0001 23; 0.0022 24; 0.0090 25; 0.0052 26];
compare = sortrows(spanish_frequencies,'descend');

% Llamamos a cryp_ana_order() para obtener las frecuencias del criptograma
% que nos han pasado
[freq, freq_order]=crypt_ana_order(v);

compare = [compare freq_order];

res = 1;
cont = 1;
while res == 1

    % La matriz 'compare' tiene ordenadas de mayor a menos las frecuencias,
    % por lo que las parejas seran la columna 2 con la columna 4, que son los
    % numeros correspondientes a las letras en el alfabeto
    
    if rem(cont,2)==0 % Si probamos por segunda vez, intercambiamos las letras del criptograma
        y1 = compare(cont, 4);
        y2 = compare(cont - 1, 4);
        x1 = compare(1,2);
        x2 = compare(2,2);
    else
        x1 = compare(1,2); % x -> Letra del alfabeto
        y1 = compare(cont,4); % y -> Letra del criptograma
        x2 = compare(2,2);
        y2 = compare(cont + 1,4);
    end

    
    % 2. Realizamos un sistema para hallar los posibles valores de 'k' y 'd'
    matX = [x1 1; x2 1];
    matY = [y1;y2];
    
    % Calculamos la inversa modular de 'matX'
    try
        inverseMatX = inv_module(matX,27);
    catch
        fprintf('\n...\n\n');
        cont = cont + 1;
        continue;
    end
    
    % Resolvemos
    KD = inverseMatX * matY;
    KD = mod(KD,27);
    k = round(KD(1,1));
    d = round(KD(2,1));
    
    % 3. Desciframos el mensaje con los valores obtenidos
    try
        text = dec_affine(k,d,v);
    catch
        fprintf('\n...\n\n');
        cont = cont + 1;
        continue;
    end

    fprintf('k = %d\nd = %d\n\ntext = %s\n',k,d,text);
    res = input('\nSi deseas probar con unas claves diferentes escribe 1, para terminar escribe 0: ');

    cont = cont + 1;
end
