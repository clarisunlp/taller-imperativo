{ Un supermercado requiere el procesamiento de sus productos. De cada producto se
 conoce código, rubro (1..10), stock y precio unitario. Se pide:
 a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
 vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
 más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
 b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
 de producto y retorne si dicho código existe o no para ese rubro.
 c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
 rubro, el código y stock del producto con mayor código.
 d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
 retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
 ingresados.}
 
program practica5ej3;
const
	dimF=10;
	cortecod=0;
type

	rangoRubros=1..dimF;

	info=record
		codigo:integer;
		stock:integer;
	end;

	arbol=^nodo;
	nodo=record
		elem:info;
		HI:arbol;
		HD:arbol;
	end;

	rubros= array [1..dimF] of arbol;
	maxCod=array [1..dimF] of info;

procedure inicializarVector(var v:rubros);
var
	i:integer;
begin
	for i:=1 to dimF do v[i]:=nil;
end;

procedure generarEstructura(var v:rubros);
{Generar una estructura adecuada que permita agrupar los productos por rubro. A su
 vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
 más eficiente posible. El ingreso finaliza con el código de producto igual a 0.}
 
	procedure leerDatos(var d:info; var r:rangoRubros);
	begin
		d.codigo:=random(10);
		d.stock:=random(10);
		r:=random(10)+1;
	end;


	procedure agregarNodo(var a:arbol; d:info);
	begin
		if(a=nil)then begin
			new(a); a^.HI:=nil; a^.HD:=nil; a^.elem:=d;
		end else begin
			if(a^.elem.codigo>d.codigo)then agregarNodo(a^.HI, d)
			else agregarNodo(a^.HD, d);
		end
	end;


var
	d:info;
	r:rangoRubros;
begin
	leerDatos(d, r);
	writeln(r);
	while(d.codigo<>cortecod)do begin
		agregarNodo(v[r], d);
		leerDatos(d, r);
		writeln(d.codigo);
	end;
end;

procedure imprimirVector(v:rubros);

	procedure imprimirArbol(a:arbol);
	begin
		if(a<>nil)then begin
			imprimirArbol(a^.HI);
			writeln('STOCK ' , a^.elem.stock);
			writeln('CODIGO ' , a^.elem.codigo);
			imprimirArbol(a^.HD);
		end;
	end;

var
	i:integer;
begin
	for i:=1 to dimF do
		if (v[i]<>nil) then begin
			writeln('//RUBRO// ' , i);
			imprimirArbol(v[i]);
		end;
end;

function incisoB(a:arbol; cod:integer):integer;
begin
	if(a<>nil)then begin
		if(a^.elem.codigo=cod)then incisoB:=incisoB(a^.HI, cod)+incisoB(a^.HD, cod)+1
		else if(a^.elem.codigo>cod)then incisoB:=incisoB(a^.HI, cod)
			else incisoB:=incisoB(a^.HD, cod);
	end else incisoB:=0;
end;

var
	v:rubros; vM:maxCod;
	unCodigo:integer;
	unRubro:rangoRubros;
begin
	randomize;
	inicializarVector(v);
	generarEstructura(v);
	imprimirVector(v);
	writeln('ingrese un rubro '); readln(unRubro);
	writeln('ingrese un codigo '); readln(unCodigo);
	writeln('la cantidad de codigos ' , unCodigo , ' que hay en el rubro ' , unRubro , ' es ' , incisoB(v[unRubro], unCodigo));
	incisoC(v, vM);
end.
