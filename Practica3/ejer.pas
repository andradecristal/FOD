program ejer;
type
    libro=record
    codigo:integer;
    genero:string;
    titulo:string;
    autor:string;
    paginas:integer;
    precio:real;
    end;

    archivo=file of libro;

procedure Introducir(var l:libro);
begin
    read(l.codigo);
    read(l.genero);
    read(l.titulo);
    read(l.autor);
    read(l.paginas);
    read(l.precio);
end;

procedure CrearArchivo(var a:archivo);
var
    l:libro;
begin
    rewrite(a);
    l.codigo:=0;
    write(a,l);
    Introducir(l);
    while(l.codigo<>0) do begin
        write(a,l);
        Introducir(l);
    end;
    close(a);
end;

procedure DarDeAlta(var a:archivo);
var
    l, pos:libro;
begin
    reset(a);
    read(a,l);
    if(l.codigo=0)then begin
        seek(a,filesize(a));
        Introducir(l);
        write(a,l);
    end
    else begin
        l.codigo:=l.codigo*-1;
        seek(a,l.codigo);
        read(a,pos);
        seek(a,filepos(a)-1);
        Introducir(l);
        write(a,l);
        seek(a,0);
        write(a,pos);
    end;
    close(a);
end;

procedure ModificarDatos(var a:archivo);
var
    codigo:integer;
    l:libro;
begin
    reset(a);
    read(codigo);
    read(a,l);
    while(not eof(a)) and (codigo<>l.codigo)do
        read(a,l);
    if(l.codigo=codigo)then begin
        readln(l.genero);
        readln(l.titulo);
        readln(l.autor);
        readln(l.paginas);
        readln(l.precio);
        seek(a, filepos(a)-1); 
        write(a, l);
        close(a);
    end;
end;

procedure DarDeBaja(var a:archivo);
var
    codigo:integer;
    pos, l:libro;
begin
    reset(a);
    read(codigo);
    read(a,l);
    pos:=l;
    while(not eof(a)) and (codigo<>l.codigo) do 
        read(a,l);
    if(l.codigo=codigo) then begin
        seek(a, filepos(a)-1);
        write(a,pos);
        l.codigo:=(filepos(a)-1)*-1;
        seek(a,0);
        write(a,l);
    end;
    close(a);
end;


var
    a:archivo;
    nombre:string;
    opcion:integer;
begin
    readln(nombre);
    assign(a,nombre);
    readln(opcion);
    case opcion of
        1: CrearArchivo(a);
        2: DarDeAlta(a);
        3: ModificarDatos(a);
        4: DarDeBaja(a);
    end;
end.    