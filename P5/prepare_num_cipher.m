function v = prepare_num_cipher (d, double)
%Función que convierte una cadena numérica en bloques de un tamaño
%dado, convierte dichos bloques en números y los almacena en un vector.
%
%Entradas:
%d: un número natural que representa el tamaño de los bloques.
%double: una cadena numérica.
%Salida: el vector formado por los números que se corresponden con cada uno de los bloques.

blocks = [];

% Comprobamos si el tamaño de bloques que pide es multiplo de la longitud
% de la cadena numerica. Si no lo es, añadimos 30's y/o 0's
while rem(length(double),d) ~= 0
    % Si el siguiente es multiplo significa que solo necesitamos añadir un
    % 0
    if rem(length(double) + 1, d) == 0
        double = strcat(double,'0');
    else
        % Sino deberemos añadir un 30
        double = strcat(double, '30');
    end
end
    
% Calculamos el numero de bloques que habrá
nBlocks = length(double) / d;

% Hacemos la división
aux = reshape(double, d, []).';

% Transformamos cada fila en números
i=1:nBlocks;
blocks = [blocks str2num(aux(i,:))];

% Lo agrupamos todo en un solo vector de una fila
v = reshape(blocks,1,[]);