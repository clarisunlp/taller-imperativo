{ Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de
 los autos en venta. Implementar un programa que:
 a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
 modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
 i. Una estructura eficiente para la búsqueda por patente.
 ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
 almacenar todos juntos los autos pertenecientes a ella.
 b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
 cantidad de autos de dicha marca que posee la agencia.
 c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
 la cantidad de autos de dicha marca que posee la agencia.
 d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
 la información de los autos agrupados por año de fabricación.
 e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
 modelo del auto con dicha patente.
 f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
 modelo del auto con dicha patente.}
 
program practica5ej2;
const
	corteMarca='MMM';
type

	infoi=record
		patente:string;
		anio:integer;
		marca:string;
		modelo:string;
	end;

	infoA=record
		patente:string;
		anio:integer;
		modelo:string;
	end;

	listaA=^nodoA;
	nodoA=record
		elem:infoA;
		sig:listaA;
	end;

	infoii=record
		marca:string;
		autos:listaA;
	end;

	arboli=^nodoi;
	nodoi=record
		elem:infoi;
		HI:arboli;
		HD:arboli;
	end;

	arbolii=^nodoii;
	nodoii=record
		elem:infoii;
		HI:arbolii;
		HD:arbolii;
	end;

	infoLD=record
		marca:string;
		patente:string;
		modelo:string;
	end;

	listaD=^nodoLD;
	nodoLD=record
		elem:infoLD;
		sig:listaD;
	end;


	infoD=record
		anio:integer;
		autos:listaD;
	end;

	arbolD=^nodoD;
	nodoD=record
		elem:infoD;
		HI:arbolD;
		HD:arbolD;
	end;

procedure incisoA(var ai:arboli; var aii:arbolii);
{a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
 modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
 i. Una estructura eficiente para la búsqueda por patente.
 ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
 almacenar todos juntos los autos pertenecientes a ella.}
 
	procedure leerDatos(var d:infoi);
	var 
	patente: array[1..5] of string = ('AA756BB','BB234CC','CC278DD','DD145EE','EE908FF');
	marca: array[1..5] of string = ('Peugeot','Chevrolet','Renault','Fiat','MMM');
	modelo: array[1..5] of string = ('307','Fiesta','Corsa','Sandero','Duna');
	begin
		d.marca:= marca[random(5)+1];
		d.patente:= patente[random(5)+1];
		d.anio:=random(5)+1;
		d.modelo:=modelo[random(5)+1];
	end;
 
	procedure cargararboli(d: infoi; var ai:arboli);
	begin
		if(ai=nil)then begin
			new(ai); ai^.HI:=nil; ai^.HD:=nil;
			ai^.elem:=d;
		end else if(ai^.elem.patente<d.patente) then cargararboli(d, ai^.HD)
			else cargararboli(d, ai^.HI)
	end;

	procedure cargararbolii(d:infoi; var aii:arbolii);

		procedure agregarAdelante(var l:listaA; d:infoi);
		var
			nue:listaA;
		begin
			new(nue); nue^.sig:=nil;
			nue^.elem.patente:=d.patente; nue^.elem.anio:=d.anio; nue^.elem.modelo:=d.modelo;
			if(l=nil)then l:=nue else begin nue^.sig:=l; l:=nue; end;
		end;

	begin
		if(aii=nil)then begin
			new(aii); aii^.HI:=nil; aii^.HD:=nil;
			aii^.elem.marca:=d.marca;
			aii^.elem.autos:=nil;
			agregarAdelante(aii^.elem.autos,d)
		end else if (aii^.elem.marca=d.marca) then agregarAdelante(aii^.elem.autos, d)
			else if (aii^.elem.marca>d.marca) then cargararbolii(d, aii^.HI)
				else cargararbolii(d, aii^.HD)
	end;

var
	d:infoi;
begin
	leerDatos(d);
	while(d.marca <> cortemarca)do begin
		writeln(d.marca);
		writeln(d.patente);
		cargararboli(d, ai);
		cargararbolii(d, aii);
		leerDatos(d);
	end;
	writeln(d.marca);
	writeln(d.patente);
end;

function incisoB(ai:arboli; m:string):integer;
{Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
 cantidad de autos de dicha marca que posee la agencia.}
begin
	if(ai<>nil)then begin
		if (ai^.elem.marca=m) then incisoB:=incisoB(ai^.HD, m) + incisoB(ai^.HI, m) + 1
		else incisoB:=incisoB(ai^.HD, m) + incisoB(ai^.HI, m);
	end else incisoB:=0;
end;

procedure imprimirArboli(ai:arboli);
begin
	if(ai<>nil)then begin
		imprimirArboli(ai^.HI);
		writeln('PATENTE ' , ai^.elem.patente);
		writeln('ANIO ' , ai^.elem.anio);
		writeln(' MARCA ' , ai^.elem.marca);
		writeln('MODELO ' , ai^.elem.modelo);
		imprimirArboli(ai^.HD);
	end;
end;

procedure imprimirArbolii(aii:arbolii);

	procedure imprimirLista(l:listaA);
	begin
		if(l<>nil)then begin
			writeln('PATENTE ' , l^.elem.patente);
			writeln('ANIO ' , l^.elem.anio);
			writeln('MODELO ' , l^.elem.modelo);
			imprimirLista(l^.sig);
		end;
	end;

begin
	if(aii<>nil)then begin
		imprimirArbolii(aii^.HI);
		writeln(aii^.elem.marca);
		imprimirLista(aii^.elem.autos);
		imprimirArbolii(aii^.HD);
	end;
end;

function incisoC(aii:arbolii; m:string):integer;

	function contarOcurrencias(l:listaA):integer;
	begin
		if(l<>nil)then contarOcurrencias:=contarOcurrencias(l^.sig)+1
		else contarOcurrencias:=0;
	end;

begin
	if (aii<>nil) then begin
		if (aii^.elem.marca=m) then incisoC:=contarOcurrencias(aii^.elem.autos)
		else if (aii^.elem.marca>m) then incisoC:=incisoC(aii^.HI, m)
			else incisoC:=incisoC(aii^.HD, m);
	end else incisoC:=0;
end;

procedure incisoD(ai:arboli; var aD:arbolD);
{d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
 la información de los autos agrupados por año de fabricación.}
 
	procedure agregarAdelante(var l:listaD; d:infoi);
	var 
		nue:listaD;
	begin
		new(nue); nue^.sig:=nil;
		nue^.elem.patente:=d.patente; nue^.elem.marca:=d.marca; nue^.elem.modelo:=d.modelo;
		if(l<>nil)then nue^.sig:=l;
		l:=nue;
	end;
 
	procedure procesarDato(d:infoi; var aD:arbolD);
	begin
		if(aD=nil)then begin
			new(aD); aD^.HI:=nil; aD^.HD:=nil; aD^.elem.anio:=d.anio;
			agregarAdelante(aD^.elem.autos, d);
		end else begin
			if(aD^.elem.anio=d.anio)then agregarAdelante(aD^.elem.autos, d)
			else if(aD^.elem.anio>d.anio)then procesarDato(d, aD^.HI)
				else procesarDato(d, aD^.HD)
		end;
	end;
 
begin
	if(ai<>nil)then begin
		procesarDato(ai^.elem, aD);
		incisoD(ai^.HI, aD);
		incisoD(ai^.HD, aD);
	end;
end;

procedure imprimirArbolD(aD:arbolD);

	procedure imprimirLista(l:listaD);
	begin
		if(l<>nil)then begin
			writeln('MARCA ' , l^.elem.marca);
			writeln('PATENTE ' , l^.elem.patente);
			writeln('MODELO ' , l^.elem.modelo);
			imprimirLista(l^.sig);
		end;
	end;

begin
	if(aD<>nil)then begin
		imprimirArbolD(aD^.HI);
		writeln('ANIO ' , aD^.elem.anio);
		imprimirLista(aD^.elem.autos);
		imprimirArbolD(aD^.HD);
	end;
end;

procedure incisoE(ai:arboli; p:string; var modeloE:string);
{e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
 modelo del auto con dicha patente.}
begin
	if(ai<>nil)then begin
		if(ai^.elem.patente=p)then modeloE:=ai^.elem.modelo
		else if(ai^.elem.patente>p)then incisoE(ai^.HI, p, modeloE)
			else incisoE(ai^.HD, p, modeloE);
	end else modeloE:='NO SE ENCONTRO PATENTE';
end;

procedure incisoF(aii:arbolii; p:string; var modeloF:string);

	procedure buscarPatente(l:listaA; p:string; var modeloF:string);
	begin
		if(l<>nil)then begin
			if(l^.elem.patente=p)then modeloF:=l^.elem.modelo
			else buscarPatente(l^.sig, p, modeloF);
		end;
	end;

begin
	if(aii<>nil)then begin
		incisoF(aii^.HI, p, modeloF);
		if(modeloF='NO SE ENCONTRO PATENTE')then buscarPatente(aii^.elem.autos, p, modeloF);
		incisoF(aii^.HD, p, modeloF);
	end;
end;

var
	ai:arboli; aii:arbolii;
	unaMarca, unaPatente, modeloE, modeloF:string;
	aD:arbolD;
begin
	randomize;
	ai:=nil; aii:=nil;
	incisoA(ai, aii);
	writeln('// ARBOL I //');
	imprimirArboli(ai);
	writeln('// ARBOL II //');
	imprimirArbolii(aii);
	writeln('ingrese una marca'); readln(unaMarca);
	writeln('la cantidad de autos de la marca ' , unaMarca , ' que posee la agencia es ' , incisoB(ai, unaMarca));
	writeln('la cantidad de autos de la marca ' , unaMarca , ' que posee la agencia es ' , incisoC(aii, unaMarca));
	aD:=nil;
	incisoD(ai, aD);
	{writeln('// LISTA INCISO D //');
	imprimirArbolD(aD);}
	writeln('ingrese una patente '); readln(unaPatente);
	incisoE(ai,unaPatente, modeloE);
	writeln('el modelo del auto con la patente ' , unaPatente , ' es ' , modeloE);
	modeloF:= 'NO SE ENCONTRO PATENTE'; incisoF(aii, unaPatente, modeloF);
	writeln('el modelo del auto con la patente ' , unaPatente , ' es ' , modeloF);
end.
