{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.
d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.}
program practia3ej2;
const
	cortecod=0;
type
	ventas=record
		codigo:integer;
		fecha:string;
		cantidad:integer;
	end;

	arbol=^nodo;
	nodo=record
		elem:ventas;
		HI:arbol;
		HD:arbol;
	end;

	ventasii=record
		codigo:integer;
		cantidad:integer;
	end;

	arbol_ii=^nodoii;
	nodoii=record
		elem:ventasii;
		HI:arbol_ii;
		HD:arbol_ii;
	end;

	ventasV=record
		fecha:string;
		cantidad:integer;
	end;

	Vlista=^nodoV;
	nodoV=record
		elem:ventas;
		sig:Vlista
	end;

	ventasiii=record
		codigo:integer;
		listaV:Vlista;
	end;

	arbol_iii=^nodoiii;
	nodoiii=record
		elem:ventasiii;
		HI:arbol_iii;
		HD:arbol_iii;
	end;

procedure IncisoA(var ai:arbol; var aii:arbol_ii; var aiii:arbol_iii);

		procedure CargarRegistro(var d:ventas);
		var
			vFechas:array [0..5] of string= ('01/01', '02/01', '03/01', '04/01', '05/01', '06/01');
		begin
				d.codigo:=random(10);
				d.fecha:=vFechas[random(6)];
				d.cantidad:=random(99);
		end;

		procedure CargarArboli(var ai:arbol; d:ventas);
		begin
			if(ai=nil)then begin
				new(ai);
				ai^.elem:=d;
				ai^.HI:=nil;
				ai^.HD:=nil;
			end else
				if (ai^.elem.codigo>d.codigo) then CargarArboli(ai^.HI, d)
				else CargarArboli(ai^.HD, d);
		end;

		procedure CargarArbolii(var aii:arbol_ii; d:ventasii);
		begin
			if (aii=nil) then begin
				new(aii);
				aii^.elem:=d;
				aii^.HI:=nil;
				aii^.HD:=nil;
			end else
				if(aii^.elem.codigo=d.codigo)then
					aii^.elem.cantidad:=aii^.elem.cantidad+d.cantidad
				else
					if (aii^.elem.codigo>d.codigo) then CargarArbolii(aii^.HI, d)
					else CargarArbolii(aii^.HD, d);
		end;

		procedure CargarArboliii(var aiii:arbol_iii; d:ventas);
			procedure agregarAdelante (var l:Vlista; fecha:string; cant:integer);
			var
				nue:Vlista;
			begin
				new(nue);
				nue^.elem.fecha:= fecha;
				nue^.elem.cantidad:=cant;
				nue^.sig:=nil;
				if(l=nil)then l:=nue
				else begin
					nue^.sig:=l;
					l:=nue;
				end;
			end;
		begin
			if (aiii=nil) then begin
				new(aiii);
				aiii^.elem.listaV:=nil;
				aiii^.elem.codigo:=d.codigo;
				aiii^.HI:=nil;
				aiii^.HD:=nil;
				agregarAdelante(aiii^.elem.listaV, d.fecha, d.cantidad);
			end else
				if(aiii^.elem.codigo=d.codigo)then
					agregarAdelante(aiii^.elem.listaV, d.fecha, d.cantidad)
				else
					if (aiii^.elem.codigo>d.codigo) then CargarArboliii(aiii^.HI, d)
					else CargarArboliii(aiii^.HD, d);
		end;

	var
		datoi:ventas;
		datoii:ventasii;
	begin
		ai:=nil; aii:=nil; aiii:=nil;
		CargarRegistro(datoi);
		writeln(datoi.codigo);
		while(datoi.codigo<>cortecod)do begin
			CargarArboli(ai,datoi);
			datoii.codigo:=datoi.codigo; datoii.cantidad:=datoi.cantidad;
			CargarArbolii(aii,datoii);
			CargarArboliii(aiii,datoi);
			CargarRegistro(datoi);
			writeln(datoi.codigo);
		end;
	end;
{procedure ImprimirArbol(a:arbol_iii);
begin
	if(a<>nil)then begin
		ImprimirArbol(a^.HI);
		writeln('codigo ' , a^.elem.codigo);
		while(a^.elem.listaV <> nil)do begin
			writeln('fecha ' , a^.elem.listaV^.elem.fecha);
			writeln('unidades ' , a^.elem.listaV^.elem.cantidad);
			a^.elem.listaV:=a^.elem.listaV^.sig;
		end;
		ImprimirArbol(a^.HD);
	end;
end;}

function IncisoB(a:arbol; fecha:string):integer;
{b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.}
begin
	if(a<>nil)then
		if (a^.elem.fecha = fecha) then
			IncisoB:= IncisoB(a^.HI, fecha) + a^.elem.cantidad + IncisoB(a^.HD, fecha)
		else 
			IncisoB:=IncisoB(a^.HI, fecha) + IncisoB(a^.HD, fecha)
	else
		IncisoB:=0;
end;

var
	ai:arbol; fecha:string;
	aii:arbol_ii;
	aiii:arbol_iii;
begin
	randomize;
	IncisoA(ai,aii,aiii);
	//ImprimirArbol(aiii);
	writeln('ingrese una fecha'); readln(fecha);
	writeln('la cantidad de ventas en la fecha ' , fecha , 'es de ' , IncisoB(ai, fecha));
end.
