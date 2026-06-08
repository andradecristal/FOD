program Parcial3;
type
    mascota=record
    codigo:integer;
    nombre:string;
    especie:string;
    edad:integer;
    dueno:string;
    telefono:integer;
    end;

    mascotas=file of mascota;

function ExisteMascota(var m:mascotas; codigo:integer):integer;
var
    regM:mascota;
    pos:integer;
begin
    reset(m);
    pos:=0;
    read(m,regM);
    while(not eof(m)) and (regM.codigo<>codigo) do 
        read(m,regM);
    if(regM.codigo=codigo)then
        pos:=filepos(m)-1;
    close(m);
    ExisteMascota:=pos;
end;

procedure AltaMascota(var m:mascotas);
var
    nueva, regM: mascota;
begin
    readln(nueva.codigo);
    readln(nueva.nombre);
    readln(nueva.especie);
    readln(nueva.edad);
    readln(nueva.dueno);
    readln(nueva.telefono);
    if(ExisteMascota(m,nueva.codigo)=0)then begin
        reset(m);
        read(m,regM);
        if(regM.codigo=0)then begin
            seek(m,filesize(m));
            write(m,nueva);
        end
        else begin
            regM.codigo:=regM.codigo*-1;
            seek(m,regM.codigo);
            read(m,regM);
            seek(m,filepos(m)-1);
            write(m,nueva);
            seek(m,0);
            write(m,regM);
        end;
        close(m);
    end
    else
        writeln('ya existe la mascota');
end;

procedure BajaMascota(var m:mascotas);
var
    codigo, pos :integer;
    regM: mascota;
begin
    readln(codigo);
    pos:=ExisteMascota(m,codigo);
    if(pos<>0) then begin
        reset(m);
        read(m,regM);
        seek(m,pos);
        write(m,regM);
        seek(m,0);
        pos:=pos*-1;
        regM.codigo:=pos;
        write(m,regM);
        close(m);
    end
    else
        writeln('Mascota no registrada');
end;

var
    m:mascotas;
begin
    assign(m,'Mascotas');
    ExisteMascota(m,1001);
    AltaMascota(m);
    BajaMascota(m);
end.