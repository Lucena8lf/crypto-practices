% PRACTICA 7: Completa el siguiente codigo para implementar un programa
% que proporcione el MD5 de cualquier mensaje.
%
% Por si os ayuda os dejo un esqueleto del codigo junto con alguna 
% indicacion. Hay pasos que se pueden implementar de una forma
% alternativa, podeis variarlo siempre y cuando el programa funcione
% correctametne.
%
%  Salida: resumen MD5 del mensaje, que debera ser pedido al usuario,
%  como una cadena hexadecimal.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1st STEP.- INTRODUCING NECESSARY VARIABLES AND CONSTANTS.
clc
%1.1. STEP.- MESSAGE.

message = input('Introduce el mensaje: ', 's');

% 1.2. STEP.- WORK MODULE: m=2^32.
m= 2^32;

% 1.3. STEP.- CREATE A MATRIX S FOR THE BIT ROTATION.
% NUMBERS ARE NEGATIVE SINCE IT IS A LEFT ROTATION.
s = [-7, -12, -17, -22;-5,  -9, -14, -20;-4, -11, -16, -23;-6, -10, -15, -21];

% 1.4. STEP.- t IS THE VECTOR WITH THE T_i CONSTANTS (sin...).
i = 1:64;
t = abs(sin(i) * m);

% 1.5. STEP.- INITIAL WORDS. MD5 USES THE FOLLOWING 4 WORDS:
% A=01 23 45 67, but in little endian:67 45 23 01
% B=89 ab cd ef --> ef cd ab 89 
% C=fe dc ba 98 --> 98 ba dc fe
% D=76 54 32 10 --> 10 32 54 76

fhash = [hex2dec('67452301') , hex2dec('efcdab89') , hex2dec('98badcfe') , hex2dec('10325476') ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2nd STEP.- PREPARING THE MESSAGE FOR THE MD5 ALGORITHM.

message = abs(message);
bytelen = numel(message); 

% 2.1. STEP.- COMPLETE THE MESSAGE WITH 1 AND 0'S SO THAT THE NUMBER OF BITS
% IS CONGRUENT WITH 448 MOD 512. IF WORKING WITH BYTES, COMPLETE WITH 128
% AND 0'S SO THAT THE NUMBER OF BYTES IS CONGRUENT WITH 56 MOD 64.

% Dado que el mensaje lo convertimos a ASCII será más cómodo trabajar en
% bytes que en bits, por lo que añadiremos 128 y tantos 0's como sean 
% necesarios para que sea congruente con 56 MOD 64
message = [message 128];
while mod(length(message),64) ~= 56
    message = [message 0];
end

% 2.2. STEP.- 1 WORD = 4 BYTES. THUS, MAKE A 4-ROW MATRIX WITH THE BYTES OF 
% THE MESSAGE: EACH COLUMN WOULD BE A WORD. 

% Dado que estamos trabajando en bytes solo hacemos un reshape del mensaje
% para reagrupar todo en una matriz de 4 filas
message = reshape(message, 4, []);

% 2.3. STEP.- CONVERT EACH COLUMN TO 32-BITS INTEGERS (little endian).
% Recorremos cada columna del mensaje (que es una palabra) y la convertimos
% en un entero de 32 bits (la columna es de tipo byte, es decir, 8 bits)
word_matrix = [];
[f c] = size(message);
for i=1:c
    word = typecast(uint8(message(:,i)),'uint32');
    % Lo transformamos ya en double (64 bits) para que no de problemas
    % luego en las rondas
    word = double(word);
    word_matrix = [word_matrix word];
end

message = word_matrix;

% 2.4. STEP- COMPLETE WITH THE LENGTH OF THE ORIGINAL MESSAGE WITH A 64-BIT 
% INTEGER -> 8 BYTES -> 2 WORDS (little endian each word).
% Una vez hecho esto añadimos la longitud del mensaje que serán 8 bytes, es
% decir, como dos palabras

b = mod(bytelen * 8, m);

message = [message b mod(b / m, m)];

% Mostramos como queda el mensaje en 32 bits tras toda la preparación
g=sprintf('%d ', uint32(message));
fprintf('\nMensaje tras su preparación = [%s]\n', g);

%% 3rd STEP.- MD5 ALGORITHM.
% WORK WITH 512-BITS BLOCKS. EACH BLOCK HAS 16 WORDS.

for k = 1:16:numel(message)
    a = fhash(1); b = fhash(2); c = fhash(3); d = fhash(4);
    for i =1:64
        % Convert b, c and d to row vectors of bits.
        bv = dec2bin(b, 32) - '0';
        cv = dec2bin(c, 32) - '0';
        dv = dec2bin(d, 32) - '0';
        % obtain the logical functions  f(b,c,d).
        %      ki = index  0:15 of the message (k + ki).
        %      sr = rows 1:4 of  s(sr, :).
        if i <= 16          % 1st  round
            f = (bv & cv) | (~bv & dv);
            ki = i - 1;
            sr = 1;
        elseif i <= 32      %2nd round
            f = (bv & dv) | (cv & ~dv);
            ki = mod(5 * i - 4, 16);    %from 5 to 5 starting at 1
            sr = 2;
        elseif i <= 48      %3rd round
            f = xor(bv, xor(cv, dv));
            ki = mod(3 * i + 2, 16);    %from 3 to 3 starting at 5
            sr = 3;
        else                %4th round
            f = xor(cv, bv | ~dv);
            ki = mod(7 * i - 7, 16);    %from 7 to 7 starting at 0
            sr = 4;
        end
        % CONVERT f, FROM A ROW VECTOR OF BITS TO 32-BIT INTEGERS.
        % f es un vector que contiene 32 bits, por lo que lo transformamos
        % a un entero de 32 bits
        f = bin2dec(char(f + '0'));
       
        % APPLYING THE OPERATIONS OF THE ROUNDS.
        sc = mod(i - 1, 4) + 1;
        sum = mod(a + f + message(k + ki) + t(i), m);
        sum = dec2bin(sum, 32);
        sum = circshift(sum, [0, s(sr, sc)]);
        sum = bin2dec(sum);

        % MODIFYING a, b, c AND d. ROTATION IS NECESSARY.
        
        % Intercambiamos las variables
        a = d;
        d = c;
        c = b;
        b = mod(sum + b, m);
        
    end
    
    % MODIFYING THE HASH.
    % Una vez tenemos el hash del bloque lo único que debemos de hacer es
    % añadirlo junto al de los anteriores bloques (recordando hacerlo en módulo m)
    fhash = fhash + [a, b, c, d];
    fhash = mod(fhash, m);
    
end

% CONVERT THE HASH FROM 32-BIT INTEGERS (little endian) TO BYTES.
% De manera contraria que hicimos al principio del programa, ahora
% transformamos de 32 bits a bytes (8 bits)
fhash = typecast(uint32(fhash), 'uint8');

% CONVERT THE HASH TO HEXADECIMAL.
% Por último solo convertimos el hash a hexadecimal y lo dejamos todo en
% una sola línea para mostrarlo
fhash = reshape(dec2hex(fhash)', 1, []);

% Lo mostramos en minúscula
fprintf('\nmd5 = %s\n', lower(fhash));