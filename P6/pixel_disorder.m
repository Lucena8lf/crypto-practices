function pixel_disorder (photo, A)
%Se trata de una función que desordena los píxeles de las matrices asociadas a una imagen
%de acuerdo a la transformación asociada a la matriz dada. No se pretende que muestre nada, ni
%imágenes ni matrices, sólo que guarde las matrices obtenidas para usarlas en otras funciones.
%
%Entradas:
%photo: imagen de la queremos desordenar sus píxeles. Para poder aplicar el método la imagen
%debe ser cuadrada.
%A: matriz que determina la transformación. Conviene recordar que debe ser cuadrada, de
%orden 2, con elementos enteros y debe tener inversa módulo el número de filas de photo.
%Salida: ninguna. Debe guardar las nuevas matrices obtenidas para un posible uso posterior.
%Para ello puede ser útil la orden setappdata (gcf,'matrix',matrix). Si más adelante necesitamos
%usar esa matriz puede ser de utilidad matrix = getappdata (gcf,'matrix').

im = imread(photo);

[fil, col, band] = size(im);

% Comprobamos que debe A sea cuadrada, de orden 2, con elementos enteros y debe tener inversa módulo el número de filas de photo
% Es cuadrada y de orden 2
[n m]=size(A);
if n ~= m
    error('La matrix A debe ser cuadrada');
elseif n ~= 2
    error('La matriz debe ser de orden 2');
end


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

% Ahora debemos desordenar cada pixel de la imagen de acuerdo a la matriz
% A. Por lo que debemos multiplicar cada elemento por la matriz
new_photo = zeros(fil, col);

if band == 1 % Fotografía en B/N
    for i=1:fil
        for j=1:col
            pos = [i;j];
            val = mod(A * pos,fil);
            % Esto nos dará el lugar al que llevar ese elemento
            % Si nos sale 0 lo cambiaremos por el modulo
            if val(1,1) == 0
                val(1,1) = fil;
            end
            if val(2,1) == 0
                val(2,1) = fil;
            end
            new_photo(val(1,1),val(2,1)) = im(i,j);
        end
    end
else % Fotografía color
    R = im(:,:,1);
    G = im(:,:,2);
    B = im(:,:,3);

    [f c]=size(R);
    new_R = zeros(f, c);

    for i=1:f
        for j=1:c
            pos = [i;j];
            val = mod(A * pos,f);
            % Esto nos dará el lugar al que llevar ese elemento
            % Si nos sale 0 lo cambiaremos por el modulo
            if val(1,1) == 0
                val(1,1) = f;
            end
            if val(2,1) == 0
                val(2,1) = f;
            end
            new_R(val(1,1),val(2,1)) = R(i,j);
        end
    end

    [f c]=size(G);
    new_G = zeros(f, c);

    for i=1:f
        for j=1:c
            pos = [i;j];
            val = mod(A * pos,f);
            if val(1,1) == 0
                val(1,1) = f;
            end
            if val(2,1) == 0
                val(2,1) = f;
            end
            new_G(val(1,1),val(2,1)) = G(i,j);
        end
    end

    [f c]=size(B);
    new_B = zeros(f, c);

    for i=1:f
        for j=1:c
            pos = [i;j];
            val = mod(A * pos,f);
            if val(1,1) == 0
                val(1,1) = f;
            end
            if val(2,1) == 0
                val(2,1) = f;
            end
            new_B(val(1,1),val(2,1)) = B(i,j);
        end
    end

end

% Convertimos la nueva imagen a uint8
if band == 1
    new_photo = rescale(new_photo, 0, 255);
    new_photo = uint8(new_photo);

else
    new_photo = rescale(new_photo, 0, 255);
    new_photo = cat(3, new_R, new_G, new_B);
    new_photo = uint8(new_photo);
end

setappdata(gcf,'matrix',new_photo);