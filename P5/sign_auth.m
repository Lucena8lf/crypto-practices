%Programa que incluye todos los pasos necesarios para cifrar y descrifrar un
%mensaje mediante el método RSA con autentificación de firma.

% Primero pedimos las claves públicas y privadas al emisor y al receptor
% AGENTE A
fprintf('\nAGENTE A\n');
pb_A = input('Introduce la clave pública de A, (na, ea): ');
pr_A = input('Introduce la clave privada de A, (na, da): ');

% AGENTE B
fprintf('\nAGENTE B\n');
pb_B = input('Introduce la clave pública de B, (nb, eb): ');
pr_B = input('Introduce la clave privada de B, (nb, db): ');

% Ahora pedimos al emisor que introduzca el mensaje que quiere mandar y la
% firma
fprintf('\nAGENTE A\n');
text_A = input('Introduce el texto que desea enviar a B: ');
sig_A = input('Introduce tu firma: ');

% Una vez tenemos tanto el mensaje como la firma del emisor debemos tanto
% cifrar el mensaje y la firma juntos con la clave pública de B como hacer
% un doble cifrado a la firma
% 1. Ciframos el mensaje y la firma juntos con la clave pública de B
text_ciph = rsa_cipher(pb_B(1), pb_B(2), strcat(text_A, sig_A));

% 2. Hacemos un doble cifrado a la firma: primero con su clave privada,
%(nA, dA) y después con la clave pública de B, (nB , eB).
% Hacemos el primer cifrado
first_cipher = rsa_cipher(pr_A(1), pr_A(2), sig_A);

% Completamos los bloques (Multiplicamos la na por 10 al pasarla para tener
% un dígito más)
second_cipher = complete_blocks(pr_A(1) * 10, first_cipher);

% Ciframos ahora con la clave pública de B
% Dividimos en tamaño de los dígitos que tenga nb
sign_ciph_da_eb = prepare_num_cipher(numel(num2str(pb_B(1))) - 1, second_cipher);

sign_ciph_da_eb = rsa_num_cipher(pb_B(1), pb_B(2), sign_ciph_da_eb);

fprintf('Los dos criptogramas que A envía a B son: \n');
fprintf('\t text_ciph = ');
disp(text_ciph);
fprintf('\t sign_ciph_da_eb = ');
disp(sign_ciph_da_eb);

% Ahora B descifra esos dos criptogramas usando su clave privada (nb, db)
fprintf('\nAGENTE B\n');
fprintf('B empieza descifrando los códigos.\n');
% Desciframos el primer criptograma
text = rsa_decipher(pr_B(1), pr_B(2), text_ciph);
fprintf('El texto que ha recibido junto con la firma es: %s\n', text);

% Obtenemos la firma
% Primero obtendremos los bloques numéricos al cifrar
blocks = rsa_num_decipher(pr_B(1), pr_B(2), sign_ciph_da_eb);

% Preparamos los bloques para que tengan una longitud de nb - 1
aux = complete_blocks(pr_B(1), blocks);

% Los agrupamos y convertimos en números
signature = prepare_num_cipher(numel(num2str(pb_A(1))), aux);

% Ahora lo desciframos para obtener la firma
signature = rsa_decipher(pb_A(1), pb_A(2), signature);

fprintf('B obtiene la firma: %s\n', signature);
fprintf('\nHemos tenido éxito con la autenticación de la firma.\n');