function matrix=matrix_per(p)
%Se trata de una función que comprueba si la entrada es una permutación, y en ese caso
%construye la matriz asociada a ella.
%
%Entrada: un vector, que supuestamente debe ser una permutación debiendo comprobando
%la función que lo es.
%Salida: la matriz asociada a la permutación en caso de que la entrada lo sea, o un mensaje
%de error en caso contrario.

permute=permutation(p);
if permute == 0
    error('El vector de entrada debe ser una permutación');
end

% Obtenemos longitud del vector para conocer el orden de la matriz
n = length(p);

matrix = zeros(n,n);

% Rellenamos la matrix de acuerdo con el vector pasado
for i=1:n
    position = p(i);
    matrix(i,position) = 1;
end