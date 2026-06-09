program ejer17;
const 
    dimF=10;
    valorAlto=9999;
type
    moto=record
    codigo:integer;
    nombre:string;
    descripcion:string;
    modelo:integer;
    marca:string;
    stock:integer;
    end;

    maestro=file of moto;

    venta=record
    codigo:integer;
    precio:real;
    fecha:string;
    end;

    detalle=file of venta;
    detalles=array[1..dimF]of detalle;
    ventas=array[1..dimF] of venta;

procedure Leer(var d:detalle; var r:venta);
begin
    if(not eof(d))then
        read(d,r)
    else
        r.codigo:=valorAlto;
end;

procedure Minimo(var d:detalles; var r:ventas; var min:venta);
var
    x, i: integer;
begin
    min.codigo:=valorAlto;
    for i:=1 to dimF do begin
        if(r[i].codigo<min.codigo)then begin
            min:=r[i];
            x:=i;
        end;
    end;
    if(min.codigo<>valorAlto)then
        Leer(d[x],r[x]);
end;

procedure Actualizar(var m:maestro; var d:detalles);
var
    regM, ganadora :moto;
    regD:ventas;
    min:venta;
    codigo, i, ventasActuales, maxVentas:integer;
begin
    reset(m);
    for i:=1 to dimF do begin
        reset(d[i]);
        Leer(d[i],regD[i]);
    end;
    Minimo(d,regD,min);
    read(m,regM);
    maxVentas := -1;
    while(min.codigo<>valorAlto)do begin
        codigo:=min.codigo;
        while(regM.codigo<>codigo)do
            read(m,regM);
        ventasActuales := 0;
        while(codigo=min.codigo)do begin
            regM.stock:=regM.stock-1;
            ventasActuales := ventasActuales + 1;
            Minimo(d,regD,min);
        end;
        if(ventasActuales > maxVentas)then begin
            maxVentas := ventasActuales;
            ganadora:=regM;
        end;
        seek(m,filepos(m)-1);
        write(m,regM);
    end;
    write('ganadora ', ganadora.nombre);
    close(m);
    for i:=1 to dimF do 
        close(d[i]);
end;

var
    d:detalles;
    m:maestro;
    nom:string;
    i:integer;
begin
    assign(m,'Maestro');
    for i:=1 to dimF do begin
        str(i,nom);
        assign(d[i],nom);    
    end;
    Actualizar(m,d);
end.