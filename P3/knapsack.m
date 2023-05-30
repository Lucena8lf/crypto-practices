function valide=knapsack(s)
%Función de control que analiza si un vector fila es una mochila simple o
%supercreciente.
%
%Entrada: un vector fila.
%Salida:
%valide = −1 si la entrada introducida no representa una mochila.
%valide = 0 si la entrada representa una mochila, pero no es supercreciente.
%valide = 1 si la entrada representa una mochila supercreciente.

% Primero comprobamos que sea una mochila
% Para que sea una mochila debe ser un vector fila de numeros naturales
[n m] = size(s);
if n ~= 1
    valide = -1;
    return
end

% Comprobamos si es supercreciente a la vez que si tiene numeros naturales
sum = 0;
for i=1:m
    if s(i) ~= round(s(i)) || s(i) < 0
        valide = -1;
        return
    end

    if s(i) < sum
        valide = 0;
        return
    end

    sum = sum + s(i);

end

valide = 1;