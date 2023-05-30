function double = letter_2numbers (text)
%Función que asocia a cada letra su correspondiente valor de Z27 usando
%siempre dos dígitos por cada letra.
%
%Entrada: una cadena de texto usando el alfabeto español.
%Salida: una cadena numérica formada por los números asociados a cada letra del texto.

% Primero comprobamos que lo introducido sea un string (texto)
if( ~ischar(text) ) % True -> 1 | False -> 0
    error("Debes introducir un texto!")
end

abecedario = ['a':'n' abs('ñ') 'o':'z'];

text=lower(text); % Pasamos el texto a minusculas para evitar problemas
textLength=length(text);
abecedarioLength=length(abecedario);
double = '';
for i=1:textLength
    if (abs(text(i)) ~= 241) && (abs(text(i)) > 224) && (abs(text(i)) < 251) % Intervalo de las letras con acentos excluyendo la 'ñ'
        text(i) = convert_accents(text(i));
    end
    for j=1:abecedarioLength
        if text(i)==abecedario(j)
            j = j - 1;
            % Convertimos el digito en cadena
            j = num2str(j);
            % Comprobamos si solo tiene un digito
            if length(j) == 1
                j = strcat('0', j);
            end
            double = strcat(double, j);
            break
        end
    end
end
