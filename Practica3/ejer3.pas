program ejer3;
const
    ValorAlto=9999;
type
    libro=record
    codigo:integer;
    genero:string;
    titulo:string;
    autor:string;
    paginas:integer;
    precio:double;
    end;
     
    libreria=file of libro;

procedure Asignar(var li:libro);
begin
    readln(li.codigo);
    if(li.codigo<>0)then begin
        readln(li.genero);
        readln(li.titulo);
        readln(li.autor);
        readln(li.paginas);
        readln(li.precio);
    end;
end;

procedure CargarArchivo(var l:libreria);
var
    li:libro;
begin
    rewrite(l);
    li.codigo:=0;
    write(l,li);
    Asignar(li);
    while(li.codigo<>0)do begin
        write(l,li);
        Asignar(li);
    end;
    li.codigo:=ValorAlto;
    write(l,li);
    close(l);
end;

procedure DarDeAlta(var l:libreria);
var
    li, nuevo:libro;
begin
    reset(l);
    readln(nuevo.codigo);
    read(l,li);
    if(li.codigo<0)then begin
        seek(l,-li.codigo);
        read(l,li);
        seek(l,filepos(l)-1);
        write(l,nuevo);
        seek(l,0);
        write(l,li);
    end
    else begin
        seek(l,filesize(l));
        write(l,nuevo);
    end;
    close(l);
end;

procedure Leer(var l:libreria; var li:libro);
begin
    if(not eof(l))then  
        read(l,li)
    else
        li.codigo:=ValorAlto;
end;

procedure ModificarDatos(var l:libreria);
var
    li, nuevo:libro;
begin
    reset(l);
    Leer(l,li);
    readln(nuevo.codigo);
    while(li.codigo<>ValorAlto) and (li.codigo<>nuevo.codigo)do 
        Leer(l,li);
    if(li.codigo<>ValorAlto)then begin
        seek(l,filepos(l));
        write(l,nuevo);
    end;
    close(l);
end;

procedure EliminarLibro(var l:libreria);
var
    codigo:integer;
    li, nuevo:libro;
begin
    reset(l);
    Leer(l,nuevo);
    readln(codigo);
    Leer(l,li);
    while(li.codigo<>ValorAlto) and (li.codigo<>codigo)do
        Leer(l,li);
    if(li.codigo<>ValorAlto)then begin
        li.codigo:=filepos(l)*-1;
        write(l,nuevo);
        seek(l,0);
        write(l,li);
    end;
    close(l);
end;

var
    l:libreria;
    opcion:integer;
    nombre:string;
begin
    readln(nombre);
    assign(l,nombre);
    read(opcion);
    case opcion of
        1: CargarArchivo(l);
        2: DarDeAlta(l);
        3: ModificarDatos(l);
        4: EliminarLibro(l);
        //5: ExportarArchivo(l);
    end;
end.