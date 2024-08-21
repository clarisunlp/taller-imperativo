{ Se desea procesar la información de las ventas de productos de un comercio (como máximo
50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el
día de la venta, código del producto (entre 1 y 15) y cantidad vendida (como máximo 99
unidades). El código debe generarse automáticamente (random) y la cantidad se debe leer. El
ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos
valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a
mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).}

program practica1ej1;
const
	dimF= 50;
type
	rangoProductos= 1..15;
	rangoCantidad= 1..99;

	ventas=record
		dia: integer;
		codproducto:rangoProductos;
		cantidad:rangoCantidad;
	end;
	pares=record
		cod:rangoProductos;
		cant:integer;
	end;

	infoventas=array [1..dimF] of ventas;
	vectorIncG=array [rangoProductos] of pares;

procedure RetornarVentas(var v: infoventas; var dimL: integer);
	procedure LeerDatos(var v: infoventas; i:integer);
	var
		undia: integer;
	begin
		writeln('ingrese el dia de venta'); readln(undia);
		if(undia <> 0) then begin
			v[i].dia:=undia;
			writeln('ingrese la cantidad de productos'); readln(v[i].cantidad);
			Randomize;
			v[i].codproducto:= Random(15)+1;
		end;
	end;
var
	i:integer;
begin
	dimL:=0; i:=1;
	LeerDatos(v, i);
	while ((v[i].dia <> 0) and (dimL < dimF)) do begin
		dimL:=dimL+1; i:= i+1;
		LeerDatos(v, i);
	end;
end;

procedure MostrarInfo(v: infoventas; dimL: integer);
var
	i:integer;
begin
	for i := 1 to dimL do begin
		writeln('venta ' , i);
		writeln('dia ' , v[i].dia);
		writeln('codigo de venta ' , v[i].codproducto);
		writeln('cantidad vendida ' , v[i].cantidad);
	end;
end;

procedure OrdenarVector(var v: infoventas; dimL: integer);
var
	i, j: integer;
	act:rangoProductos; actualrecord:ventas;
begin
	for i:=2 to dimL do begin
		act:= v[i].codproducto; actualrecord:=v[i];
		j:= i-1;
		while (j>0) and (v[j].codproducto>act) do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actualrecord;
	end;
end;

procedure EliminarVentas(var v: infoventas; var dimL: integer);
	procedure BuscarPosiciones(inf:rangoProductos; sup:rangoProductos; v:infoventas; dimL:integer; var posInicial:rangoProductos; var posFinal:rangoProductos; var existe:boolean);
	var
		i:integer;
	begin
		i:=1; existe:=true;
		while ((i<=dimL) and (v[i].codproducto<inf)) do i:=i+1;
		if (i<=dimL) and (v[i].codproducto=inf) then posInicial:= i else existe:=false;
		if existe then begin
			while ((i<dimL) and (v[i].codproducto<sup)) do i:=i+1;
			posFinal:= i;
		end;
	end;
var
	paramInf, paramSup: rangoProductos;
	posInicial, posFinal: rangoProductos;
	existe: boolean; i:integer; p:rangoProductos;
begin
	writeln('ingrese el parametro inferior'); readln(paramInf);
	writeln('ingrese el parametro superior'); readln(paramSup);
	BuscarPosiciones(paramInf, paramSup, v, dimL, posInicial, posFinal, existe);
	if existe then begin
		p:=posInicial;
		if (posFinal<dimL) then begin
			for i:=posFinal+1 to dimL do begin
				v[p]:=v[i];
				p:=p+1;
			end;
		end;
		dimL:= dimL-(posFinal-posInicial+1);
	end else writeln('no hay elementos cargados con codigo entre esos valores');
end;
procedure InfoCodigoPar(var vg:VectorIncG; v:infoventas; dimL:integer; var dimLvg: integer);
	procedure InicializarVector (var vg: VectorIncG);
	var
		i:integer;
	begin
		for i:= 1 to 15 do
			vg[i].cant:=0;
	end;
var
	i, j:integer; codactual: rangoProductos;
begin
	writeln('procesando los codigos pares');
	InicializarVector(vg);
	i:=1; j:= 1;
	while (i <= dimL) do begin
		if (v[i].codproducto mod 2 = 0) then begin
			//writeln('procesando codigo par');
			codactual:= v[i].codproducto;
			while (i <= dimL) and (v[i].codproducto = codactual) do begin
				vg[j].cod:= codactual; 
				vg[j].cant:=vg[j].cant+v[i].cantidad;
				i:=i+1; //writeln('avanzando');
			end;
			j:=j+1;
			dimLvg:=dimLvg+1;
		end else i:=i+1;
	end;
end;
procedure Imprimir (v: VectorIncG; dimL: integer);
var
	i:integer;
begin
	writeln('codigos pares:');
	for i:= 1 to dimL do begin
		writeln('codigo ' , v[i].cod);
		writeln('cantidad ' , v[i].cant);
	end;
end;
var
	v:infoventas; vg:VectorIncG;
	dimL: integer; dimLvg:integer;
begin
	RetornarVentas(v, dimL);
	MostrarInfo(v, dimL);
	OrdenarVector(v, dimL);
	MostrarInfo(v, dimL);
	EliminarVentas(v, dimL);
	MostrarInfo(v, dimL);
	dimLvg:= 0;
	InfoCodigoPar(vg, v, dimL, dimLvg);
	Imprimir(vg, dimLvg);
end.
