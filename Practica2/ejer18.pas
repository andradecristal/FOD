program ejer18;
const 
    valorAlto=9999;
type
    caso=record
    codLocalidad:integer;
    nomLocalidad:string;
    codMunicipio:integer;
    nomMunicipio:string;
    codHospital:integer;
    nomHospital:string;
    fecha:string;
    cantidad:integer;
    end;

    casos=file of caso;

procedure Leer(var c:casos; var regC:caso);
begin
    if(not eof(c))then
        read(c,regC)
    else
        regC.codLocalidad:=valorAlto;
end;

procedure Informar(var c:casos);
var
    regC, aux :caso;
    casosMunicipio, casosLocalidad, casosProv:integer;
    i:text;
begin
    reset(c);
    assign(i,'Informe.txt');
    rewrite(i);
    Leer(c,regC);
    casosProv:=0;
    while(regC.codLocalidad<>valorAlto)do begin
        aux.codLocalidad:=regC.codLocalidad;
        aux.nomLocalidad:=regC.nomLocalidad;
        writeln('Nombre ',aux.nomLocalidad);
        casosLocalidad:=0;
        while(aux.codLocalidad=regC.codLocalidad)do begin
            aux.codMunicipio:=regC.codMunicipio;
            aux.nomMunicipio:=regC.nomMunicipio;
            writeln('Nombre ',aux.nomMunicipio);
            casosMunicipio:=0;
            while(aux.codLocalidad=regC.codLocalidad) and (aux.codMunicipio=regC.codMunicipio) do begin
                aux.codHospital:=regC.codHospital;
                aux.nomHospital:=regC.nomHospital;
                aux.cantidad:=0;
                while(aux.codLocalidad=regC.codLocalidad) and (aux.codMunicipio=regC.codMunicipio) and (aux.codHospital=regC.codHospital) do begin
                    aux.cantidad:=aux.cantidad+regC.cantidad;
                    Leer(c,regC);
                end;
                writeln('Nombre ',aux.nomHospital,'....... Cantidad de casos ',aux.cantidad);
                casosMunicipio:=casosMunicipio+aux.cantidad;
            end;
            writeln('Cantidad de casos Municipio ',aux.nomMunicipio,' ',casosMunicipio);
            casosLocalidad:=casosLocalidad+casosMunicipio;
            if(casosMunicipio>1500)then begin
                writeln(i, casosMunicipio);
                writeln(i, aux.nomLocalidad);
                writeln(i, aux.nomMunicipio);
            end;
        end;
        writeln('Cantidad de casos Localidad ',aux.nomLocalidad,' ',casosLocalidad);
        casosProv:=casosProv+casosLocalidad;
    end;
    writeln('Cantidad de casos Totales en la Provincia ',casosProv);
    close(i);
    close(c);
end;

var
    c:casos;
begin
    assign(c,'Casos');
    Informar(c);
end.