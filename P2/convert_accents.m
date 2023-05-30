function v=convert_accents(c)
%Función que transformará la letra con acento en letra sin acento
%
%Entrada: letra con acento
%Salida: misma letra pero sin acento

v = '';

switch c
    case 'á'
        v = 'a';
    case 'é'
        v = 'e';
    case 'í'
        v = 'i';
    case 'ó'
        v = 'o';
    case 'ú'
        v = 'u';
end