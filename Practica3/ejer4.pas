program ejer4;
const 
    valorAlto=9999;
type
    reg_flor = record
    nombre: String[45];
    codigo: integer;
    end;

    tArchFlores = file of reg_flor;

procedure agregarFlor (var t: tArchFlores; nombre: string; codigo: integer);
var
    r, aux:reg_flor;
    posLibre:integer;
begin
    reset(t);
    aux.nombre:=nombre;
    aux.codigo:=codigo;
    read(t,r);
    if(r.codigo=0) then begin
        seek(t,filesize(t));
        write(t,aux);
    end
    else begin
        posLibre:=r.codigo*(-1);
        seek(t,posLibre);
        read(t,r);
        seek(t,poslibre);
        write(t,aux);
        seek(t,0);
        write(t,r);
    end;
    close(t);
end;

procedure Leer(var t:tArchFlores; var r:reg_flor);
begin
    if(not eof(t))then
        read(t,r)
    else
        r.codigo:=valorAlto;
end;

procedure listarFLores(var t: tArchFlores);
var
    r:reg_flor;
begin
    reset(t);
    Leer(t,r);
    Leer(t,r);
    while(r.codigo<>valorAlto)do begin
        if(r.codigo>0)then
            writeln(r.nombre,' ',r.codigo);
        Leer(t,r);
    end;
    close(t);
end;

procedure eliminarFlor (var t: tArchFlores; flor:reg_flor);
var
    r, aux:reg_flor;
    encontrado: boolean;
begin
    reset(t);
    Leer(t,r);
    aux:=r;
    encontrado:=false;
    while((r.codigo<>valorAlto) and (not encontrado))do begin
        Leer(t,r);
        if(r.codigo=flor.codigo)then begin
            encontrado:=true;
            flor.codigo:=flor.codigo*(-1);
            write(t,aux);
            seek(t,0);
            write(t,flor);
        end;
    end;
    close(t);
end;

var
    t:tArchFlores;
    r:reg_flor;
begin
    assign(t,'ArchivoDeFlores');
    agregarFlor(t,'Cristal',1);
    listarFLores(t);
    r.nombre:='Cristal';
    r.codigo:=1;
    eliminarFlor(t,r);
end.

