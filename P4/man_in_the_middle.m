%Programa que muestra la vulnerabilidad del protocolo de Diffie y Hellman
%para el intercambio de claves. Para ello:
% - Se deben pedir los elementos comunes g y p y comprobar que sean válidos.
% - Tanto el agente A como el B escogen sus números privados entre 2 y p − 2 (podría ser
%   de forma aleatoria) y calculan las potencias respectivas, que las interceptará el espía C.
% - El espía C escoge su número entre 2 y p−2 (podría ser de forma aleatoria) e interactúa
%   con A y con B suplantando la identidad de estos.
% - A y C deben obtener una clave común.
% - B y C deben obtener otra clave común.

% Primero pedimos los elementos comunes
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
fprintf('Este número es interceptado por C.\n');

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
fprintf('Este número es interceptado por C.\n');

% AGENTE C
fprintf('\nAGENTE C\n');
fprintf('C intercepta %d de A y %d de B y guarda esos números\n', aMsg, bMsg);
fprintf('C debe introducir un número natural entre 2 y %d: ', p-2);
c = input('');
while c<2 || c>p-2
    fprintf(['El número introducido debe estar comprendido entre 2 y %d. Por favor,' ...
        ' vuelva a introducir el número: '], p-2);
    c = input('');
end

cMsg = power_mod(g,c,p);

fprintf('C envía a A y a B power_mod(%d,%d,%d) = %d\n',g,c,p,cMsg);

fprintf('\nB piensa que ha recibido ese número de A y A de B\n');

% AGENTE A y B
fprintf('\nAGENTES A y B\n');
aRec = power_mod(cMsg,a,p);
fprintf('A obtiene power_mod(%d,%d,%d) = %d\n',cMsg,a,p,aRec);

bRec = power_mod(cMsg,b,p);
fprintf('B obtiene power_mod(%d,%d,%d) = %d\n',cMsg,b,p,bRec);

% AGENTE C
fprintf('\nAGENTE C\n');
cCalculationA = power_mod(aMsg, c, p);
fprintf('Para A calcula power_mod(%d,%d,%d) = %d\n', aMsg, c, p, cCalculationA);
cCalculationB = power_mod(bMsg, c, p);
fprintf('Para B calcula power_mod(%d,%d,%d) = %d\n', bMsg, c, p, cCalculationB);