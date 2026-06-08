program Parcial1;
const
    valorAlto=9999;
type
    registro=record
    codigo:integer;
    nombre:string;
    ano:integer;
    evento:integer;
    nomEven:string;
    likes:integer;
    dislikes:integer;
    puntaje:integer;
    end;

    maestro = file of registro;

procedure Leer(var m:maestro; var r:registro);
begin
    if(not eof(m))then
        read(m,r)
    else
        r.codigo:=valorAlto;
end;

procedure inicializar(var aux:registro);
begin
    aux.likes:=0;
    aux.dislikes:=0;
    aux.puntaje:=0;
end;

procedure Informar( var m:maestro);
var
    r, aux, min:registro;
    presentaciones, anos, presentacionesTotal: integer;
begin
    reset(m);
    Leer(m,r);
    writeln('Resumen de menor influencia por evento');
    presentacionesTotal:=0;
    anos:=0;
    while(r.codigo<>valorAlto)do begin
        aux.ano:=r.ano;
        writeln('ano: ', aux.ano);
        presentaciones:=0;
        anos:=anos+1;
        while(r.ano=aux.ano)do begin
            aux.evento:=r.evento;
            aux.nomEven := r.nomEven;
            writeln('evento: ', aux.nomEven, '(', aux.evento, ')');
            min.puntaje:=valorAlto;
            min.dislikes:=0;
            while(r.ano=aux.ano) and (aux.evento=r.evento)do begin
                aux.codigo:=r.codigo;
                aux.nombre := r.nombre;
                inicializar(aux);
                writeln('artista: ', aux.nombre, '(',aux.codigo,')');
                while(r.ano = aux.ano) and (r.evento = aux.evento) and (aux.codigo=r.codigo)do begin
                    presentaciones:=presentaciones+1;
                    aux.likes:=aux.likes+r.likes;
                    aux.dislikes:=aux.dislikes+r.dislikes;
                    aux.puntaje:=aux.puntaje+r.puntaje;
                    Leer(m,r);
                end;
                writeln('Likes totales: ', aux.likes);
                writeln('Dislikes totales: ', aux.dislikes);
                writeln('Diferencia: ', aux.likes-aux.dislikes);
                writeln('Puntaje total del jurado: ', aux.puntaje);
                if(min.puntaje>aux.puntaje) or ((aux.puntaje = min.puntaje) and (aux.dislikes > min.dislikes)) then begin
                    min:=aux;
                end;
            end;
            writeln('El artista ', min.nombre, 'fue el menos influyente en el evento ', min.nomEven);
        end;
        presentacionesTotal:=presentacionesTotal+presentaciones;
        writeln('Durante el ano ', aux.ano, 'se registraron ', presentaciones, 'de presentacionesde artistas');
    end;
    writeln('El promedio de presentaciones por ano: ', presentacionesTotal/anos);
    close(m);
end;

var 
    m:maestro;
begin
    assign(m,'maestro');
    Informar(m);
end.