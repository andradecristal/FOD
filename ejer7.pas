program ejer7;
const 
    ValorAlto=9999;
type
    reg=record
    codigo:integer;
    apellido:string;
    nombre:string;
    cursadas:integer;
    finales:integer;
    end;

    reg1=record
    alumno:integer;
    materia:integer;
    ano:integer;
    aprobado:boolean;
    end;

    reg2=record
    alumno:integer;
    materia:integer;
    fecha:string;
    nota:integer;
    end;

    maestro=file of reg;
    detalle1=file of reg1;
    detalle2=file of reg2;

procedure Leer1(var d1:detalle1; var regD1:reg1);
begin
    if(not eof(d1)) then
        read(d1,regD1)
    else
        regD1.alumno:=ValorAlto;
end;

procedure Leer2(var d2:detalle2; var regD2:reg2);
begin
    if(not eof(d2)) then
        read(d2,regD2)
    else
        regD2.alumno:=ValorAlto;
end;

function Min(cod1:integer; cod2:integer):integer;
begin
    if(cod1>cod2) then
        Min:= cod2
    else
        Min:= cod1;
end;

procedure ReescribirMaestro(var m:maestro; var d1:detalle1; var d2:detalle2);
var
    regM:reg;
    regD1:reg1;
    regD2:reg2;
    minimo:integer;
begin
    reset(m);
    reset(d1);
    reset(d2);

    Leer1(d1,regD1);
    Leer2(d2,regD2);

    while((regD1.alumno<>ValorAlto) or (regD2.alumno<>ValorAlto)) do begin
        minimo:=Min(regD1.alumno,regD2.alumno);
        read(m,regM);
        while(regM.codigo<>minimo)do
            read(m,regM);
        
        while(regD1.alumno=minimo) do begin
            if(regD1.aprobado) then
                regM.cursadas:=regM.cursadas+1;
            Leer1(d1,regD1);
        end;

        while(regD2.alumno=minimo) do begin
            if(regD2.nota>=4) then
                regM.finales:=regM.finales+1;
            Leer2(d2,regD2);
        end;
        
        seek(m,filepos(m)-1);
        write(m,regM);
    end;
    close(m);
    close(d1);
    close(d2);
end;

var 
    m: maestro;
    d1: detalle1;
    d2: detalle2;
begin
    assign(m,'Maestro');
    assign(d1,'Detalle1');
    assign(d2,'Detalle2');
    ReescribirMaestro(m,d1,d2);
end.