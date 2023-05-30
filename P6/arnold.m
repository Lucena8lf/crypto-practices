function arnold (photo, A)
%Función que ordena o desordena una foto, de acuerdo a la opción elegida
%por el usuario. Para elegir una de estas opciones se debe usar un switch con dos casos. El
%caso 1 para desordenar y el caso 2 para ordenar.
%Entradas:
%photo: una fotografía a la que queremos aplicarle la transformación de Arnold. Debe cumplir
%los requisitos necesarios. NOTA: debe ser la fotografía original en el caso 1 y la fotografía
%desordenada según la matriz A en el caso 2.
%A: la matriz que se va a usar para desordenar en el caso 1 o que ya se haya usado para
%desordenar en el caso 2. Debe cumplir los requisitos necesarios.
%Salida: aunque no tenga ningún output debe mostrar en cada caso dos imágenes en una
%misma ventana. En el caso 1 debe mostrar la foto original (ordenada) junto con la modificada (desordenada). En el caso 2 debe mostrar la foto original (desordenada) junto
%con la modificada (ordenada). En ambos casos debe guardar las fotos obtenidas tras la
%transformación.

% Comprobamos que debe A sea cuadrada, de orden 2, con elementos enteros y debe tener inversa módulo el número de filas de photo
% Es cuadrada y de orden 2
[n m]=size(A);
if n ~= m
    error('La matrix A debe ser cuadrada');
elseif n ~= 2
    error('La matriz debe ser de orden 2');
end

imOriginal = imread(photo);
[fil col] = size(imOriginal);

% Comprobamos que la matriz tenga elementos que solo sean enteros
if ismember(1,floor(A) ~= A)% Floor() redondea. Si contiene un 1 -> NO es matriz de enteros
    error('Todos los elementos de la matriz deben ser números enteros');
end

% Comprobamos si la matriz es invertible con el módulo dado
detA = round(det(A)); % Tenemos que utilizar round() porque nos devuelve un decimal

[G, C, ~] = gcd(mod(detA,fil), fil);
inverseDet = mod(C,fil);

if G ~= 1
    error('La matriz no es inversible con el modulo dado');
end

opc = input('Introduce 1 para desordenar o 2 para ordenar la imagen: ');

switch opc
    case 1
        % Desordenamos la imagen original
        pixel_disorder(photo, A);
        imDisorder = getappdata (gcf,'matrix');
        
        % Guardamos la nueva imagen poniendole un '_disorder' a la nueva
        % imagen desordenada
        % Suponemos que la imagen que pasa por argumento ya está guardada
        [~,f,e]=fileparts(photo);
        newName = strcat(f, '_disorder', e);
        imwrite(imDisorder, newName);

        % Mostramos ambas imagenes
        subplot(1,2,1);
        imshow(imOriginal);
        title('Imagen original');

        subplot(1,2,2);
        imshow(imDisorder);
        title('Imagen desordenada');

    case 2
        % Para ordenar la imagen deberemos obtener la inversa modular de la
        % matriz con la que ha sido ordenada
        inver = inv_module(A,fil);

        % Ahora ordenamos con su inversa para obtener la foto original
        pixel_disorder(photo, inver);
        imOrder = getappdata (gcf,'matrix');

        % Guardamos la nueva imagen poniendole un '_disorder' a la nueva
        % imagen desordenada
        % Suponemos que la imagen que pasa por argumento ya está guardada
        [~,f,e]=fileparts(photo);
        newName = strcat(f, '_order', e);
        imwrite(imOrder, newName);

        % Mostramos ambas imagenes
        subplot(1,2,1);
        imshow(imOriginal);
        title('Imagen original');

        subplot(1,2,2);
        imshow(imOrder);
        title('Imagen ordenada');

    otherwise
        error('Las opciones permitidas son 1 o 2');

end