function matrix=crypto_hill(text,code,d)
%Función que halla, si es posible, la matriz clave empleada para el cifrado
%hill conociendo parte del texto llano, del criptograma y el orden de la matriz. El criptoanálisis
%se realiza con un ataque de tipo Gauss-Jordan.
%
%Entradas:
%text: el fragmento inicial del texto llano, de longitud al menos d^2.
%code: el fragmento inicial del criptograma, de longitud al menos d^2.
%d: el tamaño de los bloques, es decir, el orden de la matriz que estamos suponiendo para el cifrado Hill
%Salida: la matriz clave del cifrado, si es posible obtenerla

Xmatrix = [];
Ymatrix = [];
noInverse = [0 3 6 9 12 15 18 21 24]; % Numeros que no tienen inverso en Z27

% Comprobaciones previas
% Comprobamos si tanto el texto llano como el criptograma tiene una
% longitud de al menos d^2
if length(text) < d^2
    error('El texto introducido es demasiado corto, su longitud debe ser de al menos d^2 ');
end

if length(code) < d^2
    error('El criptograma introducido es demasiado corto, su longitud debe ser de al menos d^2 ');
end

% Para criptoanalizar debemos plantear el sistema Y* = X* M^t
% 1. Transformamos en numeros y separamos por bloques ambos textos
% obteniendo asi Y* y X*
plainNumbers = letter_number(text);
codeNumbers = letter_number(code);

% Si la longitud del texto o del criptograma no es multiplo de d reducimos tanto el texto
% como el criptograma al mismo numero de caracteres hasta que sea multiplo
if rem(length(plainNumbers),d) ~= 0
    newLength = length(plainNumbers);
    while rem(newLength,d) ~= 0
        newLength = newLength - 1;
    end
    % Una vez sabemos la longitud recortamos tanto el texto como el
    % criptograma
    plainNumbers = plainNumbers(1:newLength);
    codeNumbers = codeNumbers(1:newLength);

elseif rem(length(codeNumbers),d) ~= 0
    newLength = length(codeNumbers);
    while rem(newLength,d) ~= 0
        newLength = newLength - 1;
    end
    % Una vez sabemos la longitud recortamos tanto el texto como el
    % criptograma
    codeNumbers = codeNumbers(1:newLength);
    plainNumbers = plainNumbers(1:newLength);
end

% Primero obtenemos X*
cont = 1;
while cont < length(plainNumbers)
    X = zeros(1,d);
    for c=1:d
        X(1,c) = plainNumbers(cont);
        cont = cont + 1;
    end

    Xmatrix = [Xmatrix; X];
end

% Obtenemos Y*
cont = 1;
while cont < length(codeNumbers)
    Y = zeros(1,d);
    for c=1:d
        Y(1,c) = codeNumbers(cont);
        cont = cont + 1;
    end

    Ymatrix = [Ymatrix; Y];
end

% 2. Ahora transformamos X* por Gauss-Jordan hasta obtener en la parte superior la
%    matriz identidad
% Todos los pasos que hacemos en X* recordar que debemos hacerlos en Y*
% para hallar M^t
[n m] = size(Xmatrix);

j = 1;
for k = 1:n
    if k <= m
        if Xmatrix(k,k) ~= 1 % Si el elemento i,i de la diagonal es diferente de 1 lo convertimos en 1
            % Lo primero de todo antes de realizar operaciones es comprobar
            % si tiene inverso
            % Calculamos el inverso del elemento de la diagonal (si tiene)
            if ismember(round(Xmatrix(k,k)),noInverse) == 0 % Si tiene inverso
                [G C] = gcd(round(Xmatrix(k,k)),27);
                multInverse = mod(C,27);
            else % No tiene inverso
                for z = k:n
                    if ismember(round(Xmatrix(z,k)),noInverse) == 0
                        aux = Xmatrix(z,:);
                        Xmatrix(z,:) = Xmatrix(k,:);
                        Xmatrix(k,:) = aux;

                        aux = Ymatrix(z,:);
                        Ymatrix(z,:) = Ymatrix(k,:);
                        Ymatrix(k,:) = aux;
                        break;
                    end
                end
                [G C] = gcd(round(Xmatrix(k,k)),27);
                multInverse = mod(C,27);
            end

            
            Xmatrix(k,:) = mod(Xmatrix(k,:).*multInverse,27);
            Ymatrix(k,:) = mod(Ymatrix(k,:).*multInverse,27);
        end
        
        % Ahora hacemos 0 por debajo y por encima de la diagonal
        for i = 1:n
            if i ~= k
                if Xmatrix(i,k) ~= 0 % Solo transformamos cuando ese elemento no sea 0
                    factor = mod(Xmatrix(i,k)/Xmatrix(k,k),27);
                    Xmatrix(i,:) = mod(Xmatrix(i,:) - factor*Xmatrix(k,:),27);
                    Ymatrix(i,:) = mod(Ymatrix(i,:) - factor*Ymatrix(k,:),27);
                else
                    continue % Si es 0 no hacemos nada
                end
            end
        end
    end
end

% Comprobamos si se ha podido obtener la matriz identidad
for i=1:n
    if m >= n
        if Xmatrix(i,i) ~= 1
            error('No se ha obtenido la matriz identidad. Es necesario mas texto para realizar el criptoanalisis');
        end
    end
end
        

matrix = Ymatrix.'; % Recordamos que hemos obtenido M^t
matrix = matrix(1:d,1:d); % M sera de orden d
