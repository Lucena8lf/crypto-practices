function v = rsa_cipher (n, e, text)
%Función que cifra la cadena de texto introducida según el sistema RSA
%usando la clave pública (n, e).
%
%Entradas:
%n y e: los valores de la clave pública para el cifrado RSA.
%text: el texto que queremos cifrar.
%Salida: el criptograma, es decir, el vector formado por los bloques ya cifrados

% Primero convertimos cada carácter del texto a número en Z27, siendo 2
% dígitos por carácter
numbers = letter_2numbers(text);

% Agrupamos en bloques numéricos de tamaño dígitos(n) − 1
d = numel(num2str(n)) - 1;

blocks = prepare_num_cipher(d, numbers);

% Ciframos cada bloque: Ci = Mi^e mod n
v = zeros(1,length(blocks));
for i=1:length(blocks)
    v(i) = power_mod(blocks(i), e, n);
end