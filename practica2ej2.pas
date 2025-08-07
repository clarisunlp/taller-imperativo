{Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6}
program practica2ej2;
procedure ImprimirDigito(num:integer);
begin {caso base: num=0}
	if(num <> 0) then begin
		ImprimirDigito(num div 10);
		writeln(num mod 10); {una vez que llega al caso base, imprime desde el primer digito hasta el ultimo}
	end;
end;

var
	num:integer;
begin
	writeln('ingrese un numero'); readln(num);
	while (num<>0) do begin
		ImprimirDigito(num);
		writeln('ingrese un numero'); readln(num);
	end;
end.
