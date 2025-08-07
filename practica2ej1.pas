{- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.}
program practica2ej1;
const
	dimF=10;
	fin= '.';
type
	VectorA=array [1..dimF] of char;
	lista=^nodo;
	nodo=record
		elem:char;
		sig:lista;
	end;

procedure CargarVector(var v:VectorA; var dimL:integer);
begin {casos base: dimL=dimF y leer punto}
	if (dimL<dimF) then begin
		dimL:=dimL+1;
		writeln('ingrese un caracter'); readln(v[dimL]);
		if(v[dimL] <> fin) then
			CargarVector(v,dimL);
	end;
end;

procedure ImprimirSecuencial(v:VectorA; dimL:integer);
var
	i:integer;
begin
	for i:= 1 to dimL do
		write(v[i]);
end;

procedure ImprimirRecursivo(v:VectorA; dimL:integer);
begin {caso base: dimL=0}
	if(dimL>0)then begin
		ImprimirRecursivo(v, dimL-1);
		write(v[dimL]);
	end;
end;

function LeerCaracteres (cantD:integer):integer;
var
	car:char;
begin {caso base: car=fin}
	writeln('ingrese un caracter'); readln(car);
	if (car<>fin) then LeerCaracteres:=LeerCaracteres(cantD+1)
	else LeerCaracteres:=cantD+1;
end;

procedure RetornarLista(var l:lista);
begin {caso base: nue^.elem=fin}
	new(l);
	writeln('ingrese un caracter'); readln(l^.elem);
	if (l^.elem<>fin) then RetornarLista(l^.sig)
	else l^.sig:=nil;
end;

procedure ImprimirOrdenado(l:lista);
begin
	write(l^.elem);
	if(l^.sig<>nil)then ImprimirOrdenado(l^.sig);
end;

procedure ImprimirInverso(l:lista);
begin
	if(l^.sig<>nil) then ImprimirInverso(l^.sig);
	writeln(l^.elem);
end;

var
	v:VectorA;
	dimL, CantD:integer;
	l:lista;
begin
	dimL:=0;
	CargarVector(v, dimL);
	ImprimirSecuencial(v, dimL);
	ImprimirRecursivo(v, dimL);
	CantD:=0;
	writeln(LeerCaracteres(CantD));
	l:=nil;
	RetornarLista(l);
	writeln('lista cargada');
	ImprimirOrdenado(l);
	ImprimirInverso(l);
end.
