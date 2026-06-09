program Parcial4;
const 
    valorAlto=9999;
type
    fecha=record
    dia:integer;
    mes:integer;
    ano:integer;
    end;

    prestamo=record
    sucursal:integer;
    dni:integer;
    numero:integer;
    f:fecha;
    monto:real;
    end;

    prestamos=file of prestamo;

procedure Leer(var p:prestamos; var regP: prestamo);
begin
    if(not eof(p)) then
        read(p,regP)
    else
        regP.sucursal:=valorAlto;
end;

procedure Informe(var p:prestamos);
var
    regP, aux:prestamo;
    i: text;
    contVentas, totalVentas, sucursalVenta :integer;
    totalMonto, sucursalMonto: real;
begin
    assign(i,'Informe.txt');
    rewrite(i);
    reset(p);
    Leer(p,regP);
    writeln(i,'Informe de ventas de la empresa');
    while(regP.sucursal<>valorAlto)do begin
        aux.sucursal:=regP.sucursal;
        writeln(i,'Sucursal ',aux.sucursal);
        sucursalMonto:=0;
        sucursalVenta:=0;
        while(aux.sucursal=regP.sucursal)do begin
            aux.dni:=regP.dni;
            writeln(i,'Empleado: DNI ',aux.dni);
            totalVentas:=0;
            totalMonto:=0;
            writeln(i,'Ano        Cantidad de ventas        Monto de ventas');
            while(regP.sucursal = aux.sucursal) and (aux.dni=regP.dni) do begin
                aux.f:=regP.f;
                aux.monto:=0;
                contVentas:=0;
                while(regP.sucursal = aux.sucursal) and (regP.dni = aux.dni) and (aux.f.ano=regP.f.ano) do begin
                    aux.monto:=aux.monto+regP.monto;
                    contVentas:=contVentas+1;
                    Leer(p,regP);
                end;
                totalVentas:=totalVentas+contVentas;
                totalMonto:=totalMonto+aux.monto;
                writeln(i, aux.f.ano, '              ', contVentas, '                       ', aux.monto:0:2);
            end;
            sucursalMonto:=sucursalMonto+totalMonto;
            sucursalVenta:=sucursalVenta+totalVentas;
            write(i,'Totales ');
            write(i, totalVentas);
            writeln(i,totalMonto);
        end;
        writeln(i,'Cantidad total ventas sucursal ',sucursalVenta);
        writeln(i,'Monto total vendido por sucursal ',sucursalMonto);
    end;
    close(i);
    close(p);
end;


var
    p:prestamos;
begin
    assign(p,'Prestamos');
    Informe(p);
end.