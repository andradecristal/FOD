program ejer7;
type
    distribucion=record
    nombre:string;
    lanzamiento:string;
    versiones:integer; 
    desarrolladores:integer;
    descripcion:string;
    end;

    distribuciones=file of distribucion;

function BuscarDistribucion(var d:distribuciones; distro:string):integer;
var
    regD:distribucion;
    encontre:boolean;
    posicion:integer;
begin
    encontre:=false;
    posicion:=-1;
    seek(d, 1);
    while(not eof(d)) and (not encontre) do begin
        read(d,regD);
        if(regD.desarrolladores>0)then begin
            if(regD.nombre=distro)then begin
                encontre:=true;
                posicion:=filepos(d)-1;
            end;
        end;
    end;
    BuscarDistribucion:=posicion;
end;

procedure AltaDistribucion(var d:distribuciones; regD:distribucion);
var
    regAux:distribucion;
begin
    reset(d);
    if(BuscarDistribucion(d,regD.nombre)<>-1)then
        writeln('ya existe la distribución')
    else
        begin
            seek(d, 0);
            read(d,regAux);
            if(regAux.desarrolladores<0)then begin
                regAux.desarrolladores:=regAux.desarrolladores*-1;
                seek(d,regAux.desarrolladores);
                read(d,regAux);
                seek(d, filepos(d) - 1);
                write(d,regD);
                seek(d,0);
                write(d,regAux);
            end
            else begin
                seek(d,filesize(d));
                write(d,regD);
            end;
        end;
    close(d);
end;

procedure BajaDistribucion(var d:distribuciones; distro:string);
var
    regD, regAux:distribucion;
    posicion:integer;
begin
    reset(d);
    posicion:=BuscarDistribucion(d,distro);
    if(posicion=-1)then
        writeln('Distribución no existente')
    else
        begin
            seek(d, 0);
            read(d,regD);
            seek(d,posicion);
            read(d,regAux);
            seek(d,filepos(d)-1);
            write(d,regD);
            seek(d,0);
            regAux.desarrolladores:=posicion*(-1);
            write(d,regAux);
        end;
    close(d);
end;

var
    d:distribuciones;
    regD:distribucion;
begin
    assign(d,'Distribuciones');
    AltaDistribucion(d,regD);
    BajaDistribucion(d,'ubuntu');
end.