function power = arnold_02 (photo, A)
%Función que desordena los píxeles de la imagen photo según la matriz A de
%manera sucesiva. Vamos a usar un switch con dos casos. El caso 1 desordena hasta recuperar
%la imagen original y el caso 2 desordena el número de veces que se indique.
%
%Entradas:
%photo: la imagen que queremos desordenar. Debe satisfacer los requisitos necesarios.
%A: la matriz que determina la transformación. Debe satisfacer los requisitos necesarios.
%Salida: el número de veces que hemos transformado la imagen.
%Aunque no sea un parámetro de salida, también debe mostrar una animación que comience
%con la imagen original y muestre todas las imágenes transformadas que se hayan ido realizando.
%También debe guardar la última imagen de la sucesión de imágenes modificadas.

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

opc = 0;
while opc ~= 1 && opc ~= 2
    opc = input(['Introduce 1 para desordenar hasta obtener la imagen original o 2 para ' ...
    'aplicar un cierto número de transformaciones: ']);

    if opc == 1
        % La imagen original se obtendrá cuando obtengamos la matriz
        % identidad al elevar la matriz
        % Primero obtenemos ese número de veces para obtener la matriz
        % identidad
        power = power_a(A,fil);
        
    elseif opc == 2
        % Pedimos el número de transformaciones que desea aplicar
        power = input(['Indica el número de transformaciones que ' ...
                'deseas aplicar: ']);
    else
        opc = input('Por favor, introduce una opción válida: ');
    end
end

% Creamos una cell donde iremos guardando cada imagen para la
% animación
images = cell(power,1);

% Comenzamos por la original y la guardamos
newName = photo;
images{1} = imread(newName);

% Desordenamos la imagen original ese número de veces
for i=1:power
    pixel_disorder(newName, A);
    imDisorder = getappdata (gcf,'matrix');

    % Guardamos la nueva imagen poniendole un '_disorder' a la nueva
    % imagen desordenada
    % Suponemos que la imagen que pasa por argumento ya está guardada
    [~,f,e]=fileparts(photo);
    newName = strcat(f, '_disorder', e);
    imwrite(imDisorder, newName);

    if i ~= 1
        % Vamos guardando las imágenes para la animación
        images{i} = imread(newName);
    end

end

% Empezamos a crear la animación
% Creamos un objeto VideoWriter con 1 fps
writerObj = VideoWriter('transformationAnimation.avi');
writerObj.FrameRate = 1;
% Lo abrimos
open(writerObj);
% Escribimos cada frame en el video, que en nuestro caso son las
% imágenes
for u=1:length(images)
    % Convertimos la imagen en frame
    %frame = im2frame(images{u});
    frame = images{u};
    writeVideo(writerObj, frame);
end

close(writerObj);

% Reproducimos el video
% Primero creamos un objeto de lector
shuttleAvi = VideoReader('transformationAnimation.avi');
ii = 1;
% Creamos la estructura de la película a partir de los fotogramas
while hasFrame(shuttleAvi)
   %vidFrame = readFrame(shuttleAvi);
   %imshow(vidFrame)
   %pause(1/shuttleAvi.FrameRate);

   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end

% Creamos la figura donde se reproducirá
figure
imshow(mov(1).cdata);

% La reproducimos
movie(mov,1,shuttleAvi.FrameRate);
