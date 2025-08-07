{Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}
program practica2ej3;
const
	cortenum=0;
	maxnum=3;
type
	lista=^nodo;
	nodo=record
		elem:integer;
		sig:lista;
	end;

procedure GenerarLista(var l:lista);
var
	num:integer;
begin {caso base: que num sea igual a cortenum}
	num:=random(maxnum); {genero un numero random}
	writeln(num);
	if (num <> cortenum) then begin 
		new(l); l^.elem:=num; {genero un nuevo nodo si num es distinto al corte}
		GenerarLista(l^.sig); {llamo recursivamente al proceso}
	end else
		l:=nil; {cuando num es igual al corte, se asigna nil, y no hay mas elementos para agregar}
end;

function ValorMinimo(l:lista):integer;
var
	menor:integer;
begin {caso base: llegar a nil}
	if(l<>nil)then begin
		menor:=ValorMinimo(l^.sig); {llamo recursivamente a la función y comparo de atrás para adelante}
		if(l^.elem<menor) then menor:=l^.elem; {compara el elem actual con el menor previamente cargado}
		ValorMinimo:=menor;
	end else
		ValorMinimo:=100; {llega hasta el final y se carga con un número muy alto para que al compararlo entre siempre}
end; 

function ValorMaximo(l:lista):integer;
var
	mayor:integer;
begin
	if (l<>nil) then begin
		mayor:= ValorMaximo(l^.sig);
		if (l^.elem > mayor) then mayor:=l^.elem;
		ValorMaximo:=mayor;
	end else ValorMaximo:=-1;
end;

function seEncuentra (l:lista; num:integer):boolean;
begin {casos base: que se termine la lista o que encuentre el numero}
	if (l<>nil) then begin
		if(l^.elem = num) then seEncuentra:=true {cuando se encuentra el num termina la búsqueda}
		else seEncuentra:=seEncuentra(l^.sig, num)
	end else
		seEncuentra:=false; {llegó al final de la lista, por lo tanto no lo encontró}
end;

var
	l:lista;
	numero:integer;
begin
	Randomize;
	l:=nil;
	GenerarLista(l);
	writeln('lista cargada');
	if (l<>nil) then begin
		writeln('el valor minimo es ' , ValorMinimo(l));
		writeln('el valor maximo es ' , ValorMaximo(l));
		writeln('ingrese un numero a buscar'); readln(numero);
		writeln(seEncuentra(l, numero));
	end;
end.
