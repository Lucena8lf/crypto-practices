function s = crypt_shamir_zippel (publ_k,mu)
%Función que realiza el criptoanálisis de Shamir y Zippel. La función
%debe indicar el rango en el que está buscando el posible primer elemento de la mochila
%supercreciente.
%
%Entradas:
%publ_k: la clave pública, es decir, la mochila trampa.
%mu: el módulo de trabajo, que en este criptoanálisis se considera conocido.
%Salida: la mochila supercreciente asociada al cifrado.

possibleS = [];
s = [];
res = 'S';

% 1. Primero hallamos el inverso de b2 mod mu, siendo b2 el segundo elemento de la
%    clave pública
[G D] = gcd(publ_k(2),mu);
inverB2 = mod(D,mu);


% 2. Una vez obtenemos el inverso calculamos q = b1 * b2^ −1 mod mu
q = mod(publ_k(1) * inverB2, mu);

% 3. Calculamos los primeros 2^n+1 multiplos modulares de q. Esto
% dependera de n que es el numero de elementos de la clave publica
n = length(publ_k);
cont = 1;
% Datos iniciales del rango
nMults = 2^(n+1);
range = [1 nMults];
while upper(res) == 'S'
    tic % Iniciamos el contador

    if cont ~= 1 % Nos saltamos la situacion inicial
        nMults = cont*2^(n+1);
        range = [range(2)+1, nMults];
    end
    fprintf('Buscando multiplos en el rango [%d, %d]\n',range(1),range(2));
    multQ = []; % Lo vaciamos para introducir los nuevos valores
    for i=range(1):range(2)
        iMult = mod(i * q, mu);
        multQ = [multQ iMult];
    end

    for i=1:n
        % 4. El candidato para a1 sera el valor mas pequeño de la lista anterior
        % Recorremos toda la lista probando el posible a1
        if i > 1 % Borramos de la lista el elemento que ya hemos cogido
            multQ = multQ(multQ~=a1);
        end
        a1 = min(multQ);
        
        % 5. Calculamos w = b1 ∗ a1^−1 mod m
        [G D] = gcd(a1,mu);
        inverA1 = mod(D,mu);
        w = mod(publ_k(1) * inverA1, mu);
        
        % 6. Calculamos w^−1 como el inverso de w mod m y calculamos los elementos
        %    ai = w^−1 bi mod m
        [G D] = gcd(w,mu);
        inverW = mod(D,mu);
        
        possibleS = [a1];
        for i=2:n
            ai = mod(inverW * publ_k(i), mu);
            possibleS = [possibleS ai];
        end
        
        % Comprobamos si la mochila encontrada es supercreciente
        valide = knapsack(possibleS);
        if valide == 1
            break
        end
    end
    if valide == 1 % La hemos encontrado
        toc
        fprintf('\nSe ha encontrado una mochila supercreciente:\n');
        res = 'N';
        s = possibleS;
    else
        toc
        fprintf('\n');
        res = input('No ha sido posible encontrar una mochila supercreciente. ¿Deseas continuar con un intervalo mayor? [S/N]: ','s');
        if upper(res) == 'S'
            cont = cont + 1;
        end
        fprintf('\n\n');
    end
    
end
