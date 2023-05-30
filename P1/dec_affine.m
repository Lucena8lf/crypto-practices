function text=dec_affine(k,d,code)
% Función que descifra un mensaje cifrado por el método afín
%
%Entradas:
%k: la clave multiplicativa empleada en el método.
%d: el desplazamiento empleado en el método.
%code: el texto encriptado del que se pretende obtener el texto claro.
%Salida: el mensaje claro.

% Mismas comprobaciones iniciales que para el cifrado
z27 = [0:26];
convertedNumbers = [];
abecedario = ['a':'n' abs('ñ') 'o':'z'];
text = [];

if( ismember(k, z27) == 0 || ismember(d, z27) == 0)
    error("k y d deben ser un numero en Z27!")
end

if( gcd(k,27)~=1 )
    error("El MCD de k y 27 debe ser 1 para poder realizar el cifrado!")
end

% 1. Transformar el texto encriptado a numeros en Z27
originalNumbers = letter_number(code);

% 2. Calculamos -d y k^-1
oppositeD = 27 - d;
[G, C, ~] = gcd(k, 27); % [G,C,D] = GCD(A,B) also returns C and D so that G = A.*C + B.*D. -> Coeficiente Id. Bézout

% 3. Aplicamos x → k^−1 (x + (−d)) mod 27
for i=1:length(originalNumbers)
    newValue = C * (originalNumbers(i) + oppositeD);
    newValue = mod(newValue, 27);
    convertedNumbers = [convertedNumbers newValue];
end

% 4. Volvemos a convertir en letras
for i=1:length(convertedNumbers)
    for j=1:length(z27)
        if convertedNumbers(i)==z27(j)
            text=[text abecedario(j)];
            break
        end
    end
end