Program ImperativoClase3;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure SocioNumMasGrande(a:arbol);
{i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.}

	function buscarMax(a:arbol):integer; 
	begin
		if(a^.HD=nil)then
			buscarMax:=a^.dato.numero
		else
			buscarMax:=buscarMax(a^.HD);
	end;

begin
	writeln('el numero de socio mas grande es ' , buscarMax(a));
end;

procedure DatosSocioNumMasChico (a:arbol);

		function buscarMin(a:arbol):arbol;
		begin
			if (a=nil) then buscarMin:=nil
			else if (a^.HI = nil) then buscarMin:=a
			else buscarMin:=buscarMin(a^.HI);
		end;
begin
	writeln('datos del socio con el numero mas grande');
	writeln('NUMERO: ' , buscarMin(a)^.dato.numero);
	writeln('NOMBRE: ' , buscarMin(a)^.dato.nombre);
	writeln('EDAD: ' , buscarMin(a)^.dato.edad);
end;

procedure ExisteValorSocio (a:arbol);

	function existe(a:arbol; num:integer):boolean;
	begin
		if(a=nil)then existe:=false
		else if (a^.dato.numero=num) then existe:=true
			else if (num > a^.dato.numero) then existe:=existe(a^.HD, num)
				else existe:=existe(a^.HI, num);
	end;

var
	numero:integer; ok:boolean;
begin
	writeln('ingrese un numero de socio a buscar'); readln(numero);
	ok:=existe(a, numero);
	if(ok)then writeln('el socio exite en la estructura')
	else writeln('el socio no existe en la estructura');
end;

procedure ExistenciaEntreParametros(a:arbol);
{Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.}

	function cantParametros(a:arbol; num1:integer; num2:integer):integer;
	begin
		if(a<>nil)then begin
			if(a^.dato.numero>num1) then
				if(a^.dato.numero<num2)then
					cantParametros:= cantParametros(a^.HI,num1,num2)+cantParametros(a^.HD,num1,num2) + 1
				else cantParametros:= cantParametros(a^.HI, num1,num2)
			else cantParametros:= cantParametros(a^.HD, num1,num2);
		end else cantParametros:= 0;
  end;
   


var
	numero1, numero2:integer;
begin
	writeln('ingrese el parametro inferior'); readln(numero1);
	writeln('ingrese el parametro superior'); readln(numero2);
	writeln('la cantidad de socios cuyos codigos estan entre esos paramtros es ' , cantParametros(a, numero1, numero2));
end;

var 
	a: arbol;
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  {InformarSociosOrdenDecreciente (a); COMPLETAR}
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  { InformarExistenciaNombreSocio (a); COMPLETAR
    InformarCantidadSocios (a); COMPLETAR
    InformarPromedioDeEdad (a); COMPLETAR
  }   
  {Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo
necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.}

	SocioNumMasGrande(a);
	DatosSocioNumMasChico(a);
	ExisteValorSocio(a);
	ExistenciaEntreParametros(a);

End.
