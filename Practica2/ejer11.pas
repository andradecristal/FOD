program ejer11;
const 
    ValorAlto=9999;
type
    categoria=1..15;

    HorasExtras=array[categoria] of real;

    registroM=record
    departamento:integer;
    division:integer;
    empleado:integer;
    c:categoria;
    horas:integer;
    end;

    maestro=file of registroM;

procedure CargarHorasExtras(var h:HorasExtras);
var 
    t:text;
    cat:categoria;
    monto:real;
begin
    assign(t,'reporte.txt');
    reset(t);
    while(not eof(t)) do begin
        read(t,cat,monto);
        h[cat]:=monto;
    end;
    close(t);
end;

procedure Leer(var m:maestro; var regM:registroM);
begin
    if(not eof(m))then
        read(m,regM)
    else
        regM.departamento:=ValorAlto;
end;

procedure CrearListado(var m:maestro; h:HorasExtras);
var 
    regM, reg :registroM;
    horasDepto, horasDivision: integer;
    montoDepto, montoDivision, montoEmpleado: real;
begin
    Leer(m,regM);
    while(regM.departamento<>ValorAlto)do begin
        reg.departamento:=regM.departamento;
        writeln(reg.departamento);
        horasDepto:=0;
        montoDepto:=0;
        while(regM.departamento=reg.departamento) do begin
            reg.division:=regM.division;
            writeln(reg.division);
            horasDivision:=0;
            montoDivision:=0;
            while(regM.division=reg.division) and (regM.departamento=reg.departamento)do begin
                reg.empleado:=regM.empleado;
                write(reg.empleado);
                reg.horas:=0;
                montoEmpleado:=0;
                while(regM.empleado=reg.empleado) and (regM.division=reg.division) and (regM.departamento=reg.departamento)do begin
                    reg.horas:=reg.horas+regM.horas;
                    montoEmpleado:=montoEmpleado+(regM.horas*h[regM.c]);
                    Leer(m,regM);
                end;
                write(reg.horas);
                write(montoEmpleado);
                horasDivision:=horasDivision+reg.horas;
                montoDivision:=montoDivision+montoEmpleado;
            end;
            writeln(horasDivision);
            writeln(montoDivision);
            horasDepto:=horasDepto+horasDivision;
            montoDepto:=montoDepto+montoDivision;
        end;
        writeln(horasDepto);
        writeln(montoDepto);
    end;
    close(m);
end;

var 
    m:maestro;
    h:HorasExtras;
begin
    assign(m,'Maestro');
    CargarHorasExtras(h);
    CrearListado(m,h);
end.