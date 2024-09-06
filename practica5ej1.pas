{El administrador de un edificio de oficinas tiene la información del pago de las expensas
 de dichas oficinas. Implementar un programa con:
 a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
 administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
 propietario y valor de la expensa. La lectura finaliza cuando llega el código de
 identificación 0.
 b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
 código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
 vistos en la cursada.
 c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
 generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
 retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
 Luego el programa debe informar el DNI del propietario o un cartel indicando que no
 se encontró la oficina.
 d) Unmódulo recursivo que retorne el monto total de las expensas.}
 
program practica5ej1;
const
	dimF=300;
	corteid=0;
type
	infoE=record
		codigo:integer;
		DNI:integer;
		valor:real;
	end;

	pagoExpensas=array[1..dimF] of infoE;

procedure retornarVector(var v:pagoExpensas; var dimL:integer);
{ a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
 administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
 propietario y valor de la expensa. La lectura finaliza cuando llega el código de
 identificación 0.}

	procedure leerDatos(var d:infoE);
	begin
		writeln('ingrese un codigo de identificacion'); readln(d.codigo);
		if(d.codigo<>corteid)then begin
			writeln('ingrese el DNI del propietario'); readln(d.DNI);
			writeln('ingrese el valor de la expensa'); readln(d.valor);
		end;
	end;

var
	d:infoE;
begin
	leerDatos(d);
	while ((d.codigo<>corteid) and (dimL<=dimF)) do begin
		dimL:=dimL+1;
		v[dimL]:=d;
		writeln('DATOS CARGADOS');
		leerDatos(d);
	end;
end;


procedure ordenarVector(var v:pagoExpensas; dimL:integer);
{b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
 código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
 vistos en la cursada.}
var
	i,j,pos:integer; elem:infoE;
begin
	for i:= 1 to (dimL-1) do begin
		pos:=i;
		for j:= i+1 to dimL do 
			if (v[j].codigo < v[pos].codigo) then pos:=j;
		elem:= v[pos];
		v[pos]:=v[i];
		v[i]:=elem;
	end;
end;

procedure imprimirVector(v:pagoExpensas; dimL:integer);
var i:integer;
begin
	for i:=1 to dimL do begin
		writeln('CODIGO: ' , v[i].codigo);
		writeln('DNI: ' , v[i].DNI);
		writeln('VALOR: ' , v[i].valor:1:2);
	end;
end;

function busquedaDicotomica(v:pagoExpensas; inf:integer; dimL:integer; cod:integer):integer;
{c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
 generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
 retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
 Luego el programa debe informar el DNI del propietario o un cartel indicando que no
 se encontró la oficina.}
var
	medio:integer;
begin
	medio:= (dimL+inf) div 2;
	if(dimL>=inf)then begin
		if(v[medio].codigo = cod)then busquedaDicotomica:=medio
		else if(v[medio].codigo > cod)then busquedaDicotomica:= busquedaDicotomica(v,inf,(medio-1),cod)
			else busquedaDicotomica:= busquedaDicotomica(v,(medio+1),dimL,cod);
	end else busquedaDicotomica:=0;
end;

function calcularTotal(v:pagoExpensas; dimL:integer):real;
begin
	if (dimL>0) then calcularTotal:=calcularTotal(v, dimL-1)+v[dimL].valor
	else calcularTotal:=0;
end;

var
	v:pagoExpensas; dimL:integer;
	unCodigo, inf:integer;
begin
	dimL:=0;
	retornarVector(v, dimL);
	writeln('VECTOR RETORNADO');
	imprimirVector(v, dimL);
	ordenarVector(v, dimL);
	writeln('VECTOR ORDENADO');
	imprimirVector(v, dimL);
	inf:=1;
	writeln('ingrese un codigo de identificacion a buscar'); readln(unCodigo);
	writeln(busquedaDicotomica(v, inf, dimL,unCodigo));
	writeln('el monto total de las expensas es ' , calcularTotal(v,dimL):1:2);
end.
