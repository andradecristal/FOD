program ejer9;
const 
    ValorAlto=9999;
type
    cliente=record
    codigo:integer;
    nombre:string;
    apellido:string;
    end;

    regMae=record
    c:cliente;
    ano:integer;
    mes:integer;
    dia:integer;
    monto:real;
    end;

    mes=array[1..12] of real;

    regTex=record
    c:cliente;
    m:mes;
    ano:real;
    end;

    maestro=file of regMae;

procedure Leer(var m:maestro; var regM:regMae);
begin
    if(not eof(m))then
        read(m,regM)
    else
        regM.c.codigo:=ValorAlto;
end;

procedure CrearReporte(var m:maestro);
var
    regM:regMae;
    regT:regTex;
    ano, mes:integer;
    total:real;
begin
    reset(m);
    Leer(m,regM);
    total:=0;
    while(regM.c.codigo<>ValorAlto) do begin
        regT.c:=regM.c;
        write(regT.c.codigo, regT.c.nombre, regT.c.apellido);
        while(regM.c.codigo=regT.c.codigo)do begin
            ano:=regM.ano;
            regT.ano:=0;
            while(regM.ano=ano) and (regM.c.codigo=regT.c.codigo)do begin
                mes:=regM.mes;
                regT.m[mes]:=0;
                while(regM.mes=mes) and (regM.ano=ano) and (regM.c.codigo=regT.c.codigo) do begin
                    regT.ano:=regT.ano+regM.monto;
                    regT.m[mes]:=regT.m[mes]+regM.monto;
                    Leer(m,regM);
                end;
                write(regT.m[mes]); 
            end;
            write(regT.ano);
            total:=total+regT.ano;
        end;
    end;
    write(total);
    close(m);
end;

var 
    m:maestro;
begin
    assign(m,'maestro');
    CrearReporte(m);
end.