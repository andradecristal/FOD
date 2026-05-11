program ejer5;
type
    prenda=record
    cod_prenda:integer;
    descripcion:string;
    colores:string;
    tipo_prenda:string;
    stock:integer;
    precio_unitario:real;
    end;

    maestro=file of prenda;
    detalle=file of integer;
    auxiliar=file of prenda;

procedure ActualizarArchivo(var m:maestro; var d:detalle);
var
    pM:prenda;
    pD:integer;
begin
    reset(m);
    reset(d);
    while(not eof(d))do begin
        read(m,pM);
        read(d,pD);
        while(not eof(m)) and (pM.cod_prenda<>pD)do begin
            read(m,pM);
        end;
        pM.stock:=-1;
        seek(m,filepos(m)-1);
        write(m,pM);
        seek(m,0);
    end;
    close(m);
    close(d);
end;

procedure CrearArchivo(var a:auxiliar; var m:maestro);
var
    p: prenda;
begin
    reset(m);
    rewrite(a);
    while(not eof(m))do begin
        read(m,p);
        if(p.stock>0)then
            write(a,p);
    end;
    close(m);
    close(a);
end;

var
    m:maestro;
    d:detalle;
    a:auxiliar;
begin
    assign(m,'Maestro');
    assign(d,'Detlle');
    assign(a,'Auxiliar');
    ActualizarArchivo(m,d);
    CrearArchivo(a,m);
    erase(m);
    rename(a, 'Maestro.dat');
end.