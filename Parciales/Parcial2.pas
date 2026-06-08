program Parcial2;
const 
    dimF=12;
    valorAlto=9999;
type
    equipo=record
    codigo:integer;
    nombre:string;
    partidos:integer;
    ganados:integer;
    empatados:integer;
    perdidos:integer;
    puntos:integer;
    end;

    maestro=file of equipo;

    partido=record
    codigo:integer;
    fecha:string;
    puntos:integer;
    rival:integer;
    end;

    detalle=file of partido;
    detalles=array[1..dimF] of detalle;
    partidos=array[1..dimF] of partido;

procedure Leer(var d:detalle; var p:partido);
begin
    if(not eof(d)) then
        read(d,p)
    else
        p.codigo:=valorAlto;
end;

procedure Minimo(var d:detalles; var p:partidos; var min:partido);
var
    i, x:integer;
begin
    min.codigo:=valorAlto;
    for i:=1 to dimF do begin
        if(p[i].codigo<min.codigo) then begin
            min:=p[i];
            x:=i;
        end;
    end;
    if(min.codigo<>valorAlto)then
        Leer(d[x],p[x]);
end;

procedure Incrementar(var regM:equipo; min:partido);
begin
    regM.partidos:=regM.partidos+1;
    if(min.puntos=3)then
        regM.ganados:=regM.ganados+1
    else
        if(min.puntos=1) then
            regM.empatados:=regM.empatados+1
        else
            regM.perdidos:=regM.perdidos+1;
    regM.puntos:=regM.puntos+min.puntos;
end;

procedure Actualizar(var m:maestro; var d:detalles);
var 
    p: partidos;
    regM, ganador: equipo;
    min: partido;
    codigo, i, acumulador:integer;
begin
    reset(m);
    for i:=1 to dimF do begin
        reset(d[i]);
        Leer(d[i],p[i]);
    end;
    read(m,regM);
    Minimo(d,p,min);
    ganador.puntos:=0;
    while(min.codigo<>valorAlto)do begin
        codigo:=min.codigo;
        acumulador:=0;
        while(regM.codigo<>codigo)do
            read(m,regM);
        while(codigo=min.codigo)do begin
            acumulador:=acumulador+min.puntos;
            Incrementar(regM,min);
            Minimo(d,p,min);
        end;
        seek(m,filepos(m)-1);
        write(m,regM);
        if(acumulador>ganador.puntos)then begin
            ganador.nombre:=regM.nombre;
            ganador.puntos:=acumulador;
        end;
    end;
    writeln('El qeuipo con mas puntos de este temporada: ', ganador.nombre, ganador.puntos);
    close(m);
    for i:=1 to dimF do
        close(d[i]);
end;


var 
    m:maestro;
    d:detalles;
    nom:string;
    i:integer;
begin
    readln(nom);
    assign(m,nom);
    for i:=1 to dimF do begin
        readln(nom);
        assign(d[i],nom);
    end;
    Actualizar(m,d);
end.