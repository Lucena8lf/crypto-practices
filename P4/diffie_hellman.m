%Programa en el que se implementa el protocolo de Diffie y Hellman para el
%intercambio de claves. Para ello:
% - Se deben pedir los elementos comunes g y p y comprobar que sean válidos.
% - El agente A escoge un número entre 2 y p − 2 (podría ser de forma aleatoria) y envía a
%   la potencia correspondiente.
% - El agente B realiza el procedimiento análogo.
% - Tanto A como B obtienen la clave compartida

% Pedimos los elementos comunes
fprintf('\nELEMENTOS COMUNES\n');
p = input('Introduce un número primo: ');

while ~isprime(p)
    fprintf(['El grupo multiplicativo debe ser determinado por un número primo. Por favor,' ...
        ' vuelve a introducir un número primo válido.\n']);
    p = input('Introduce un número primo: ');
end

msg = 'Introduce un generador del grupo multiplicativo determinado por ';
msg = [msg num2str(p) ': '];
g = input(msg);

while g < 1 || g ~= round(g)
    fprintf(['El candidato a generador debe ser un número natural. Por favor, ' ...
        ' vuelve a introducir un generador válido.\n']);
    g = input(msg);
end

% AGENTE A
fprintf('\nAGENTE A\n');
fprintf('A debe introducir un número natural entre 2 y %d: ', p-2);
a = input('');
while a<2 || a>p-2
    fprintf(['El número introducido debe estar comprendido entre 2 y %d. Por favor,' ...
        ' vuelva a introducir el número: '], p-2);
    a = input('');
end

aMsg = power_mod(g,a,p);

fprintf('A envía a B power_mod(%d,%d,%d) = %d\n',g,a,p,aMsg);


% AGENTE B
fprintf('\nAGENTE B\n');
fprintf('B debe introducir un número natural entre 2 y %d: ', p-2);
b = input('');
while b<2 || b>p-2
    fprintf(['El número introducido debe estar comprendido entre 2 y %d. Por favor,' ...
        ' vuelva a introducir el número: '], p-2);
    b = input('');
end

bMsg = power_mod(g,b,p);

fprintf('B envía a A power_mod(%d,%d,%d) = %d\n',g,b,p,bMsg);


% AMBOS AGENTES
fprintf('\nAMBOS AGENTES\n');
auxA = power_mod(g,b,p);
aRec = power_mod(auxA,a,p);
fprintf('A obtiene power_mod(%d,%d,%d) = %d\n',auxA,a,p,aRec);

auxB = power_mod(g,a,p);
bRec = power_mod(auxB,b,p);
fprintf('B obtiene power_mod(%d,%d,%d) = %d\n',auxB,b,p,bRec);