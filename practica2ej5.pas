program practica2ej5;
{Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el
siguiente encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}
const
	dimF=10;
type
	indice=-1..dimF;
	vector=array[1..dimF] of integer;

procedure CargarVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimF do v[i]:= i;
end;

procedure ImprimirVector(v:vector);
var
	i:integer;
begin
	for i:= 1 to dimF do
		writeln(v[i]);
end;

Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
var
	medio:indice;
begin {caso base: terminar el vector (ini>fin) o encontar el elemento (v[pos]=dato)}
	if(ini<=fin)then begin
		medio:= (ini+fin) div 2; 
		if (v[medio] = dato) then pos:=medio
		else if (dato<v[medio]) then busquedaDicotomica(v, ini, (medio-1), dato, pos)
			else busquedaDicotomica(v,(medio+1), fin, dato, pos)
	end else pos:=-1;
end;

var
	v:vector;
	pos:indice;
	dato:integer;
begin
	CargarVector(v);
	ImprimirVector(v);
	writeln('ingrese un numero'); readln(dato);
	busquedaDicotomica(v, 1, dimF, dato, pos);
	writeln(pos);
end.


