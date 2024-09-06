{ Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
 se ingresa código, DNI de la persona, año y tipo de reclamo. El ingreso finaliza con el
 código de igual a 0. Se pide:
 a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
 se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
 b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
 reclamos efectuados por ese DNI.
 c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
 reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
 d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
 los reclamos realizados en el año recibido.}
 
program practica5ej4;
const
	cortecod=0;
type

	datos=record
		anio:integer;
		codigo:integer;
	end;

	lista=^nodoL;
	nodoL=record
		elem:datos;
		sig:lista;
	end;
	
	info=record
		DNI:integer;
		reclamos:lista;
		cantidad:integer;
	end;

	arbol=^nodoA;
	nodoA=record
		elem:info;
		HI:arbol;
		HD:arbol;
	end;

	lectura=record
		codigo:integer;
		DNI:integer;
		anio:integer;
	end;


procedure generarArbol(var a:arbol);

	procedure leerDatos(var d:lectura);
	begin
		readln(d.codigo);
		if (d.codigo<>cortecod) then begin
			readln(d.DNI);
			readln(d.anio);
		end;
	end;

	procedure cargarArbol(var a:arbol; d:lectura);
	
		procedure agregarAdelante(var l:lista; d:lectura);
		var
			nue:lista;
		begin
			new(nue); nue^.sig:=nil;
			nue^.elem.anio:=d.anio; nue^.elem.codigo:=d.codigo;
			if(l<>nil)then nue^.sig:=l;
			l:=nue;
		end;
	
	begin
		if(a=nil)then begin
			new(a); a^.HI:=nil; a^.HD:=nil;
			a^.elem.DNI:=d.DNI; a^.elem.reclamos:=nil; a^.elem.cantidad:=1;
			agregarAdelante(a^.elem.reclamos, d);
		end else begin
			if(a^.elem.DNI=d.DNI)then agregarAdelante(a^.elem.reclamos, d)
			else if (a^.elem.DNI>d.DNI) then cargarArbol(a^.HI, d)
				else cargarArbol(a^.HD, d);
		end;
	end;

var
	d:lectura;
begin
	leerDatos(d);
	while(d.codigo<>cortecod)do begin
		cargarArbol(a, d);
		leerDatos(d);
	end;
end;
	
var
	a:arbol;
begin
	a:=nil;
	generarArbol(a);



end.
