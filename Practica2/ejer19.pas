program ejer19;
const
    ValorAlto=9999;
    DimF=50;
type
    direccion=record
    calle:string;
    numero:integer;
    piso:integer;
    depto:char;
    ciudad:string;
    end;

    persona=record
    partida:integer;
    nombre:string;
    apellido:string;
    end;
    
    /////////////////////////////////////////////////////////////////////////////

    naci=record
    d:direccion;
    medico:integer;
    madre:string;
    dniM:integer;
    padre:string;
    dniP:integer;
    end;

    falle=record
    dni:integer;
    medico:integer;
    fechaYhora:string;
    lugar:string;
    end;


    ///////////////////////////////////////////////////////////////////

    regNaci=record
    p:persona;
    n:naci;
    end;

    nacimiento=file of regNaci;
    nacimientos=array[1..DimF] of nacimiento;
    registrosN=array[1..DimF] of regNaci;

    regFalle=record
    p:persona;
    f:falle;
    end;

    fallecimiento=file of regFalle;
    fallecimientos=array[1..DimF] of fallecimiento;
    registrosF=array[1..DimF] of regFalle;

    regMae=record
    p:persona;
    n:naci;
    f:falle;
    muerto:boolean;
    end;
    
    maestro=file of regMae;

procedure LeerN(var n:nacimiento; var r:regNaci);
begin
    if(not eof(n))then
        read(n,r)
    else
        r.p.partida:=ValorAlto;
end;

procedure LeerF(var f:fallecimiento; var r:regFalle);
begin
    if(not eof(f)) then
        read(f,r)
    else
        r.p.partida:=ValorAlto;
end;

procedure MinimoN(var n:nacimientos; var r:registrosN; var minN:regNaci);
var
    i, x:integer;
begin
    minN.p.partida:=ValorAlto;
    for i:=1 to DimF do 
        if(minN.p.partida>r[i].p.partida)then begin
            minN:=r[i];
            x:=i;
        end;
    if(ValorAlto<>minN.p.partida) then
        LeerN(n[x],r[x]);
end;

procedure MinimoF(var f:fallecimientos; var r:registrosF; var minF:regFalle);
var
    i, x: integer;
begin
    minF.p.partida:=ValorAlto;
    for i:=1 to DimF do
        if(minF.p.partida>r[i].p.partida)then begin
            minF:=r[i];
            x:=i;
        end;
    if(ValorAlto<>minF.p.partida) then
        LeerF(f[x],r[x]);
end;

procedure ArmarMaestro(var m:maestro; var n:nacimientos; var f:fallecimientos);
var
    i:integer;
    regM:regMae;
    minN:regNaci;
    minF:regFalle;
    regF:registrosF;
    regN:registrosN;
begin
    rewrite(m);
    for i:=1 to DimF do begin
        reset(n[i]);
        reset(f[i]);
        LeerN(n[i],regN[i]);
        LeerF(f[i],regF[i]);
    end;
    MinimoN(n,regN,minN);
    MinimoF(f,regF,minF);
    while(minN.p.partida<>ValorAlto)do begin
        if(minF.p.partida<>ValorAlto) and (minF.p.partida=minN.p.partida)then begin
            regM.muerto:=true;
            regM.f:=minF.f;
            MinimoF(f,regF,minF);
        end
        else
            regM.muerto:=false;
        regM.n:=minN.n;
        regM.p:=minN.p;
        minimoN(n,regN,minN);
        write(m,regM);
    end;
    close(m);
    for i:=1 to DimF do begin
        close(n[i]);
        close(f[i]);
    end;
end;

var 
    m:maestro;
    n:nacimientos;
    f:fallecimientos;
    i:integer;
    nom:integer;
begin
    assign(m,'Maestro');
    for i:= 1 to DimF do begin
        str(i,nom);
        assign(n[i],'nacimientos_'+ nom);
        assign(f[i],'fallecidos_'+nom);
    end;
    ArmarMaestro(m,n,f);
end.