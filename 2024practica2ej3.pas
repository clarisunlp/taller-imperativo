{Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}

program practica2ej3;
const
	dimF=20;
	min=300;
	max=1550;
type
	indice=-1..dimF;

	vector=array[1..dimF]of integer;

procedure GenerarVector(var v:vector);
	procedure CargarVector(var v:vector; var i:integer);
	begin
		if(i<=dimF) then begin
			v[i]:= random(max-min+1)+min;
			i:=i+1;
			CargarVector(v, i);
		end;
	end;
var
	i:integer;
begin
	i:=1;
	CargarVector(v, i);
end;

procedure OrdenarVector(var v:vector);
var
	i,j,pos: integer; item:integer;
begin
	for i:= 1 to dimF-1 do begin
		pos:= i;
		for j:= i+1 to dimF do
			if(v[j] < v[pos]) then pos:= j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;

procedure busquedaDicotomica(v: vector; ini,fin: indice; dato:integer; var pos: indice);
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
begin {programa principal}
	randomize;
	GenerarVector(v);
	OrdenarVector(v);
	writeln('ingrese un numero'); readln(dato);
	busquedaDicotomica(v, 1, dimF, dato, pos);
end.
