function [factor_c,fact] = common_factors (w,s)
%Función que comprueba si un número w tiene factores primos comunes
%con los elementos de la mochila s.
%
%Entradas:
%w: un número natural.
%s: una mochila (aunque para el cifrado deberá ser supercreciente, para implementar esta
%función no debe serlo necesariamente y no se comprobará).
%Salidas:
%factor c: una salida de control de tipo lógica. Vale 0 si no hay factores comunes y 1 si los
%hay.
%fact: un vector con los números de la mochila que tienen factores comunes con w


factor_c = 0;
fact = [];
% Comprobamos que es realmente una mochila
valide = knapsack(s);

if valide == -1
    error('Para cifrar el mensaje se debe introducir una mochila valida');
end

f = factor(w); % Nos devuelve un vector con el numero descompuesto en numeros primos

% Si se puede descomponer en primos comprobamos si algun numero de ellos
% esta en la mochila o compone a algun elemento de la mochila
for i=1:length(s)
    siFactor = factor(s(i)); % Descomponemos en primos el elemento de la mochila
    contain = ismember(siFactor,f);
    if ismember(1,contain) % Significa que ese elemento de la mochila coincide con alguno de los primos de w
        fact = [fact s(i)];
        factor_c = 1;
    end
end