program ejer1;
const 
 valorAlto=9999;
type
  empleado=record
  codigo:integer;
  nombre:string;
  monto:real;
  end;

  empleados=file of empleado;

procedure leer(var a1: empleados; var emp1: empleado);
begin
    if (not EOF(a1)) then
        read (a1, emp1)
    else
        emp1.codigo := valorAlto; // asigno un valor de corte
end;

procedure cargar(var e1:empleados; var e2:empleados);
var
  emp1, emp2:empleado;
begin
  reset(e1);
  rewrite(e2);
  leer(e1,emp1);
  while(emp1.codigo<>valorAlto) do begin
    emp2:=emp1;
    emp2.monto:=0;
    while((emp1.codigo<>valorAlto) and (emp1.codigo=emp2.codigo)) do begin
      emp2.monto:=emp2.monto+emp1.monto;
      leer(e1,emp1);
      end;
    write(e2,emp2);
    end;
  close(e1);
  close(e2);
end;

var
  e1, e2:empleados;
begin
  assign(e1, 'detalle.dat');
  assign(e2, 'maestro.dat');
  cargar(e1,e2);
end.