{- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program practica1ej2.pas;
const
	dimF= 300;
	corteCod=-1;
type
	info=record
		codigo:integer;
		dni:integer;
		valor:real;
	end;

	oficinas=array [1..dimF] of info;

procedure GenerarVector(var v:oficinas; var dimL:integer);
var
	unCodigo:integer;
begin
	dimL:=0;
	writeln('ingese el codigo de identificacion'); readln(unCodigo);
	while(unCodigo <> corteCod) do begin
		dimL:=dimL+1;
		v[dimL].codigo:=unCodigo;
		writeln('ingrese el DNI del propietario'); readln(v[dimL].dni);
		writeln('ingrese el valor de la expensa'); readln(v[dimL].valor);
		writeln('ingese el codigo de identificacion'); readln(unCodigo);
	end;
end;
procedure Insercion(var v:oficinas; dimL:integer);
var
	i, j, actCod: integer; actRecord:info;
begin
	for i:= 2 to dimL do begin
		actCod:= v[i].codigo; actRecord:= v[i];
		j:= i-1;
		while(j>0) and (v[j].codigo>actCod) do begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= actRecord;
	end;
end;

procedure Seleccion (var v:oficinas; dimL:integer);
var
	i,j,pos: integer; item: info;
begin
	for i:= 1 to dimL-1 do begin
		pos:= i;
		for j:= i+1 to dimL do
			if(v[j].codigo < v[pos].codigo) then pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;
{procedure Imprimir(v:oficinas; dimL: integer);
var
	i:integer;
begin
	for i:= 1 to dimL do begin
		writeln('codigo: ' , v[i].codigo);
		writeln('dni: ' , v[i].dni);
		writeln('valor: ' , v[i].valor);
	end;
end;}
var
	v:oficinas; dimL:integer;
begin
	GenerarVector(v, dimL);
	//Imprimir(v, dimL);
	Insercion(v, dimL);
	Seleccion(v, dimL);
	{writeln('valores ordenados');
	Imprimir(v, dimL);}
end.
