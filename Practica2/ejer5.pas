program ejer5;
const 
  ValorAlto=9999;
  DimF=5;
type
  datos=record
  codigo:integer;
  fecha:string;
  tiempo:integer;
  end;

  archivo=file of datos;

  detalles=array[1..Dimf] of archivo;
  registros=array[1..DimF] of datos;

procedure Leer(var d:archivo; var de:datos);
begin
  if(not eof(d)) then
    read(d,de)
  else
    de.codigo:=ValorAlto;
end;

procedure Minimo(var d:detalles; var r:registros; var min:datos);
var 
  pos, i:integer;
begin
  min.codigo:=ValorAlto;
  for i:=1 to DimF do begin
    if(d[i].codigo<min.codigo) then begin
      min.codigo:=d[i].codigo;
      pos:=i;
    end;
  end;
  if(min.codigo<>ValorAlto) then
    Leer(d[pos],r[pos]);
end;

procedure CrearArchivo(var m:archivo; var d:detalles);
var
  regM, min: datos;
  i, codigo: integer;
  r:registros;
begin
  rewrite(m);
  for i:=1 to DimF do
    reset(d[i]);
  Minimo(d,r,min);
  while(min.codigo<>ValorAlto)do begin
    codigo:=min.codigo;
    while(codigo=min.codigo) do begin
      write(m,min);
      Minimo(d,r,min);
    end;
  end;
  close(m);
  for i:=1 to DimF do 
    close(d[i]);
end;

var 
  m: archivo;
  d: detalles;
  i: integer;
  nom: string;
begin
  assign(m,'/var/log');
  for i:=1 to DimF do begin
    str(i,nom);
    assign(d[i],nom);
  end;
  CrearArchivo(m,d);
  
end.