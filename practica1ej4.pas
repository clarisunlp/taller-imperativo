{Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).}

program practica1ej4;
const
	rubroIncC=3;
	maxrubro=8;
	corteprecio=0;
	dimF=30;
type
	rubros=1..maxrubro;

	info=record
		codigo:integer;
		rubro:rubros;
		precio:real;
	end;

	lista=^nodo;
	nodo=record
		elem:info;
		sig:lista;
	end;

	productos= array [rubros] of lista;

	rubroVec= array [1..dimF] of info;

procedure InicializarVector(var v:productos);
var
	i:integer;
begin
	for i:=1 to maxrubro do
		v[i]:=nil;
end;

procedure CargarVector(var v: productos);
	procedure LeerDatos(var d:info);
	begin
		writeln('ingrese el precio del producto'); readln(d.precio);
		if(d.precio<>corteprecio) then begin
			writeln('ingrese el codigo del producto'); readln(d.codigo);
			writeln('ingrese el rubro (1..8)'); readln(d.rubro);
		end;
	end;
	procedure InsertarOrdenado(d:info; var l:lista);
	var
		nue, act, ant:lista;
	begin
		new(nue); nue^.elem:=d; nue^.sig:=nil; //writeln('nodo creado');
		if(l=nil)then
			l:=nue
		else begin
			act:=l;
			while (act <> nil) and (act^.elem.codigo < nue^.elem.codigo) do begin
				ant:=act;
				act:=act^.sig;
			end;
			if(act=l)then begin
				nue^.sig:=l;
				l:=nue;
			end else begin
				ant^.sig:=nue;
				nue^.sig:=act;
			end;
		end;
		//writeln('nodo insertado');
	end;
var
	d:info;
begin
	LeerDatos(d);
	while (d.precio <> corteprecio) do begin
		InsertarOrdenado(d, v[d.rubro]);
		LeerDatos(d);
	end;
end;
procedure MostrarInfo(v:productos);
var
	i:integer;
begin

	for i:= 1 to maxrubro do begin
		while (v[i]<>nil) do begin
			writeln('rubro ' , i , ', codigo ' , v[i]^.elem.codigo);
			v[i]:=v[i]^.sig;
		end;
	end;
end;
procedure GenerarVector (var vr:rubroVec; l:lista; var dimL:integer);
begin
	dimL:=0;
	while((l<>nil) and (dimL<dimF)) do begin
		dimL:=dimL+1;
		vr[dimL]:=l^.elem;
		l:=l^.sig;
	end;
end;
procedure OrdenarVector(var v:rubroVec; dimL:integer);
var
	i,j,pos:integer; item:info;
begin
	for i:= 1 to dimL-1 do begin
		pos:=i;
		for j:= i+1 to dimL do
			if(v[j].precio < v[pos].precio) then pos:=j;
		item:=v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;
procedure ImprimirVector(v:rubroVec; dimL:integer);
var
	i:integer;
begin
	for i:= 1 to dimL do
		writeln('precio ' , v[i].precio);
end;
function CalcularPromedio(v:rubroVec; dimL:integer):real;
var
	i:integer; tot:real;
begin
	tot:=0;
	for i:= 1 to dimL do
		tot:=tot+v[i].precio;
	CalcularPromedio:= tot / dimL;
end;

var
	v:productos; vecRubro: rubroVec;
	dimL:integer; promedio:real;
begin
	InicializarVector(v);
	CargarVector(v);
	MostrarInfo(v);
	GenerarVector(vecRubro, v[rubroIncC], dimL);
	OrdenarVector(vecRubro, dimL);
	ImprimirVector(vecRubro, dimL);
	promedio:=CalcularPromedio(vecRubro, dimL);
	writeln('precio promedio ' , promedio);
end.
