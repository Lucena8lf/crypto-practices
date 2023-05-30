function concatenated_blocks = complete_blocks(n, blocks)
%Función que completa los bloques para que tengan la longitud de n.
%
%Entradas:
%n: valor de la clave privada necesario para conocer la longitud deseada.
%blocks: un vector numérico.
%Salida: bloques de longitud n concatenados
concatenated_blocks = [];
for i = 1:length(blocks)
    ni_letra = num2str(blocks(i));
    while length(ni_letra) ~= numel(num2str(n)) - 1
        ni_letra = strcat(num2str(0), ni_letra);
    end
    concatenated_blocks = [concatenated_blocks ni_letra];
end

% Quitamos al final 30's o 0's si lo hubiera
while (concatenated_blocks(end) == '0' && concatenated_blocks(end-1) == '3') | concatenated_blocks(end) == '0'
    if concatenated_blocks(end) == '0' && concatenated_blocks(end-1) == '3'
        concatenated_blocks = concatenated_blocks([1:end-2]);
    else
        concatenated_blocks(end) = [];
    end
end