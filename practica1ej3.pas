{Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c)}
program practica1ej3;
const
	corte=-1;
	dimF=8;
type
	generos=1..dimF;

	info=record
		codpelicula:integer;
		codgenero: generos;
		puntaje: real;
	end;

	lista=^nodo;
	nodo=record
		elem:info;
		sig:lista;
	end;

	punteros=record
		pi:lista;
		pu:lista;
	end;

	vectorInfo=array [generos] of punteros;
	vectorOrdenado=array [generos] of integer;

procedure cargarInfo(var v:vectorInfo);
	procedure inicializarVector(var v:vectorInfo);
	var
		i:generos;
	begin
		for i:=1 to dimF do 
			v[i].pi:=nil;
	end;

	procedure leerPelicula(var p:info);
	var
		c:integer;
	begin
		readln(c);
		while (c<>corte)do begin
			p.codpelicula:=c;
			readln(p.codgenero);
			readln(p.puntaje);
			readln(c);
		end;
	end;

	procedure agregarAtras(var v:punteros; p:info);
	var
		nue:lista;
	begin
		new(nue); nue^.elem:=p; nue^.sig:=nil;
		v.pu:=nue;
		if(v.pi=nil)then v.pi:=nue
		else v.pu^.sig:=nue;
	end;
var
	p:info;
begin
	inicializarVector(v);
	leerPelicula(p);
	while(p.codpelicula<>corte)do begin
		agregarAtras(v[p.codgenero], p);
		leerPelicula(p);
	end;
end;

procedure generarVector(var v:vectorOrdenado; inf:vectorInfo);
	function codigoMax(l:lista):integer;
	var
		maxpuntaje:real;
		auxcod:integer;
	begin
		maxpuntaje:=-1;
		while(l<>nil)do begin
			if(l^.elem.puntaje>maxpuntaje)then begin
				maxpuntaje:=l^.elem.puntaje;
				auxcod:=l^.elem.codpelicula;
			end;
			l:=l^.sig;
		end;
		codigoMax:=auxcod;
	end;
var
	i:generos;
begin
	for i:=1 to dimF do
		v[i]:=codigoMax(inf[i].pi);
end;

procedure ordenarVector(var v: vectorOrdenado);
var
	i,j:integer; act:integer;
begin
	for i:= 2 to dimF do begin
		act:=v[i]; j:=i-1;
		while (j>0) and (v[j]>act) do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=act;
	end;
end;

procedure maxmin (v:vectorOrdenado);
begin
	writeln('pelicula con mayor puntaje ' , v[dimF]);
	writeln('pelicula con menor puntaje ' , v[1]);
end;

var {programa principal}
	v:vectorInfo;
	vo:vectorOrdenado;
begin
	cargarInfo(v);
	generarVector(vo, v);
	ordenarVector(vo);
	maxmin(vo);
end.
