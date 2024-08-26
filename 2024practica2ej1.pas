{Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de a lo sumo 15 números enteros “random”
mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con el valor 20.
b. Un módulo no recursivo que reciba el vector generado en a) e imprima el contenido del
vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un módulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores
pares contenidos en el vector.
e. Un módulo recursivo que reciba el vector generado en a) y devuelva el máximo valor del
vector.
f. Un módulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si
dicho valor se encuentra en el vector o falso en caso contrario.
g. Un módulo que reciba el vector generado en a) e imprima, para cada número contenido en
el vector, sus dígitos en el orden en que aparecen en el número. Debe implementarse un
módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 142, se
debe imprimir 1 4 2.}
Program Clase2MI;
const dimF = 15;
	min = 10;
	max = 155;
type
	vector = array [1..dimF] of integer; 

procedure CargarVector (var v: vector; var dimL: integer);

	procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
	var valor: integer;
	begin
		valor:= min + random (max - min + 1);
		if ((valor <> 20 ) and (dimL < dimF)) then begin
			dimL:= dimL + 1;
			v[dimL]:= valor;
			CargarVectorRecursivo (v, dimL);
         end;
	end;
  
begin
	dimL:= 0;
	CargarVectorRecursivo (v, dimL);
end;
 
procedure ImprimirVector (v: vector; dimL: integer);
var
	i: integer;
begin
	for i:= 1 to dimL do
		writeln(v[i]);
End;     

procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
begin    
	if (dimL>0) then begin
		writeln(v[dimL]);
		ImprimirVectorRecursivo(v, dimL-1);
	end;
end; 
    
function Sumar (v: vector; dimL: integer): integer; 

	function SumarRecursivo (v: vector; pos, dimL: integer): integer;

	Begin
		if (pos <= dimL) then begin
			if (v[pos] mod 2 = 0)
				then SumarRecursivo:= SumarRecursivo (v, pos + 1, dimL) + v[pos]
			else  SumarRecursivo:= SumarRecursivo (v, pos + 1, dimL);
		end else SumarRecursivo:=0;
	End;
 
var pos: integer; 
begin
	pos:= 1;
	Sumar:= SumarRecursivo (v, pos, dimL);
end;

function  ObtenerMaximo (v: vector; dimL: integer): integer;
var
	mayor:integer;
begin
	if(dimL>0)then begin
		mayor:=ObtenerMaximo(v, dimL-1);
		if(v[dimL]>mayor) then mayor:= v[dimL];
		ObtenerMaximo:=mayor
	end else ObtenerMaximo:= -1;
end;     
     
function  BuscarValor (v: vector; dimL, valor: integer): boolean;
begin
	if(dimL>0) then begin
		if(v[dimL]=valor)then BuscarValor:=true
		else BuscarValor:= BuscarValor(v, (dimL-1), valor)
	end else
		BuscarValor:=false;
end; 

procedure ImprimirDigitos (v: vector; dimL: integer);
	procedure ImprimirValor(num:integer);
	begin
		if(num<>0)then begin
			ImprimirValor(num div 10);
			writeln(num mod 10);
		end;
	end;
begin
	if(dimL>0)then begin
		ImprimirValor(v[dimL]);
		ImprimirDigitos(v, dimL-1);
	end;
end; 

var dimL, suma, maximo, valor: integer; 
    v: vector;
    encontre: boolean;
Begin 
	randomize;
	CargarVector (v, dimL);
	if (dimL = 0) then writeln ('--- Vector sin elementos ---')
	else begin
		ImprimirVector (v, dimL);
		writeln('VECTOR');
		ImprimirVectorRecursivo (v, dimL);
	end;             
	suma:= Sumar(v, dimL);
	writeln('La suma de los valores del vector es ', suma); 
	maximo:= ObtenerMaximo(v, dimL);
	writeln('El maximo del vector es ', maximo); 
	write ('Ingrese un valor a buscar: ');
	read (valor);
	encontre:= BuscarValor(v, dimL, valor);
	if (encontre) then writeln('El ', valor, ' esta en el vector')
	else writeln('El ', valor, ' no esta en el vector');
	ImprimirDigitos (v, dimL);
end.
