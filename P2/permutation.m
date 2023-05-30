function permute=permutation(p)
%Función que comprueba si el vector de entrada representa una permutación
%de {1, 2, ..., n}, siendo n el número de elementos del vector.
%
%Entrada: el vector que queremos comprobar si es o no una permutación.
%Salida:
%permute= 0 si el vector no es una permutación.
%permute= 1 si el vector es una permutación.


% Obtenemos el tamaño del vector
n = length(p);
permute = 1;

% Recorremos el vector comprobando si se encuentra cada valor
for i=1:n
    if ismember(i,p) == 0
        permute = 0;
        break
    end
end