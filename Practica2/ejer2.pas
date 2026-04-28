program ejer2;
const 
  valorAlto=9999;
type
  producto=record
  codigo:integer;
  nombre:string;
  precio:real;
  stock:integer;
  minimo:integer;
  end;

  maestro=file of producto;

  prod=record
  codigo:integer;
  unidades:integer;
  end;

  detalle=file of prod;

procedure Leer(var d:detalle; var reg:prod);
begin
  if(not eof(d)) then
    read(d,reg)
  else
    reg.codigo:=valorAlto;
end;

procedure Actualizar(var m:maestro; var d:detalle);
var 
  regD: prod;
  regM: producto;
begin
  reset(m);
  reset(d);
  Leer(d, regD); 
  while(regD.codigo<>valorAlto) do begin
    read(m,regM);
    while(regM.codigo<regD.codigo) do begin
      read(m,regM);
    end;
    while(regD.codigo<>valorAlto) and (regM.codigo=regD.codigo)do begin
      regM.stock:=regM.stock-regD.unidades;
      Leer(d,regD);
    end;
    seek(m,filepos(m)-1);
    write(m,regM)
  end; 
  close(m);
  close(d);
end;

procedure Leer2(var m:maestro; var pro:producto);
begin
  if(not eof(m)) then
    read(m,pro)
  else
    pro.codigo:=valorAlto;
end;

procedure Generar(var m:maestro);
var 
  a:text;
  pro:producto;
begin
  assign(a,'stock_minimo.txt');
  rewrite(a);
  reset(m);
  Leer2(m,pro);
  while(pro.codigo<>valorAlto) do begin
    if(pro.stock<pro.minimo)then
      write(a,pro.codigo,pro.nombre,pro.precio,pro.stock,pro.minimo);
    Leer2(m,pro);
  end;
  close(m);
  close(a);
end;

var 
  m: maestro;
  d: detalle;
begin
  assign(m,'Maestro');
  assign(d,'Detalle');
  Actualizar(m,d);
  Generar(m);
end.