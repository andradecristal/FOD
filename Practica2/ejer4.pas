program ejer4;
const 
  DimF=30;
  ValorAlto=9999;
type
  producto=record
  codigo:integer;
  nombre:string;
  descripcion:string;
  stock:integer;
  minimo:integer;
  precio:real;
  end;

  maestro=file of producto;

  prod=record
  codigo:integer;
  unidades:integer;
  end;

  detalle=file of prod;

  detalles=array [1..DimF] of detalle;
  registros=array [1..DimF] of prod;

  registro=record
  nombre:string;
  descripcion:string;
  stock:integer;
  precio:real;
  end;

procedure Leer (var d:detalle; var p:prod);
begin
  if(not eof(d))then 
    read(d,p)
  else
    p.codigo:=ValorAlto;
end;

procedure Minimo(var d:detalles; var r:registros; var min:prod);
var
  x,i:integer;
begin
  min.codigo:=ValorAlto;
  for i:=1 to DimF do begin
    if(r[i].codigo<min.codigo) then begin
      min:=r[i];
      x:=i;
    end;
  end;
  if(m.codigo<>ValorAlto) then
    Leer(d[x],r[x]);
end;

procedure CrearInforme(regM:producto; var i:text);
begin
  if(regM.stock<regM.minimo) then begin
    writeln (i, 'Nombre: ', regM.nombre);
    writeln (i, 'Descripción: ', regM.descripción);
    writeln (i, 'Stock disponible: ', regM.stock);
    writeln (i, 'Precio: ', regM.precio);
  end;
end;

procedure Actualizar(var m:maestro; var d:detalles);
var 
  r:registros;
  min:prod;
  regM:producto;
  i, codigo:integer;
  i:text;
begin
  reset(m);
  assign(i,'informe.txt');
  rewrite(i);
  for i:=1 to DimF do begin
    reset(d[i]);
    Leer(d[i],r[i]);
  end;
  Minimo(d,r,min);
  read(m,regM);
  while(min.codigo<>ValorAlto) do begin
    codigo:=min.codigo;
    while (codigo=min.codigo) do begin
      while(regM.codigo<>codigo) do 
        //Supuestamente aca deberia crear el informe tambien
        read(m,regM);
      regM.stock:=regM.stock-min.unidades;
      Minimo(d,r,min);
    end; 
    seek(m,filepos(m)-1);
    write(m,regM);
    CrearInforme(regM,i);
  end;
  close(m);
  close(i);
  for i:=1 to DimF do
    close(d[i]);
end;

var 
  m:maestro;
  d:detalles;
  i: integer;
  nom:string;
begin
  assign(m,'Maestro');
  for i := 1 to DimF do begin
	  Str(i,nom);
    assign(d[i],nom);
  end;
  Actualizar(m,d);

end.