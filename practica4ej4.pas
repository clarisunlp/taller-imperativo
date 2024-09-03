{Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}

program practica4ej4;
const
	corteISBN=0;
type

	dias= 1..31;
	meses=1..12;

	infoi=record
		ISBN:integer;
		numero:integer;
		dia:dias;
		mes:meses;
		cantidad:integer;
	end;

	arboli=^nodoi;
	nodoi=record
		elem:infoi;
		HI:arboli;
		HD:arboli;
	end;

	infoP=record
		numero:integer;
		dia:dias;
		mes:meses;
		cantidad:integer;
	end;

	prestamos=^nodoP;
	nodoP=record
		elem:infoP;
		sig:prestamos;
	end;

	infoii=record
		ISBN:integer;
		listaP:prestamos;
	end;

	arbolii=^nodoii;
	nodoii=record
		elem:infoii;
		HI:arbolii;
		HD:arbolii;
	end;

procedure cargarArboles(var ai:arboli; var aii:arbolii);
{a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.}

	procedure leerDatos(var d:infoi);
	begin
		{writeln('ingrese el ISBN');} d.ISBN:=random(10); //readln(d.ISBN);
		{writeln('ingrese el numero de socio');} d.numero:= random(10);//readln(d.numero);
		{writeln('ingrese el dia del prestamo');} d.dia:=random(30)+1; //readln(d.dia);
		{writeln('ingrese el mes del prestamo');} d.mes:=random(11)+1;  //readln(d.mes);
		{writeln('ingrese la cantidad de dias prestados');} d.cantidad:=random(10); //readln(d.cantidad);
	end;

	procedure cargarArboli(var ai:arboli; d:infoi);
	begin
		if (ai=nil) then begin
			new(ai); ai^.HI:=nil; ai^.HD:=nil;
			ai^.elem:=d;
		end else begin
			if(ai^.elem.ISBN>d.ISBN)then cargarArboli(ai^.HI, d)
			else cargarArboli(ai^.HD, d);
		end;
	end;

	procedure cargarArbolii(var aii:arbolii; d:infoi);

		procedure agregarAdelante(var l:prestamos; d:infoi);
		var
			nue:prestamos;
		begin
			new(nue); nue^.sig:=nil;
			nue^.elem.numero:=d.numero; nue^.elem.dia:=d.dia;
			nue^.elem.mes:= d.mes; nue^.elem.cantidad:=d.cantidad;
			if (l<>nil) then nue^.sig:=l;
			l:=nue;
		end;

	begin
		if (aii=nil) then begin
			new(aii); aii^.HI:=nil;; aii^.HD:=nil;
			aii^.elem.listaP:=nil;
			aii^.elem.ISBN:=d.ISBN;
			agregarAdelante(aii^.elem.listaP, d);
		end else begin
			if (aii^.elem.ISBN=d.ISBN) then agregarAdelante(aii^.elem.listaP, d)
			else if (aii^.elem.ISBN>d.ISBN) then cargarArbolii(aii^.HI, d)
				else cargarArbolii(aii^.HD, d);
		end;
	end;

var
	d:infoi;
begin
	ai:=nil; aii:=nil;
	leerDatos(d);
	while (d.ISBN <> corteISBN) do begin
		writeln(d.ISBN);
		cargarArboli(ai, d);
		cargarArbolii(aii, d);
		leerDatos(d);
	end;
	writeln(d.ISBN);
end;

procedure enOrdeni(a:arboli);
begin
	if(a<>nil)then begin
		enOrdeni(a^.HI);
		writeln('ISBN ' , a^.elem.ISBN);
		writeln('numero de socio ' , a^.elem.numero);
		writeln('dia del prestamo ' , a^.elem.dia);
		writeln('mes del prestamo' , a^.elem.mes);
		writeln('cantidad de dias del prestamo ' , a^.elem.cantidad);
		enOrdeni(a^.HD);
	end;
end;

procedure enOrdenii(a:arbolii);

	procedure imprimirLista(l:prestamos);
	begin
		if(l<>nil)then begin
			writeln('numero de socio ' , l^.elem.numero);
			writeln('dia del prestamo ' , l^.elem.dia);
			writeln('mes del prestamo ' , l^.elem.mes);
			writeln('cantidad de dias del prestamo ' , l^.elem.cantidad);
			imprimirLista(l^.sig);
		end;
	end;

begin
	if (a<>nil) then begin
		enOrdenii(a^.HI);
		writeln('ISBN ' , a^.elem.ISBN);
		imprimirLista(a^.elem.listaP);
		enOrdenii(a^.HD);
	end;
end;

function incisoB(ai:arboli):integer;
{b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.}
begin
	if (ai<>nil) then
		if (ai^.HD=nil) then incisoB:=ai^.elem.ISBN
		else incisoB:= incisoB(ai^.HD)
	else incisoB:=0;
end;

function incisoC (aii:arbolii):integer;
{c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.}
begin
	if (aii<>nil) then
		if (aii^.HI=nil) then incisoC:=aii^.elem.ISBN
		else incisoC:= incisoC(aii^.HI)
	else incisoC:=0;
end;

function incisoD (ai:arboli; n:integer):integer;
{d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.}
begin
	if (ai<>nil) then
		if (ai^.elem.numero=n) then incisoD:= incisoD(ai^.HI, n) + incisoD(ai^.HD, n) + 1
		else incisoD:= incisoD(ai^.HI, n) + incisoD(ai^.HD, n)
	else incisoD:=0;
end;

function incisoE (aii:arbolii; n:integer):integer;

	function cantOcurrencias(l:prestamos; n:integer):integer;
	begin
		if (l<>nil) then
			if (l^.elem.numero = n) then cantOcurrencias:= cantOcurrencias(l^.sig, n) + 1
			else cantOcurrencias:= cantOcurrencias(l^.sig, n)
		else cantOcurrencias:=0;
	end;

begin
	if(aii<>nil)then
		incisoE:=cantOcurrencias(aii^.elem.listaP, n) + incisoE(aii^.HI, n) + incisoE(aii^.HD, n)
	else incisoE:=0;
end;

procedure incisoF(ai:arboli

var
	ai:arboli; aii:arbolii;
	numSocio:integer;
begin
	randomize;
	cargarArboles(ai, aii);
	writeln('// ARBOL I //');
	enOrdeni(ai);
	writeln('// ARBOL II //');
	enOrdenii(aii);
	writeln('el ISBN mas grande es ' , incisoB(ai));
	writeln('el ISBN mas pequenio es ' , incisoC(aii));
	writeln('ingrese un numero de socio'); readln(numSocio);
	writeln('la cantidad de prestamos realizados al socio ' , numSocio , ' es ' , incisoD(ai, numSocio));
	writeln('ingrese un numero de socio'); readln(numSocio);
	writeln('la cantidad de prestamos realizados al socio ' , numSocio , ' es ' , incisoE(aii, numSocio));
	incisoF(ai, aF);
end.
