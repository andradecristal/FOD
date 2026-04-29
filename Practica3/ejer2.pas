program ejer2;
type
    datos=record
    codigo:integer;
    nombre:string;
    descripcion:string;
    precio:double;
    stock:integer;
    end;

    archivo=file of datos;

procedure CrearArchivo(var a:archivo);
var
    d:datos;
    i:integer;
begin
    rewrite(a);
    for i:=1 to 10 do begin
        readln(d.codigo);
        readln(d.nombre);
        readln(d.descripcion);
        readln(d.precio);
        readln(d.stock);
        write(a,d);
    end;
    close(a);
end;

procedure CorregirArchivo(var a: archivo);
var
    i:integer;
    d:datos;
begin
    reset(a);
    for i:=1 to 10 do begin
        read(a,d);
        if(d.stock=0) then begin
            d.nombre:='@' + d.nombre;
        end;
    end;
    close(a);
end;

var 
    a:archivo;
begin
   assign(a,'Archivo');
   CrearArchivo(a); 
   CorregirArchivo(a);
end.