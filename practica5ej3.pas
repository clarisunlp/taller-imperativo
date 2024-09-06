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
	productos=array[1..dimF] of integer;

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

procedure incisoC(v: rubros; var vM:maxCod);
{Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.}

	procedure inicializarVectorM(vM:maxCod);
	var
		i:integer;
	begin
		for i:=1to dimF do begin 
			vM[i].codigo:=0; vM[i].stock:=0;
		end;
	end;

	procedure buscarMaximo(a:arbol; var cod:integer; var stock:integer);
	begin
		if (a^.HD<>nil) then buscarMaximo(a^.HD, cod, stock);
		cod:=a^.elem.codigo; stock:=a^.elem.stock;
	end;
	
	procedure cargarDatos(var d:info; cod:integer; stock:integer);
	begin
		d.codigo:=cod;
		d.stock:=stock;
	end;

var
	i, codM, stockM:integer; 
begin
	inicializarVectorM(vM);
	for i:=1 to dimF do begin
		if (v[i]<>nil) then begin
			buscarMaximo(v[i], codM, stockM);
			cargarDatos(vM[i], codM, stockM);
		end;
	end;
end;
	
procedure imprimirVectorM(vM:maxCod);
var
	i:integer;
begin
	for i:=1 to dimF do begin
		if(vM[i].codigo<>0)then begin
			writeln('RUBRO: ' , i);
			writeln('MAYOR CODIGO ' , vM[i].codigo);
			writeln('STOCK ' , vM[i].stock);
		end;
	end;
end;
		
procedure incisoD(v:rubros; var vP:productos);

	function contarStock(a:arbol):integer;
	begin
		if(a<>nil)then contarStock:=contarStock(a^.HD)+contarStock(a^.HI)+a^.elem.stock
		else contarStock:=0;
	end;

var
	i:integer;
begin	
		for i:=1 to dimF do vP[i]:= contarStock(v[i]);
end;

procedure imprimirVectorP(vP:productos);
var
	i:integer;
begin
	for i:=1 to dimF do writeln('STOCK DEL RUBRO ' , i , ': ' , vP[i]);
end;
			
var
	v:rubros; vM:maxCod; vP:productos;
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
	incisoC(v, vM); //imprimirVectorM(vM);
	incisoD(v, vP); //imprimirVectorP(vP);
end.
