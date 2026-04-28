program ejer6;
const 
  ValorAlto=9999;
  DimF=10;
type
  infoD=record
  localidad:integer;
  cepa:integer;
  activos:integer;
  nuevo:integer;
  recuperados:integer;
  fallecidos:integer;
  end;

  detalle=file of infoD;
  info=array[1..DimF] of infoD;
  detalles=array[1..DimF] of detalle;

  infoM=record
  nomLoc:string;
  nomCepa:integer;
  reg:infoD;
  end;

  maestro=file of infoM;

procedure Leer(var d:detalle; var r:infoD);
begin
  if(not eof(d)) then
    read(d,r)
  else
    r.localidad:=ValorAlto;
end;

procedure Minimo(var d:detalles; var r:info; var min:infoD);
var
 pos, i:integer;
begin
  min.localidad:=ValorAlto;
  min.cepa:=ValorAlto;
  pos:=0;
  for i:=1 to DimF do begin
    if(r[i].localidad<min.localidad) or ((r[i].localidad=min.localidad) and (r[i].cepa<min.cepa)) then begin
      min:=r[i];
      pos:=i;
    end;
  end;
  if(pos<>0) then
    Leer(d[pos],r[pos]);
end;

procedure CrearArchivo(var d:detalles; var m:maestro);
var 
  regD:info;
  regM:infoM;
  min:infoD;
  i,codigo,cepa:integer;
begin
  reset(m);
  for i:=1 to DimF do
    reset(d[i]);
  read(m,regM);
  Minimo(d,regD,min);
  while(min.localidad<>ValorAlto) do begin
    codigo:=min.localidad;
    while(codigo=min.localidad) do begin
      cepa:=min.cepa;
      while(codigo=min.localidad) and (cepa=min.cepa) do begin
        while(regM.reg.localidad<>min.localidad) or (regM.reg.cepa<>min.cepa) do
          read(m,regM);
        end;
        regM.reg.fallecidos:=regM.reg.fallecidos+min.fallecidos;
        regM.reg.recuperados:=regM.reg.recuperados+min.recuperados;
        regM.reg.activos:=min.activos;
        regM.reg.nuevo:=min.nuevo;
        Minimo(d,regD,min);
      end;
      write(m,regM);
    end;
  end;
  close(m);
  for i:=1 to DimF do
    close(d[i]);
end;

var 
  d:detalles;
  m:maestro;
  i:integer;
  nom:string;
begin
  assign(m,'Maestro');
  for i:=1 to DimF do begin
    str(i,nom); 
    assign(d[i],nom);
  end;
  CrearArchivo(d,m);
end.