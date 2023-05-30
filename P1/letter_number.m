function v=letter_number(text)
%Función que transformará el texto en números
%
%Entrada: texto escrito como si fuera una cadena de caracteres (puede contemplar minúsculas,
%mayúsculas, tildes, signos de puntuación etc.).
%Salida: vector numérico asociado al texto, una vez convertidas todas las letras en minúsculas
%y eliminados todos los símbolos que no estén en nuestro alfabeto.


% Primero comprobamos que lo introducido sea un string (texto)
if( ~ischar(text) ) % True -> 1 | False -> 0
    error("Debes introducir un texto!")
end

% abecedario='a':'n';
% concat la ñ y poner la parte que queda
abecedario = ['a':'n' abs('ñ') 'o':'z'];

% Otra forma:
%abecedario='abcdefghijklmnnopqrstuwxyz';
%abs('ñ'); % Calculamos el codigo ASCII de la ñ para cambiarlo luego en nuestro array
%abecedario(15) = abs('ñ');


text=lower(text); % Pasamos el texto a minusculas para evitar problemas
textLength=length(text);
abecedarioLength=length(abecedario);
v=[];
for i=1:textLength
    if (abs(text(i)) ~= 241) && (abs(text(i)) > 224) && (abs(text(i)) < 251) % Intervalo de las letras con acentos excluyendo la 'ñ'
        text(i) = convert_accents(text(i));
    end
    for j=1:abecedarioLength
        if text(i)==abecedario(j)
            v=[v j-1]; % La j como es un número es la que va completando el array
            break
        end
    end
end
