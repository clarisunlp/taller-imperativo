program practica2ej4;
{Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}
const
	dimF=20;
	maxnum=100;
type
	ArregloEnteros=array [1..dimF] of integer;

procedure CargarVector(var v: ArregloEnteros; i:integer);
var
	num:integer;
begin {caso base: i>dimF}
	if (i<=dimF) then begin
		num:=random(maxnum);
		v[i]:=num;
		CargarVector(v, (i+1));
	end;
end;

procedure ImprimirVector (v:ArregloEnteros);
var
	i:integer;
begin
	for i:=1 to dimF do
		writeln(i , ' ' , v[i]);
end;

function ValorMaximo(v:ArregloEnteros; i:integer):integer;
var
	mayor:integer;
begin {caso base: llegar al final del vector}
	if(i<=dimF)then begin
		writeln(v[i]);
		mayor:=ValorMaximo(v, (i+1)); 
		if (v[i]>mayor) then mayor:=v[i];
		ValorMaximo:=mayor;
	end else
		ValorMaximo:=-1;
end;

function SumaTotal(v:ArregloEnteros; i:integer):integer;
begin {caso base:llegar al final del vector}
	if (i<=dimF) then
		SumaTotal:=v[i]+(SumaTotal(v,(i+1))) {a la función se le asigna el valor de v[i] mas el de la pos siguiente}
	else
		SumaTotal:=0; {cuando llega al último nodo+1, se le asigna 0 y ahora suma sobre esto los elem anteriores}
end; 

var
	v:ArregloEnteros;
	i,total, max:integer;
begin
	Randomize;
	i:=1;
	CargarVector(v, i);
	ImprimirVector(v);
	max:=ValorMaximo(v, i);
	writeln('el valor maximo es ' , max);
	total:=SumaTotal(v, i);
	writeln('la suma de los valores es ' , total);
end.
