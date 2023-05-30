function v = rsa_num_cipher(n, e, blocks)
%Función que realiza el mismo procedimiento que la anterior, salvo que en
%vez de partir de un texto comienza con los bloques de números.
%
%Entradas:
%n y e: los valores de la clave pública para el cifrado RSA.
%blocks: un vector numérico.
%Salida: el vector formado por los bloques ya cifrados a partir de las entradas

% Al recibir de la entrada ya los bloques, solo debemos cifrar cada uno
v = zeros(1,length(blocks));
for i=1:length(blocks)
    v(i) = power_mod(blocks(i), e, n);
end