{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program practica3ej3;
const
	corteLegajo=0;
type

	datos=record
		legajo:integer;
		codigo:integer;
		nota:integer;
	end;

	infoF=record
		codigo:integer;
		nota:integer;
	end;

	listaF=^nodoF;
	nodoF=record
		elem:infoF;
		sig:listaF;
	end;

	alumnos=record
		legajo:integer;
		finales:listaF;
	end;

	arbol=^nodo;
	nodo=record
		elem:alumnos;
		HI:arbol;
		HD:arbol;
	end;

	datoP=record
		legajo:integer;
		promedio:real;
	end;

	arbolProm=^nodoProm;
	nodoProm=record
		elem:datoP;
		HI:arbolProm;
		HD:arbolProm;
	end;

procedure generarArbol(var a:arbol);

	procedure leerDatos(var d:datos);
	var
		fecha:string;
	begin
		writeln('ingrese el numero de legajo'); readln(d.legajo);
		if(d.legajo<>corteLegajo)then begin
			writeln('ingrese el codigo de materia'); readln(d.codigo);
			writeln('ingrese la fecha'); readln(fecha);
			writeln('ingrese la nota obtenida'); readln(d.nota);
		end;
	end;

	procedure cargarArbol(var a:arbol; d:datos);

		procedure agregarAdelante(var l:listaF; d:datos);
		var
			nue:listaF;
		begin
			new(nue);
			nue^.elem.nota:= d.nota;
			nue^.elem.codigo:= d.codigo;
			nue^.sig:=nil;
			if(l=nil)then l:=nue
			else begin
				nue^.sig:=l;
				l:=nue;
			end;
		end;

	begin
		if(a=nil)then begin
			new(a);
			a^.elem.finales:=nil;
			a^.elem.legajo:=d.legajo;
			agregarAdelante(a^.elem.finales, d);
			a^.HI:=nil;
			a^.HD:=nil;
		end else begin
			if (a^.elem.legajo=d.legajo) then agregarAdelante(a^.elem.finales, d)
			else if (a^.elem.legajo>d.legajo) then cargarArbol(a^.HI, d)
				else cargarArbol(a^.HD, d);
		end;
	end;
var
	d:datos;
begin
	leerDatos(d);
	while(d.legajo <> corteLegajo)do begin
		CargarArbol(a, d);
		writeln('FINAL CARGADO');
		leerDatos(d);
	end;
end;

procedure imprimirEnOrden(a:arbol);

	procedure informar(l:listaF);
	begin
		writeln('///FINALES///');
		while(l<>nil)do begin
			writeln('codigo de materia ' , l^.elem.codigo);
			writeln('nota obtenida ' , l^.elem.nota);
			l:=l^.sig;
		end;
	end;

begin
	if(a<>nil)then begin
		imprimirEnOrden(a^.HI);
		writeln('legajo del alumno ' , a^.elem.legajo);
		informar(a^.elem.finales);
		imprimirEnOrden(a^.HD);
	end;
end;

function cantImpar(a:arbol):integer;
{b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.}
begin
	if(a<>nil)then begin
		if((a^.elem.legajo mod 2) <> 0)then
			cantImpar:= cantImpar(a^.HI) + cantImpar(a^.HD) + 1
		else cantImpar:=cantImpar(a^.HI) + cantImpar(a^.HD);
	end else cantImpar:=0;
end;

procedure finalesAprobados (a:arbol);
{c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).}

	function sumarAprobados (l:listaF):integer;
	begin
		if(l<>nil)then begin
			if(l^.elem.nota >= 4) then
				sumarAprobados:= sumarAprobados(l^.sig) + 1
			else
				sumarAprobados:= sumarAprobados(l^.sig);
		end else sumarAprobados:=0;
	end;

begin
	if(a<>nil)then begin
		finalesAprobados(a^.HI);
		writeln('la cantidad de finales aprobados del alumno ' , a^.elem.legajo , ' es de ' , sumarAprobados(a^.elem.finales));
		finalesAprobados(a^.HD);
	end;
end;

procedure superaProm(a:arbol; v:real; var ap:arbolProm);
{d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

	procedure calcularPromedio(l:listaF; var suma:integer; var cant:integer);
	begin
		if(l<>nil)then begin
			suma:= suma+l^.elem.nota;
			cant:=cant+1;
			calcularPromedio(l^.sig, suma, cant);
		end;
	end;

	procedure agregarNodo(var ap:arbolProm; promedio:real; legajo:integer);
	begin
		if(ap=nil)then begin
			new(ap);
			ap^.elem.promedio:=promedio;
			ap^.elem.legajo:=legajo;
			ap^.HI:=nil; ap^.HD:=nil;
		end else
			if (ap^.elem.legajo >legajo) then agregarNodo(ap^.HI, promedio, legajo)
			else agregarNodo(ap^.HD, promedio, legajo);
	end;

var
	suma, cant:integer;
	prom:real;
begin
	if(a<>nil)then begin
		superaProm(a^.HI, v, ap);
		suma:=0; cant:=0;
		calcularPromedio(a^.elem.finales, suma, cant);
		prom:=suma/cant;
		if (prom > v) then agregarNodo(ap, prom, a^.elem.legajo);
		superaProm(a^.HD, v, ap);
	end;
end;

procedure enOrden(a:arbolProm);
begin
	if (a<>nil) then begin
		enOrden(a^.HI);
		writeln('el promedio del alumno ' , a^.elem.legajo , ' supera el valor ingresado');
		writeln('promedio: ' , a^.elem.promedio:1:2);
		enOrden(a^.HD);
	end;
end;

var
	a:arbol;
	valor:real; ap:arbolProm;
begin {programa principal}
	generarArbol(a);
	imprimirEnOrden(a);
	writeln('la cantidad de alumnos con numero de legajo impar es ' , cantImpar(a));
	finalesAprobados(a);
	ap:=nil;
	writeln('ingrese un promedio'); readln(valor);
	superaProm(a, valor, ap);
	enOrden(ap);
end.

