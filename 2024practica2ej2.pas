{Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}
program practica2;
const
	max=200;
	min=100;
type
	
	lista=^nodo;
	nodo=record
		elem:integer;
		sig:lista;
	end;

procedure GenerarLista (var l:lista);
var
	num:integer;
begin
	num:=random(max-min+1)+min;
	if(num<>100)then begin
		new(l); l^.elem:=num;
		GenerarLista(l^.sig)
	end else
	l:=nil;
end;

procedure ImprimirOrdenado (l:lista);
begin
		writeln(l^.elem);
		if(l^.sig<>nil)then ImprimirOrdenado(l^.sig);
end;

procedure ImprimirInverso (l:lista);
begin
	if(l^.sig<>nil)then ImprimirInverso(l^.sig);
	writeln(l^.elem);
end;

function ValorMinimo(l:lista):integer;
var
	menor:integer;
begin
	if(l<>nil)then begin
		menor:=ValorMinimo(l^.sig); {llamo recursivamente a la función y comparo de atrás para adelante}
		if(l^.elem<menor) then menor:=l^.elem; {compara el elem actual con el menor previamente cargado}
		ValorMinimo:=menor;
	end else
		ValorMinimo:=999; {llega hasta el final y se carga con un número muy alto para que al compararlo entre siempre}
end;

function seEncuentra(l:lista; num:integer):boolean;
begin {casos base: que se termine la lista o que encuentre el numero}
	if (l<>nil) then begin
		if(l^.elem = num) then seEncuentra:=true {cuando se encuentra el num termina la búsqueda}
		else seEncuentra:=seEncuentra(l^.sig, num)
	end else
		seEncuentra:=false; {llegó al final de la lista, por lo tanto no lo encontró}
end;

var
	l:lista;
	minimo, num:integer;
	existe:boolean;
begin {programa principal}
	randomize;
	l:=nil;
	GenerarLista(l);
	ImprimirOrdenado(l);
	ImprimirInverso(l);
	minimo:=ValorMinimo(l);
	writeln('el valor minimo de la lista es ' , minimo);
	writeln('ingrese un valor a buscar'); readln(num);
	existe:=seEncuentra(l, num);
	if (existe) then writeln('el valor ' , num , ' se encuentra en la lista')
	else writeln('el valor ' , num , ' no se encuentra en la lista');
end.
