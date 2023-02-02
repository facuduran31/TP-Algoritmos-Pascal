Program test;

uses crt;

CONST
tam = 10;
filas=30;
columnas=119;


TYPE
    RecCIU = RECORD
           nomciu:string;
           codciu:string;
           contciu:integer;
           consultas:integer;
           END;
    ArcCIU = FILE OF RecCIU;

    RecEMP = RECORD
           codemp:string;
           nomemp:string;
           direcemp:string;
           mailemp:string;
           telemp:string;
           codciu:string;
           consultas:integer;
           END;
    ArcEMP = FILE OF RecEMP;

    ArrCantidades = Array[1..4] of integer;

    RecPROY = RECORD
            codproy:string;
            codemp:string;
            etapa:string;
            tipo:string;
            codciu:string;
            cantidades:ArrCantidades;
            END;
    ArcPROY = FILE OF RecProy;

     RecCLI = RECORD
            DNI:string;
            nomcli:string;
            mailcli:string;
            END;
     ArcCLI = FILE OF RecCLI;

     RecPROD = RECORD
            codprod:string;
            codproy:string;
            precio:real;
            estado:string;
            detalle:string[50];
            END;
     ArcProd = FILE OF RecPROD;


VAR
//--VARIABLES TIPO ARCHIVO

Ciudades:ArcCIU;
Empresas:ArcEMP;
Proyectos:ArcPROY;
Clientes:ArcCLI;
Productos:ArcProd;

//--VARIABLES MENU ITERATIVO
//----Variables Bandera
banderamenuprincipal:integer; //bandera del menu principal
banderamenuempresas:integer; // bandera del menu de empresas
banderaltaciu:integer; //bandera alta de ciudades
banderaverciu:integer; // bandera para ver lista de ciudades
banderaltaemp:integer; // bandera alta de empresas
banderaveremp:integer; // bandera para ver lista de empresas
banderaltaproy:integer; // bandera para entrar al menu de alta de proyectos
banderaverproy:integer; // bandera para ver lista de proyectos
banderamenuclientes:integer; // bandera menu clientes
banderaverprod:integer;
banderacasas:integer;
banderadpto:integer;
banderaoficina:integer;
banderaloteos:integer;
banderaestadisica:integer;

//----Variables varias
ingreso:char;
Mostrar, long, seleccion:integer;
etapa, tipo, mensaje:string;

//----Variables indice
i, j:integer;
usuarioactual:integer;

//PROCEDIMIENTOS Y FUNCIONES
//----Procedimientos para abrir archivos
PROCEDURE OpenFileCiudades();
          Begin
               assign(Ciudades, 'C:\TP3\CIUDADES.dat');
               {$I-}
               reset(Ciudades);
               if ioresult = 2 then rewrite(Ciudades);
               {$I+}
          End;

PROCEDURE OpenFileEMPRESAS();
          Begin
               assign(Empresas, 'C:\TP3\EMPRESAS-CONSTRUCTORAS.dat');
               {$I-}
               reset(Empresas);
               if ioresult = 2 then rewrite(Empresas);
               {$I+}
          End;

PROCEDURE OpenFilePROYECTOS();
          Begin
               assign(Proyectos, 'C:\TP3\PROYECTOS.dat');
               {$I-}
               reset(Proyectos);
               if ioresult = 2 then rewrite(Proyectos);
               {$I+}
          End;

PROCEDURE OpenFileClientes();
          Begin
               assign(Clientes, 'C:\TP3\CLIENTES.dat');
               {$I-}
               reset(Clientes);
               if ioresult = 2 then rewrite(Clientes);
               {$I+}
          End;

PROCEDURE OpenFileProductos();
          Begin
               assign(Productos, 'C:\TP3\PRODUCTOS.dat');
               {$I-}
               reset(Productos);
               if ioresult = 2 then rewrite(Productos);
               {$I+}
          End;
          
PROCEDURE CEROS();
VAR RecAUXE:RecEMP; RecAUXC:RecCIU; RecAUXProy:RecProy; RecAUXProd:RecPROD; RecAuxCLI:RecCLI;
          Begin
               RecAUXE.nomemp:='0';
               RecAUXE.codemp:='0';
               RecAUXE.direcemp:='0';
               RecAUXE.mailemp:='0';
               RecAUXE.telemp:='0';
               RecAUXE.codciu:='0';
               RecAUXE.consultas:=0;
               write(Empresas, RecAuxE);
               RecAUXC.nomciu:='0';
               RecAUXC.codciu:='0';
               RecAUXC.contciu:=0;
               RecAuxC.consultas:=0;
               write(Ciudades, RecAuxC);
               RecAUXProy.codproy:='0';
               RecAUXProy.codemp:='0';
               RecAUXProy.etapa:='0';
               RecAUXProy.tipo:='0';
               RecAUXProy.codciu:='0';
               RecAUXProy.cantidades[1]:=0; RecAUXProy.cantidades[2]:=0; RecAUXProy.cantidades[3]:=0; RecAUXProy.cantidades[4]:=0;
               write(Proyectos, RecAUXProy);
               RecAUXProd.codprod:='0';
               RecAUXProd.codproy:='0';
               RecAUXProd.precio:=0;
               RecAUXProd.estado:='0';
               RecAUXProd.detalle:='0';
               write(Productos, RecAUXProd);
               RecAUXCli.dni:='admin';
               RecAUXCli.nomcli:='admin';
               RecAUXCli.mailcli:='admin';
               write(Clientes, RecAUXCli);
          End;

//--- PROCEDIMIENTOS DE MANEJO DE PANTALLA
procedure TITULOPANTALLA(titulo:string);
VAR i, j, k:integer;
	begin
		j:= columnas-length(titulo);
		gotoxy(j DIV 2+1, 1); write(titulo);
		for i:=1 to j DIV 2 DO
			begin
				gotoxy(i, 1); write(#205);
			end;
		for k:= (j DIV 2+ length(titulo)+1) to columnas DO
			begin
				gotoxy(k, 1); write(#205);
			end;
	end;

PROCEDURE ENCOLUMNAR(renglones:integer);
VAR i, j:integer;
	begin
		for i:=2 to renglones DO
			begin
				gotoxy(1, i); write(#186);
				gotoxy(columnas, i); write(#186);
			end;
		for j:=1 to columnas DO
			begin
				gotoxy(j, whereY); write(#205);
			end;
       gotoxy(1, 1); write(#201);
       gotoxy(1, renglones); write(#200);
       gotoxy(columnas, 1); write(#187);
       gotoxy(columnas, renglones); write(#188);
	end;

PROCEDURE CARTEL(xi, xf, yi, yf:integer);
VAR i, j:integer;
    Begin
         for i:= xi to xf DO
             for j:= yi to yf DO
                 begin
                      gotoxy(i, j); write(' ');
                 end;
         for i:= xi to xf DO
             begin
                  gotoxy(i, yi); write(#205);
                  gotoxy(i, yf); write(#205);
             end;
         for j:= yi to yf DO
             begin
                  gotoxy(xi, j); write(#186);
                  gotoxy(xf, j); write(#186);
             end;
         gotoxy(xi, yi); write(#201);
         gotoxy(xf, yi); write(#187);
         gotoxy(xi, yf); write(#200);
         gotoxy(xf, yf); write(#188);
    End;

PROCEDURE CARTELCOLOR(xi, xf, yi, yf:integer);
VAR i, j, k:integer;
    Begin
         ClrScr;
         cursoroff;
         k:=1;
         repeat
               k:=k+1;
               CASE k of
               1: Textcolor(LightBlue);
               2: Textcolor(LightGreen);
               3: Textcolor(LightCyan);
               4: Textcolor(LightRed);
               5: Textcolor(LightMagenta);
               6: Textcolor(Yellow);
               7: Textcolor(White);
               END;
               for i:= xi+1 to xf-1 DO
                   begin
                        gotoxy(i, yi); write(#205);
                        gotoxy(i, yf); write(#205);
                   end;
               for j:= yi+1 to yf-1 DO
                   begin
                        gotoxy(xi, j); write(#186);
                        gotoxy(xf, j); write(#186);
                   end;
               gotoxy((columnas div 2)-(length('Gracias por su visita.')div 2), 14); write('Gracias por su visita.');
               gotoxy((columnas div 2)-(length('Facundo Duran y Juan Cruz Duran :D')div 2), 16); write('Facundo Duran y Juan Cruz Duran :D');
               gotoxy(xi, yi); write(#201);
               gotoxy(xf, yi); write(#187);
               gotoxy(xi, yf); write(#200);
               gotoxy(xf, yf); write(#188);
               Delay(200);
               IF k=7 THEN k:=0;
         until KeyPressed;
    End;

PROCEDURE CARTELERROR(error:string);
VAR X:integer;
    Begin
         cursoroff;
         textcolor(lightred);
         CARTEL(5, columnas-5, 15, 19);
         x:=(columnas-length(error)) DIV 2;
         gotoxy(x, 17);textcolor(white); write(error);
         cursoron;
    End;

PROCEDURE CARTELCORRECTO(correcto:string);
VAR X:integer;
    Begin
         cursoroff;
         textcolor(lightgreen);
         CARTEL(5, columnas-5, 15, 19);
         x:=(columnas-length(correcto)) DIV 2;
         gotoxy(x, 17);textcolor(white); write(correcto);
         cursoron;
    End;

//----PROCEDIMIENTOS DE LOS MENU
Procedure Salir();
    Begin
         banderamenuprincipal:=0;
         CARTELCOLOR(30, columnas-30, 5, filas-5);
         ClrScr;
    End;

Function IntToStr (I : Longint) : String;

Var S : String;

begin
 Str (I,S);
 IntToStr:=S;
end;

//Ordenar ciudades por codigo creciente
Procedure OrdenarCIU;
VAR A, B:RecCIU;
    Begin
         Reset(Ciudades);
         for i:=0 to filesize(Ciudades)-2 DO
             begin
                  for j:=i+1 to filesize(Ciudades)-1 DO
                      begin
                           Seek(Ciudades, i);
                           Read(Ciudades, A);
                           Seek(Ciudades, j);
                           Read(Ciudades, B);
                           IF A.codciu > B.codciu THEN
                              begin
                                   Seek(Ciudades, i);
                                   Write(Ciudades, B);
                                   Seek(Ciudades, j);
                                   Write(Ciudades, A);
                              end;
                      end;
             end;
    End;

Procedure OrdenarCIUMAYOR;
VAR A, B:RecCIU;
    Begin
         Reset(Ciudades);
         for i:=1 to filesize(Ciudades)-2 DO
             begin
                  for j:=i+1 to filesize(Ciudades)-1 DO
                      begin
                           Seek(Ciudades, i);
                           Read(Ciudades, A);
                           Seek(Ciudades, j);
                           Read(Ciudades, B);
                           IF A.consultas > B.consultas THEN
                              begin
                                   Seek(Ciudades, i);
                                   Write(Ciudades, B);
                                   Seek(Ciudades, j);
                                   Write(Ciudades, A);
                              end;
                      end;
             end;
        Seek(Ciudades, filesize(Ciudades)-1);
        Read(Ciudades, A);
        //writeln(A.consultas); readkey;
        if A.consultas <> 0 then
            begin
                i:=filesize(Ciudades)-1;
                j:=A.consultas;
                repeat
                    Seek(Ciudades, i);
                    read(Ciudades, A);
                    Seek(Ciudades, i);
                    IF A.consultas = j then
                        begin
                            i:=i-1;
                        end; 
                until (A.consultas <> j);

                for j:= i+1 to filesize(Ciudades)-1 DO 
                    begin
                        Seek(Ciudades, j);
                        read(Ciudades, A);
                        gotoxy(5, WhereY); textcolor(yellow); write('[-] ',A.nomciu);
                    end;
            end;
    End;

Procedure BuscarCIU(X:string; VAR pos:integer);
VAR band:boolean;
    inferior, superior, medio:integer;
    A:RecCIU;
    Begin
         Reset(Ciudades);
         Seek(Ciudades, 1);
         inferior:=1;
         superior:=filesize(Ciudades)-1;
         band:=false;
                 While (inferior <= superior) AND (band = false) DO
                       begin
                            medio:=(inferior+superior) DIV 2;
                            seek(Ciudades, Medio);
                            Read(Ciudades, A);
                            IF X = A.codciu THEN
                               begin
                                    pos:=medio;
                                    band:=true;
                               end
                               else
                               begin
                                    IF X < A.codciu THEN
                                       begin
                                            superior:=medio-1;
                                       end
                                       else
                                       begin
                                            inferior:=medio+1;
                                       end;
                               end;
                       end;
                 pos:=medio;
    End;

//Validar que el codigo/nombre de ciudad no esté previamente cargado. / Validar que el codigo de ciudad exista en la carga de empresas
Function ValidarCIU(X:string; Y:integer):boolean;
VAR band:boolean;
    inferior, superior, medio:integer;
    A:RecCIU;
    Begin
         Reset(Ciudades);
         Seek(Ciudades, 1);
         inferior:=1;
         superior:=filesize(Ciudades)-1;
         band:=false;
         IF Y = 1 THEN
            begin
                 While (inferior <= superior) AND (band = false) DO
                       begin
                            medio:=(inferior+superior) DIV 2;
                            seek(Ciudades, Medio);
                            Read(Ciudades, A);
                            IF X = A.codciu THEN
                               begin
                                    band:=true;
                               end
                               else
                               begin
                                    IF X < A.codciu THEN
                                       begin
                                            superior:=medio-1;
                                       end
                                       else
                                       begin
                                            inferior:=medio+1;
                                       end;
                               end;
                       end;
                 IF band = true THEN ValidarCIU:=true ELSE ValidarCIU:=false;
            end
            else
            begin
                 Reset(Ciudades);
                 Read(Ciudades, A);
                 While (NOT EOF(Ciudades)) AND (X <> A.nomciu) DO
                       begin
                            Read(Ciudades, A);
                       end;
                 IF A.nomciu = X THEN ValidarCIU:=TRUE else ValidarCIU:=FALSE;
            end;
    End;

Procedure BuscarEMP(X:string; VAR pos:integer);
VAR A:RecEMP;
          Begin
               Reset(Empresas);
               Read(Empresas, A);
                while (NOT EOF(Empresas)) AND (X <> A.codemp) DO 
                    begin
                        read(Empresas, A);
                    end;
               pos:= filepos(Empresas)-1;
          end;

Procedure BuscarPROY(X:string; VAR pos:integer);
VAR A:RecPROY;
          Begin
               Reset(Proyectos);
               Read(Proyectos, A);
                while (NOT EOF(Proyectos)) AND (X <> A.codproy) DO 
                    begin
                        read(Proyectos, A);
                    end;
               pos:= filepos(Proyectos)-1;
          end;

Procedure BuscarUSER(X:string; VAR pos:integer);
VAR A:RecCLI;
          Begin
               Reset(Clientes);
               Read(Clientes, A);
                while (NOT EOF(Clientes)) AND (X <> A.nomcli) DO 
                    begin
                        read(Clientes, A);
                    end;
               pos:= filepos(Clientes)-1;
          end;   

Function ValidarPROD(X:string):boolean;
VAR A:RecPROD;
    Begin
         Reset(Productos);
         Read(Productos, A);
         While (NOT EOF(Productos)) AND (X <> A.codprod) DO
               begin
                    Read(Productos, A);
               end;
         IF A.codprod = X THEN ValidarPROD:=TRUE else ValidarPROD:=FALSE;
    End;

Function ValidarEMP(X:string; Y:integer):boolean;
VAR A:RecEMP;
    Begin
         Reset(Empresas);
         Read(Empresas, A);
         CASE Y OF
         1: begin
                 While (NOT EOF(Empresas)) AND (X <> A.nomemp) DO
                       begin
                            Read(Empresas, A);
                       end;
                 IF A.nomemp = X THEN ValidarEMP:=TRUE else ValidarEMP:=FALSE;
             end;
         2: begin
                 While (NOT EOF(Empresas)) AND (X <> A.codemp) DO
                       begin
                            Read(Empresas, A);
                       end;
                 IF A.codemp = X THEN ValidarEMP:=TRUE else ValidarEMP:=FALSE;
            end;
         3: begin
                 While (NOT EOF(Empresas)) AND (X <> A.direcemp) DO
                       begin
                            Read(Empresas, A);
                       end;
                 IF A.direcemp = X THEN ValidarEMP:=TRUE else ValidarEMP:=FALSE;
            end;
         4: begin
                 While (NOT EOF(Empresas)) AND (X <> A.mailemp) DO
                       begin
                            Read(Empresas, A);
                       end;
                 IF A.mailemp = X THEN ValidarEMP:=TRUE else ValidarEMP:=FALSE;
            end;
         5: begin
                 While (NOT EOF(Empresas)) AND (X <> A.telemp) DO
                       begin
                            Read(Empresas, A);
                       end;
                 IF A.telemp = X THEN ValidarEMP:=TRUE else ValidarEMP:=FALSE;
            end;
         End;
    End;

Function ValidarPROY(X:string; Y:integer):boolean;
VAR A:RecProy;
    Begin
         Reset(Proyectos);
         Read(Proyectos, A);
         CASE Y OF
         1: begin
                 While (NOT EOF(Proyectos)) AND (X <> A.codproy) DO
                       begin
                            Read(Proyectos, A);
                       end;
                 IF A.codproy = X THEN ValidarPROY:=TRUE else ValidarPROY:=FALSE;
             end;
         2: begin
                 While (NOT EOF(Proyectos)) AND (X <> A.codemp) DO
                       begin
                            Read(Proyectos, A);
                       end;
                 IF A.codemp = X THEN ValidarPROY:=TRUE else ValidarPROY:=FALSE;
            end;
         End;
    End;

Function ValidarUSER(X:string; Y:integer):boolean;
VAR A:RecCLI;
    Begin
    CASE Y OF
    1:  begin   
            Reset(Clientes);
            Read(Clientes, A);
                While (NOT EOF(Clientes)) AND (X <> A.nomcli) DO
                    begin
                        Read(Clientes, A);
                    end;
         IF A.nomcli = X THEN ValidarUSER:=TRUE else ValidarUSER:=FALSE;
        end;
        END;
    End;

Procedure ConsulProduct(VAR X:string);
VAR A:RecProd;
B:RecEMP;
C:RecCIU;
D:RecProy;
E:RecCLI;
contaux, k:integer;
    begin
        reset(Proyectos);
        Seek(Proyectos, i);
        read(Proyectos, D);
        BuscarEMP(D.codemp, j);
        reset(Empresas);
        Seek(Empresas, j);
        read(Empresas, B);           
        B.consultas:= B.consultas+1;
        Seek(Empresas, j);
        write(Empresas, B);    
        BuscarCIU(B.codciu, j);
        reset(Ciudades);
        Seek(Ciudades, j);
        read(Ciudades,C);
        C.consultas:= C.consultas+1;
        Seek(Ciudades, j);
        write(Ciudades, C); 
            repeat
                  repeat
                    ClrScr;
                    TITULOPANTALLA('');
                    textcolor(lightcyan); gotoxy(10, 2); write('COD. PRODUCTO'); gotoxy(25, 2); write('CARACTERISTICAS'); gotoxy(80, 2); write('PRECIO'); gotoxy(95, 2); write('ESTADO VENTA');
                    textcolor(white); writeln();
                    reset(Productos);
                    contaux:=0;
                    for i:=1 to filesize(Productos) DO 
                        begin
                            read(Productos, A);
                            IF A.codproy = X THEN
                                begin
                                    contaux:=contaux+1;
                                    gotoxy(5, contaux+2);textcolor(lightgreen); write('[', contaux, ']'); textcolor(white); gotoxy(5+5, contaux+2); write(A.codprod); gotoxy(25, contaux+2); write(A.detalle); gotoxy(80, contaux+2); write('$',A.precio:6:2);gotoxy(95, contaux+2); write(A.estado);
                                end;    
                        end;
                        gotoxy(5, contaux+4);textcolor(lightred); write('[0]'); textcolor(white); write(' Cancelar');
                        ENCOLUMNAR(contaux+8);
                        gotoxy(5, contaux+6); textcolor(lightcyan); write('Para comprar un producto, seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al producto que desea adquirir: '); textcolor(white);
                        readln(seleccion);
                  until (seleccion >= 0) AND (seleccion <= contaux);
                        contaux:=0;
                        i:=0;
                        repeat
                            Seek(Productos, i);
                            read(Productos, A);
                            IF A.codproy = X THEN contaux:=contaux+1;
                            i:=i+1;
                        until contaux=seleccion;
                        i:=i-1;
                        Seek(Productos, i);
                        Read(Productos, A);
                        IF (A.Estado = 'VENDIDO') THEN
                            begin
                                CARTELERROR('Error. El producto seleccionado ya fue vendido.'); readkey;
                            end;
            until (A.estado <> 'VENDIDO');
        if seleccion <> 0 THEN
            begin 
                contaux:=0;
                i:=0;
                repeat
                    Seek(Productos, i);
                    read(Productos, A);
                    IF A.codproy = X THEN contaux:=contaux+1;
                    i:=i+1;
                until contaux=seleccion;
                i:=i-1;
                Seek(Productos, i);
                Read(Productos, A);
                repeat
                    ClrScr;
                    TITULOPANTALLA('');
                    ENCOLUMNAR(10);
                    gotoxy(5, 3); write(#168,'Estas seguro que desea adquirir el producto '); textcolor(yellow); write(A.codprod); textcolor(white); write(' al precio de '); textcolor(yellow); write('$', A.Precio:6:2); textcolor(white); writeln('?'); writeln();
                    gotoxy(5, 5);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Si');
                    gotoxy(5, 6);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' No');
                    gotoxy(5, 8); textcolor(lightcyan); write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente a la opcion que desee: '); textcolor(white);
                    ingreso:=readkey;
                until (ingreso = '1') OR (ingreso = '2');
                IF ingreso='1' THEN
                    begin
                        A.Estado:='VENDIDO';
                        Seek(Productos, i);
                        write(Productos, A);
                        BuscarPROY(X, k);
                        Seek(Proyectos, k);
                        Read(Proyectos, D);
                        D.cantidades[3]:=D.cantidades[3]+1;
                        Seek(Proyectos, k);
                        write(Proyectos, D);
                        ClrScr;
                        TITULOPANTALLA('');
                        ENCOLUMNAR(8);
                        Seek(Clientes, usuarioactual);
                        Read(Clientes, E);
                        gotoxy(5, 3); write('Estimado/a '); textcolor(yellow); write(E.nomcli); textcolor(white); write('. La compra del producto '); textcolor(yellow); write(A.codprod); textcolor(white); writeln(' se ha realizado satisfactoriamente.');
                        gotoxy(5, 4);write('El detalle de la operacion fue enviado al correo '); textcolor(yellow); write(E.mailcli);textcolor(white);write('.');
                        gotoxy(5, 6); textcolor(lightcyan);writeln('Pulse una tecla cualquiera para continuar...'); readkey();
                    end;
            end;
    end;

Procedure ConsulLoteos();
VAR A:RecProy;
B:RecEMP;
C: RecCIU;
Etapa, empresa, ciudad, codproyecto: string;
j, contaux, seleccion: integer;
   Begin
        repeat
            ClrScr; textcolor(white);
            TITULOPANTALLA(' LISTA DE PROYECTOS DE LOTEOS ');
            textcolor(lightcyan); gotoxy(10, 2); write('ETAPA'); gotoxy(22, 2); write('EMPRESA'); gotoxy(37, 2); write('CIUDAD'); gotoxy(52, 2); write('COD. PROYECTO');gotoxy(68, 2); write('CANT. CONSULTAS'); gotoxy(87, 2); write('CANT. PRODUCTOS VENDIDOS');textcolor(white);
            reset(Proyectos);
            contaux:=0;
            FOR i:= 1 to filesize(Proyectos)-1 DO
                begin
                        Seek(Proyectos, i);
                        read(Proyectos, A);
                        codproyecto:=A.codproy;
                        IF A.Tipo = 'L' THEN
                            begin
                                contaux:=contaux+1;
                                IF (A.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (A.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (A.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                                Seek(Proyectos, i);
                                read(Proyectos, A);
                                BuscarEMP(A.codemp, j);
                                Seek(Empresas, j);
                                read(Empresas, B);
                                empresa:= B.nomemp;
                                BuscarCIU(B.codciu, j);
                                reset(Ciudades);
                                Seek(Ciudades, j);
                                read(Ciudades, C);
                                ciudad:= C.nomciu;
                                gotoxy(5,contaux+2); textcolor(lightgreen); write('['); write(contaux); write(']'); textcolor(white); gotoxy(10, contaux+2); write(Etapa); gotoxy(22, contaux+2); write(empresa); gotoxy(37, contaux+2); write(ciudad);gotoxy(52, contaux+2); write(codproyecto); gotoxy(75, contaux+2); write(A.Cantidades[2]);gotoxy(98, contaux+2); write(A.Cantidades[3]);
                            end;
                end;
            gotoxy(5, contaux+4); textcolor(lightred); write('[0]'); textcolor(white); write(' Cancelar');
            ENCOLUMNAR(contaux+8);
            gotoxy(5, contaux+6);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al proyecto que desea consultar: ');textcolor(white); read(seleccion);
        until (seleccion >= 0) AND (seleccion <= contaux);
        if seleccion <> 0 THEN
            begin 
                contaux:=0;
                i:=0;
                repeat
                    Seek(Proyectos, i);
                    read(Proyectos, A);
                    IF A.Tipo = 'L' THEN contaux:=contaux+1;
                    i:=i+1;
                until contaux=seleccion;
                i:=i-1;
                Seek(Proyectos, i);
                Read(Proyectos, A);                    
                A.cantidades[2]:= A.cantidades[2]+1;
                Seek(Proyectos, i);
                write(Proyectos,A);    
                ConsulProduct(A.codproy);
            end
        else banderaloteos:=0;
   End;

//Procedimiento para consulta de Oficinas (5.2.3)
Procedure ConsulOficinas();
VAR A:RecProy;
B:RecEMP;
C: RecCIU;
Etapa, empresa, ciudad, codproyecto: string;
j, contaux, seleccion: integer;
   Begin
        repeat
            ClrScr; textcolor(white);
            TITULOPANTALLA(' LISTA DE PROYECTOS DE EDIFICIO OFICINA ');
            textcolor(lightcyan); gotoxy(10+5, 2); write('ETAPA'); gotoxy(17+5, 2); write('EMPRESA'); gotoxy(32+5, 2); write('CIUDAD'); gotoxy(47+5, 2); write('COD. PROYECTO');gotoxy(63+5, 2); write('CANT. CONSULTAS'); gotoxy(82+5, 2); write('CANT. PRODUCTOS VENDIDOS');textcolor(white);
            reset(Proyectos);
            contaux:=0;
            FOR i:= 1 to filesize(Proyectos)-1 DO
                begin
                        Seek(Proyectos, i);
                        read(Proyectos, A);
                        codproyecto:=A.codproy;
                        IF A.Tipo = 'O' THEN
                            begin
                                contaux:=contaux+1;
                                IF (A.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (A.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (A.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                                Seek(Proyectos, i);
                                read(Proyectos, A);
                                BuscarEMP(A.codemp, j);
                                Seek(Empresas, j);
                                read(Empresas, B);
                                empresa:= B.nomemp;
                                BuscarCIU(B.codciu, j);
                                reset(Ciudades);
                                Seek(Ciudades, j);
                                read(Ciudades, C);
                                ciudad:= C.nomciu;
                                gotoxy(5,contaux+2); textcolor(lightgreen); write('['); write(contaux); write(']'); textcolor(white); gotoxy(10, contaux+2); write(Etapa); gotoxy(22, contaux+2); write(empresa); gotoxy(37, contaux+2); write(ciudad);gotoxy(52, contaux+2); write(codproyecto); gotoxy(75, contaux+2); write(A.Cantidades[2]);gotoxy(98, contaux+2); write(A.Cantidades[3]);
                            end;
                end;
                gotoxy(5, contaux+4); textcolor(lightred); write('[0]'); textcolor(white); write(' Cancelar');
                ENCOLUMNAR(contaux+8);
                gotoxy(5, contaux+6);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al proyecto que desea consultar: ');textcolor(white); read(seleccion);;
        until (seleccion >= 0) AND (seleccion <= contaux);
        if seleccion <> 0 THEN
            begin 
                contaux:=0;
                i:=0;
                repeat
                    Seek(Proyectos, i);
                    read(Proyectos, A);
                    IF A.Tipo = 'O' THEN contaux:=contaux+1;
                    i:=i+1;
                until contaux=seleccion;
                i:=i-1;
                Seek(Proyectos, i);
                Read(Proyectos, A);                    
                A.cantidades[2]:= A.cantidades[2]+1;
                Seek(Proyectos, i);
                write(Proyectos,A);    
                ConsulProduct(A.codproy);
            end
        else banderaoficina:=0;
   End;

//Procedimiento para consulta de Departamentos (5.2.2)
Procedure ConsulDpto();
VAR A:RecProy;
B:RecEMP;
C: RecCIU;
Etapa, empresa, ciudad, codproyecto: string;
j, contaux, seleccion: integer;
   Begin
        repeat
            ClrScr; textcolor(white);
            TITULOPANTALLA(' LISTA DE PROYECTOS DE EDIFICIO DEPARTAMENTO ');
            textcolor(lightcyan); gotoxy(10, 2); write('ETAPA'); gotoxy(22, 2); write('EMPRESA'); gotoxy(37, 2); write('CIUDAD'); gotoxy(52, 2); write('COD. PROYECTO');gotoxy(68, 2); write('CANT. CONSULTAS'); gotoxy(87, 2); write('CANT. PRODUCTOS VENDIDOS');textcolor(white);
            reset(Proyectos);
            contaux:=0;
            FOR i:= 1 to filesize(Proyectos)-1 DO
                begin
                        Seek(Proyectos, i);
                        read(Proyectos, A);
                        codproyecto:=A.codproy;
                        IF A.Tipo = 'D' THEN
                            begin
                                contaux:=contaux+1;
                                IF (A.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (A.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (A.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                                Seek(Proyectos, i);
                                read(Proyectos, A);
                                BuscarEMP(A.codemp, j);
                                Seek(Empresas, j);
                                read(Empresas, B);
                                empresa:= B.nomemp;
                                BuscarCIU(B.codciu, j);
                                reset(Ciudades);
                                Seek(Ciudades, j);
                                read(Ciudades, C);
                                ciudad:= C.nomciu;
                                gotoxy(5,contaux+2); textcolor(lightgreen); write('['); write(contaux); write(']'); textcolor(white); gotoxy(10, contaux+2); write(Etapa); gotoxy(22, contaux+2); write(empresa); gotoxy(37, contaux+2); write(ciudad);gotoxy(52, contaux+2); write(codproyecto); gotoxy(75, contaux+2); write(A.Cantidades[2]);gotoxy(98, contaux+2); write(A.Cantidades[3]);
                            end;
                end;
                gotoxy(5, contaux+4); textcolor(lightred); write('[0]'); textcolor(white); write(' Cancelar');
                ENCOLUMNAR(contaux+8);
                gotoxy(5, contaux+6);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al proyecto que desea consultar: ');textcolor(white); read(seleccion);
        until (seleccion >= 0) AND (seleccion <= contaux);
        if seleccion <> 0 THEN
            begin 
                contaux:=0;
                i:=0;
                repeat
                    Seek(Proyectos, i);
                    read(Proyectos, A);
                    IF A.Tipo = 'D' THEN contaux:=contaux+1;
                    i:=i+1;
                until contaux=seleccion;
                i:=i-1;
                Seek(Proyectos, i);
                Read(Proyectos, A);                    
                A.cantidades[2]:= A.cantidades[2]+1;
                Seek(Proyectos, i);
                write(Proyectos,A);    
                ConsulProduct(A.codproy);
            end
        else banderadpto:=0;
   End;

//Procedimiento para consulta de casas (5.2.1)
Procedure ConsulCasas();
VAR A:RecProy;
B:RecEMP;
C: RecCIU;
Etapa, empresa, ciudad, codproyecto: string;
j, contaux, seleccion: integer;
   Begin
        {$I-}
        repeat
            ClrScr; textcolor(white);
            TITULOPANTALLA(' LISTA DE PROYECTOS DE CASAS ');
            textcolor(lightcyan); gotoxy(10, 2); write('ETAPA'); gotoxy(22, 2); write('EMPRESA'); gotoxy(37, 2); write('CIUDAD'); gotoxy(52, 2); write('COD. PROYECTO');gotoxy(68, 2); write('CANT. CONSULTAS'); gotoxy(87, 2); write('CANT. PRODUCTOS VENDIDOS');textcolor(white);
            reset(Proyectos);
            contaux:=0;
            FOR i:= 1 to filesize(Proyectos)-1 DO
                begin
                        Seek(Proyectos, i);
                        read(Proyectos, A);
                        codproyecto:=A.codproy;
                        IF A.Tipo = 'C' THEN
                            begin
                                contaux:=contaux+1;
                                IF (A.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (A.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (A.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                                Seek(Proyectos, i);
                                read(Proyectos, A);
                                BuscarEMP(A.codemp, j);
                                Seek(Empresas, j);
                                read(Empresas, B);
                                empresa:= B.nomemp;
                                BuscarCIU(B.codciu, j);
                                reset(Ciudades);
                                Seek(Ciudades, j);
                                read(Ciudades, C);
                                ciudad:= C.nomciu;
                                gotoxy(5,contaux+2); textcolor(lightgreen); write('['); write(contaux); write(']'); textcolor(white); gotoxy(10, contaux+2); write(Etapa); gotoxy(22, contaux+2); write(empresa); gotoxy(37, contaux+2); write(ciudad);gotoxy(52, contaux+2); write(codproyecto); gotoxy(75, contaux+2); write(A.Cantidades[2]);gotoxy(98, contaux+2); write(A.Cantidades[3]);
                            end;
                end;
            gotoxy(5, contaux+4); textcolor(lightred); write('[0]'); textcolor(white); write(' Cancelar');
            ENCOLUMNAR(contaux+8);
            gotoxy(5, contaux+6);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al proyecto que desea consultar: ');textcolor(white); read(seleccion);
            IF ioresult <> 0 THEN
               begin
                    banderacasas:=1;
                    CARTELERROR('Error. El caracter ingresado no es valido'); readkey;
               end;
        until (ioresult = 0) AND (seleccion >= 0) AND (seleccion <= contaux);
        {$I+}
        if seleccion <> 0 THEN
            begin 
                contaux:=0;
                i:=0;
                repeat
                    Seek(Proyectos, i);
                    read(Proyectos, A);
                    IF A.Tipo = 'C' THEN contaux:=contaux+1;
                    i:=i+1;
                until contaux=seleccion;
                i:=i-1;
                Seek(Proyectos, i);
                Read(Proyectos, A);                    
                A.cantidades[2]:= A.cantidades[2]+1;
                Seek(Proyectos, i);
                write(Proyectos,A);    
                ConsulProduct(A.codproy);
            end
        else banderacasas:=0;
   End;

Procedure ConsulProy;
VAR ingreso:char;
    Begin
        while Mostrar <> 0 do
            begin
                repeat
                    ClrScr;
                    TITULOPANTALLA(' CONSULTA DE PROYECTOS ');
                    ENCOLUMNAR(13);
                    gotoxy(5, 3); textcolor(yellow); writeln(#168,'Que tipo de proyecto desea conocer?'); textcolor(white);
                    gotoxy(5, 5);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Casa');
                    gotoxy(5, 6);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Edificio departamento');
                    gotoxy(5, 7);textcolor(lightgreen); write('[3]'); textcolor(white); writeln(' Edificio oficina');
                    gotoxy(5, 8);textcolor(lightgreen); write('[4]'); textcolor(white); writeln(' Loteo');
                    gotoxy(5, 9);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver');
                    gotoxy(5, 11);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al menu que desea ingresar: ');textcolor(white);
                    ingreso:=readkey();
                    IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') AND (ingreso <> '3') AND (ingreso <> '4') THEN
                        begin
                            CARTELERROR('Error. El caracter o los caracteres ingresados no corresponden a ningun menu. Intentelo de nuevo: '); READKEY;
                        end;
                until (ingreso='1') OR (ingreso='2') OR (ingreso='3') OR (ingreso='4') OR (ingreso='0');

        case ingreso of
        '1':
            begin
                 banderacasas:=1;
                 while banderacasas = 1 DO
                       begin
                            ConsulCasas();
                       end;
            end;
        '2':
            begin
                 banderadpto:=1;
                 while banderadpto = 1 do
                       begin
                            ConsulDpto();
                       end;
            end;
        '3':
            begin
                 banderaoficina:=1;
                 while banderaoficina = 1 DO
                       begin
                            ConsulOficinas();
                       end;
            end;
        '4':
            begin
                 banderaloteos:=1;
                 while banderaloteos = 1 DO
                       begin
                            ConsulLoteos();
                       end;
            end;
        '0': Mostrar:=0;
        end;
            end;
    End;

Procedure RegisterUser;
VAR A:RecCLI;
    begin
        Mostrar:= 1;
            while Mostrar <> 0 do
                begin
                        repeat
                                 ClrScr;
                                 TITULOPANTALLA(' REGISTRAR UN USUARIO ');
                                 ENCOLUMNAR(7);
                                 gotoxy(5, 3); textcolor(yellow); writeln('*Ingrese "0" en cualquier momento para cancelar el registro.'); textcolor(white);
                                 gotoxy(5, 5); write('Nombre de usuario: ');
                                 readln(A.nomcli);
                                 A.nomcli:= upcase(A.nomcli);      
                                 IF (A.nomcli) = '0' THEN Mostrar:=0;
                                 long:= length(A.nomcli);
                                 IF long = 0 THEN
                                    begin
                                         CARTELERROR('Error. El nombre de usuario no puede estar vacio.'); readkey; ClrScr;
                                    end
                                    else
                                    begin
                                         IF (ValidarUSER(A.nomcli, 1) = TRUE) THEN
                                         begin
                                              CARTELERROR('Error. El nombre de usuario ingresado ya existe.'); readkey; ClrScr;
                                         end;
                                    end;
                        until ((ValidarUSER(A.nomcli, 1) = FALSE) AND (long > 0)) OR (Mostrar = 0);
                        IF Mostrar<>0 THEN

                        repeat
                                 ClrScr;
                                 TITULOPANTALLA(' REGISTRAR UN USUARIO ');
                                 ENCOLUMNAR(7);
                                 gotoxy(5, 3); textcolor(yellow); writeln('*Ingrese "0" en cualquier momento para cancelar el registro.'); textcolor(white);
                                 gotoxy(5, 5);write('Ingrese un email: ');
                                 readln(A.mailcli);
                                 IF (A.mailcli) = '0' THEN Mostrar:=0;
                                 long:= length(A.mailcli);
                                 A.mailcli:= lowercase(A.mailcli);
                                 IF long = 0 THEN
                                    begin
                                         CARTELERROR('Error. El mail no puede estar vacio.');readkey; ClrScr;
                                    end
                                    else
                                    begin
                                         IF (ValidarUSER(A.mailcli, 1) = TRUE) THEN
                                         begin
                                              CARTELERROR('Error. El mail ingresado ya existe.'); readkey; ClrScr;
                                         end;
                                    end;
                        until ((ValidarUSER(A.mailcli, 2) = FALSE) AND (long > 0)) OR (Mostrar = 0);
                        IF Mostrar<>0 THEN
                        repeat
                                 ClrScr;
                                 TITULOPANTALLA(' REGISTRAR UN USUARIO ');
                                 ENCOLUMNAR(7);
                                 gotoxy(5, 3); textcolor(yellow); writeln('*Ingrese "0" en cualquier momento para cancelar el registro.'); textcolor(white);
                                 gotoxy(5, 5);write('Ingrese su DNI: ');
                                 readln(A.DNI);
                                 IF (A.DNI) = '0' THEN Mostrar:=0;
                                 long:= length(A.DNI);
                                 IF long = 0 THEN
                                    begin
                                         CARTELERROR('Error. El DNI no puede estar vacio.'); readkey;
                                    end
                                    else
                                    begin
                                         IF (ValidarUSER(A.DNI, 1) = TRUE) THEN
                                         begin
                                              CARTELERROR('Error. El DNI ingresado ya existe.');readkey;
                                         end;
                                    end;
                        until ((ValidarUSER(A.DNI, 3) = FALSE) AND (long > 0)) OR (Mostrar = 0);
                        IF Mostrar<>0 THEN
                            begin
                                Reset(Clientes);
                                Seek(Clientes,filesize(Clientes));
                                write(Clientes, A);
                                CARTELCORRECTO('Tu usuario se ha registrado correctamente.'); textcolor(white);
                                readkey; 
                                Mostrar:= 0;
                            end;
                end;
    end;

Procedure SesionUser;
VAR user:string;
    begin
        Mostrar:= 1;
        while Mostrar <> 0 do
            begin
                repeat
                    ClrScr;
                    TITULOPANTALLA(' INICIO DE SESION ');
                    ENCOLUMNAR(7);
                    gotoxy(5, 3); textcolor(yellow); write('Ingrese "0" para cancelar el inicio de sesion.');  textcolor(white);
                    gotoxy(5, 5);write('Ingrese nombre de usuario: ');
                    readln(user);
                    user:= upcase(user);
                    IF (user = '0') THEN Mostrar:= 0 ELSE 
                    IF (ValidarUSER(user, 1) = FALSE) THEN
                        begin
                            CARTELERROR('Error. El usuario ingresado no existe.');readkey;
                        end;
                until (ValidarUSER(user, 1) = TRUE) OR (Mostrar = 0);
                IF (ValidarUSER(user, 1) = TRUE) THEN 
                    begin
                        BuscarUSER(user, usuarioactual);
                        ConsulProy;
                    end;
                Mostrar:= 0;
            end;
    end;

Procedure MenuClientes();
VAR ingreso:char;
    Begin
         repeat
               ClrScr;
               TITULOPANTALLA(' MENU DE CLIENTES ');
               ENCOLUMNAR(9);
               gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Iniciar Sesion');
               gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Registrarme');
               gotoxy(5, 5);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver al MENU PRINCIPAL');
               gotoxy(5, 7);textcolor(lightcyan);write('Seleccione el ');textcolor(lightgreen);write('[numero]');textcolor(lightcyan);write(' correspondiente a lo que desee hacer: ');textcolor(white);
               ingreso:= readkey; writeln();
               IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                  begin
                       CARTELERROR('Error. El caracter ingresado no corresponde a ninguna accion.'); readkey;
                  end;
         until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');
         case ingreso of
              '0':
              begin
                   banderamenuclientes:= 0;
                   ClrScr;
              end;
         '1':
             begin
                SesionUser;
             end;
         '2':
             begin
                RegisterUser;
             end;
         end;
    End;

Procedure Estadistica();
VAR A:RecEMP; contaux:integer;
C:RecProy;
    Begin
         IF (filesize(Ciudades) <= 1) OR (filesize(Empresas) <= 1) OR (filesize(Proyectos) <= 1) THEN
            begin
                 ClrScr;
                 textcolor(yellow);
                 TITULOPANTALLA('');
                 ENCOLUMNAR(7);
                 textcolor(white);
                 gotoxy((columnas-length('Lo sentimos. Las estadisticas aun no estan disponibles.')) DIV 2, 3); write('Lo sentimos. Las estadisticas aun no estan disponibles.');
                 textcolor(yellow); gotoxy((columnas-length('Pulse cualquier tecla para volver atras...')) DIV 2, 5); write('Pulse cualquier tecla para volver atras...'); textcolor(white);
                 readkey;
                 banderaestadisica:= 0;
            end
            else
            begin
                 ClrScr; textcolor(white);
                 reset(Empresas);
                 Seek(Empresas, 1);
                 read(Empresas, A);
                 contaux:=0;
                 TITULOPANTALLA(' ESTADISTICAS ');
                 gotoxy(5, 3); writeln('Las empresas cuyas consultas fueron mayores a ', tam, ' son: ');
                 for i:= 1 to filesize(Empresas)-1 DO
                     begin
                          Seek(Empresas, i);
                          read(Empresas, A);
                          if A.consultas >= tam THEN
                             begin
                                gotoxy(5, contaux+4); textcolor(yellow); write('[-] '); gotoxy(10, contaux+4); write(A.nomemp); textcolor(white);
                                contaux:=contaux+1
                             end;
                     end;
                 gotoxy(5, contaux+5); writeln('La ciudad con mayor consultas de proyectos es: ');
                 OrdenarCIUMAYOR; textcolor(white);
                 OrdenarCIU;
                 gotoxy(5, contaux+8); writeln('Los proyectos que vendieron todas las unidades son: ');
                 reset(Proyectos);
                 Seek(Proyectos, 1);
                 read(Proyectos, C);
                 for i:= 1 to filesize(Proyectos)-1 DO
                     begin
                          Seek(Proyectos, i);
                          read(Proyectos, C);
                          if C.Cantidades[1] = C.Cantidades[3] THEN
                             begin
                                  gotoxy(5, whereY); textcolor(yellow); write('[-] '); writeln(C.codproy); textcolor(white);
                                  contaux:=contaux+1;
                             end;
                     end;
                 ENCOLUMNAR(contaux+12);
                 gotoxy(5, contaux+10); textcolor(lightcyan); write('Presione cualquier tecla para volver atras...'); textcolor(white); readkey;
                 banderaestadisica:= 0;
            end;
    End;

Procedure VerPROD();
VAR A:RecProd; contaux:integer;
    Begin
         Reset(Productos);
         Seek(Productos, 1);
         ClrScr;
         CONTAUX:=0;
         TITULOPANTALLA(' LISTA DE PRODUCTOS CARGADOS ');
         textcolor(lightcyan); gotoxy(5, 3); write('COD.PRODUCTO'); gotoxy(20, 3); write('COD.PROYECTO'); gotoxy(37, 3); write('PRECIO'); gotoxy(53, 3); write('ESTADO'); gotoxy(67, 3); write('DETALLE'); textcolor(white);
         for i:=1 to filesize(Productos)-1 DO
             begin
                  Read(Productos, A);
                  gotoxy(5, i+3); write(A.codprod); gotoxy(20, i+3); write(A.codproy); gotoxy(37, i+3); write('$',A.precio:2:2); gotoxy(53, i+3); write(A.Estado); gotoxy(67, i+3); write(A.detalle);
                  contaux:=contaux+1;
             end;
         ENCOLUMNAR(CONTAUX+8);
         gotoxy(5, contaux+6); textcolor(lightcyan); write('Presione cualquier tecla para volver atras...'); textcolor(white); readkey;
         banderaverprod:=0;
    End;


Procedure CargarPROD();
VAR A:RecPROD; opc:integer; B:RecPROY; CONTAUX:INTEGER; mensaje:string;
    Begin
         Mostrar:=1;
         while (Mostrar = 1) DO
               begin
                    Reset(Proyectos);
                    IF filesize(Proyectos) < 2 THEN
                      begin
                            textcolor(yellow);
                            TITULOPANTALLA('');
                            ENCOLUMNAR(7);
                            textcolor(white);
                            gotoxy(12, 3); write('Lo sentimos. La carga de productos estara disponible cuando haya por lo menos un proyecto cargado.');
                            textcolor(yellow); gotoxy((columnas-length('Pulse cualquier tecla para volver atras...')) DIV 2, 5); write('Pulse cualquier tecla para volver atras...'); textcolor(white);
                            readkey;
                            Mostrar:=0;
                    end
                    else
                    begin
                         repeat
                                 ClrScr;
                                 TITULOPANTALLA(' CARGAR UN NUEVO PRODUCTO ');
                                 ENCOLUMNAR(7);
                                 textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                 gotoxy(5, 5); write('Codigo de producto: ');
                                 readln(A.codprod);
                                 IF (A.codprod) = '0' THEN Mostrar:=0;
                                 long:= length(A.codprod);
                                 A.codprod:= upcase(A.codprod);
                                 IF long = 0 THEN
                                    begin
                                         CARTELERROR('Error. El codigo de producto no puede estar vacio.'); readkey; ClrScr;
                                    end
                                    else
                                    begin
                                         IF (ValidarPROD(A.codprod) = TRUE) AND (Mostrar <> 0) THEN
                                         begin
                                              CARTELERROR('Error. El codigo de producto ingresado ya existe.');readkey; ClrScr;
                                         end;
                                    end;
                           until ((ValidarPROD(A.codprod) = FALSE) AND (long > 0)) OR (Mostrar = 0);
                           IF Mostrar <> 0 THEN begin//
                           {$I-}
                           repeat
                                 ClrScr;
                                 Reset(Proyectos);
                                 READ(Proyectos, B);
                                 CONTAUX:=0;
                                 TITULOPANTALLA(' LISTA DE PROYECTOS CARGADOS ');
                                 textcolor(lightcyan); gotoxy(5+5, 2); write('CANTIDAD'); gotoxy(17+5, 2); write('COD.CIUDAD'); gotoxy(32+5, 2); write('COD.EMPRESA'); gotoxy(49+5, 2); write('COD.PROYECTO'); gotoxy(70+5, 2); write('ETAPA'); gotoxy(90+5, 2); write('TIPO'); textcolor(white);
                                 for i:=1 to filesize(Proyectos)-1 DO
                                     begin
                                          Read(Proyectos, B);
                                          IF (B.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (B.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (B.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                                          IF (B.Tipo = 'C') THEN Tipo:= 'CASA'; IF (B.Tipo = 'D') THEN Tipo:= 'EDIF. DEPARTAMENTO'; IF (B.Tipo = 'O') THEN Tipo:= 'EDIF OFICINA'; IF (B.Tipo = 'L') THEN Tipo:= 'LOTEO';
                                          IF B.Cantidades[4] <> 0 THEN
                                             begin
                                                  gotoxy(5, i+2);textcolor(lightgreen); write('[',i,'] ');  textcolor(white); gotoxy(5+5, i+2); write(B.cantidades[4],'/',B.cantidades[1]); gotoxy(17+5, i+2); write(B.codciu); gotoxy(32+5, i+2); write(B.codemp); gotoxy(49+5, i+2); write(B.codproy); gotoxy(70+5, i+2); write(etapa); gotoxy(90+5, i+2); write(tipo);
                                             end
                                             ELSE
                                             begin
                                                  gotoxy(5, i+2);textcolor(lightred); write('[',i,'] ');  textcolor(white); gotoxy(5+5, i+2); write(B.cantidades[4],'/',B.cantidades[1]); gotoxy(17+5, i+2); write(B.codciu); gotoxy(32+5, i+2); write(B.codemp); gotoxy(49+5, i+2); write(B.codproy); gotoxy(70+5, i+2); write(etapa); gotoxy(90+5, i+2); write(tipo);
                                             end;
                                          contaux:=contaux+1;
                                     end;
                                 ENCOLUMNAR(CONTAUX+6);
                                 gotoxy(5, contaux+4); textcolor(lightcyan); write('Seleccione el '); textcolor(lightgreen); write('[numero] '); textcolor(lightcyan); write('de proyecto al que le corresponde el producto: '); textcolor(white); readln(opc);
                                 IF (opc = 0) THEN 
                                    begin
                                         Mostrar:=0;
                                         Seek(Proyectos, opc);
                                         Read(Proyectos, B);
                                    end;
                                 IF (opc > 0) AND (opc <= filesize(Proyectos)-1) THEN
                                    begin
                                        Seek(Proyectos, opc);
                                        Read(Proyectos, B);
                                    end;
                                 IF ((opc < 0) OR (opc > filesize(Proyectos)-1)) AND (Mostrar <> 0) THEN
                                    begin
                                        CARTELERROR('Error. El numero ingresado es invalido. '); readkey; textcolor(white);
                                    end;                                  
                                 IF (opc > 0) AND (opc <= filesize(Proyectos)-1) AND (B.cantidades[4] = 0) AND (Mostrar <> 0) THEN
                                    begin
                                        CARTELERROR('Error. El proyecto seleccionado no admite mas productos. ');readkey; textcolor(white);
                                    end;
                                 IF ioresult <> 0 THEN
                                    begin
                                         Mostrar:=1;
                                         CARTELERROR('Error. El caracter ingresado no es valido'); readkey;
                                    end;
                           until ((ioresult = 0) AND (opc > 0) AND (opc <= filesize(Proyectos)-1) AND (B.cantidades[4] <> 0)) OR (Mostrar = 0);
                           {$I+}
                           Seek(Proyectos, opc);
                           Read(Proyectos, B);
                           A.codproy:= B.codproy;
                           end;//
                           IF Mostrar <> 0 THEN begin//
                           {$I-}
                           repeat
                                 ClrScr;
                                 TITULOPANTALLA(' CARGAR UN NUEVO PRODUCTO ');
                                 ENCOLUMNAR(7);
                                 textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                 gotoxy(5, 5); write('Precio: ');
                                 readln(A.precio);
                                 IF ioresult <> 0 THEN
                                    begin
                                         Mostrar:=1;
                                         CARTELERROR('Error. El caracter ingresado no es valido'); readkey;
                                    end;
                                 IF A.precio = 0 THEN Mostrar:=0;
                                 IF A.Precio < 0 THEN
                                    begin
                                         CARTELERROR('Error. El precio del producto no puede ser inferior a $0.'); readkey; ClrScr;
                                         textcolor(white);
                                    end;
                           until ((A.precio >= 0) OR (Mostrar = 0)) AND (ioresult = 0);
                           {$I+}
                           end;//
                           IF Mostrar <> 0 THEN begin; //
                           A.Estado:='NO VENDIDO';
                           repeat
                                 ClrScr;
                                 TITULOPANTALLA(' CARGAR UN NUEVO PRODUCTO ');
                                 ENCOLUMNAR(7);
                                 textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                 gotoxy(5, 5); write('Detalle: ');
                                 readln(A.detalle);
                                 IF A.detalle = '0' THEN Mostrar:=0;
                                 IF (length(A.detalle) > 50) THEN
                                    begin
                                         CARTELERROR('Error. El detalle no puede exceder los 50 caracteres'); readkey;
                                    end;
                           until ((length(A.detalle) > 0) AND (length(A.detalle) <=50)) OR (Mostrar = 0);
                           end;
                           IF Mostrar <> 0 THEN begin//
                           B.Cantidades[4]:= B.Cantidades[4]-1;
                           Seek(Proyectos, opc);
                           Write(Proyectos, B);
                           Reset(Productos);
                           Seek(Productos, filesize(Productos));
                           Write(Productos, A);
                           CARTELCORRECTO('Producto cargado con exito. Presione una tecla para continuar...'); readkey;
                           repeat
                                  ClrScr;
                                  mensaje:=#168+'DESEA CARGAR OTRO PRODUCTO?';
                                  TITULOPANTALLA(mensaje);
                                  ENCOLUMNAR(8);
                                  gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Si');
                                  gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' No');
                                  gotoxy(5, 6);textcolor(lightcyan);write('Seleccione una opcion: ');textcolor(white);
                                  ingreso:=readkey();
                                  IF (ingreso <> '1') AND (ingreso <> '2') THEN begin CARTELERROR('Error. El caracter ingresado no corresponde a ninguna opcion valida.'); readkey; end;
                           until (ingreso = '1') OR (ingreso = '2');
                           IF (ingreso = '1') THEN
                              begin
                                   ClrScr;
                                   Mostrar:=1;
                              end
                              else
                              begin
                                  Mostrar:=0;
                              end;
                        end;//
                    end;
               end;
    End;

//PROCEDIMIENTO DEL MENU DE ALTA DE PRODUCTOS (4.4)
Procedure AltaProductos();
    Begin
          repeat
                ClrScr;
                TITULOPANTALLA(' ALTA DE PRODUCTOS ');
                ENCOLUMNAR(9);
                gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Ver lista de productos cargados');
                gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Cargar nuevo producto');
                gotoxy(5, 5);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver');
                gotoxy(5, 7);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al menu que desea ingresar: ');textcolor(white);
                ingreso:=readkey; writeln();
                IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                   begin
                        CARTELERROR('Error. El caracter o los caracteres ingresados no corresponden a ningun menu. Intentelo de nuevo: '); readkey; textcolor(white);
                   end;
          until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');
          case ingreso of
               '1':
                 Begin
                      banderaverprod:=1;
                      while banderaverprod = 1 DO
                            begin
                                 verPROD();
                            end;
                 End;
               '2':
                   Begin
                        ClrScr;
                        CargarPROD();
                   End;
               '0': banderaltaproy:=0;
          end;
    End;

//PROCEDIMIENTO PARA VER PROYECTOS CARGADOS (4.3.1)
Procedure VerPROY();
VAR A:RecProy; contaux:integer;
    Begin
         Reset(Proyectos);
         Seek(Proyectos, 1);
         ClrScr;
         contaux:=0;
         TITULOPANTALLA(' LISTA DE PROYECTOS CARGADOS ');
         textcolor(lightcyan); gotoxy(5, 2); write('CANTIDAD'); gotoxy(17, 2); write('COD.CIUDAD'); gotoxy(32, 2); write('COD.EMPRESA'); gotoxy(49, 2); write('COD.PROYECTO'); gotoxy(70, 2); write('ETAPA'); gotoxy(90, 2); write('TIPO'); textcolor(white);
         for i:=1 to filesize(Proyectos)-1 DO
             begin
                  Read(Proyectos, A);
                  IF (A.Etapa = 'P') THEN Etapa:= 'PREVENTA'; IF (A.Etapa = 'O') THEN Etapa:= 'OBRA'; IF (A.Etapa = 'T') THEN Etapa:= 'TERMINADO';
                  IF (A.Tipo = 'C') THEN Tipo:= 'CASA'; IF (A.Tipo = 'D') THEN Tipo:= 'EDIF. DEPARTAMENTO'; IF (A.Tipo = 'O') THEN Tipo:= 'EDIF OFICINA'; IF (A.Tipo = 'L') THEN Tipo:= 'LOTEO';
                  gotoxy(5, i+2); write(A.cantidades[1]); gotoxy(17, i+2); write(A.codciu); gotoxy(32, i+2); write(A.codemp); gotoxy(49, i+2); write(A.codproy); gotoxy(70, i+2); write(etapa); gotoxy(90, i+2); write(tipo);
                  contaux:=contaux+1;
             end;
         ENCOLUMNAR(CONTAUX+5);
         gotoxy(5, contaux+4);textcolor(lightcyan); write('Presione cualquier tecla para volver atras...'); textcolor(white); readkey;
         banderaverproy:=0;
    End;


//PROCEDIMIENTO PARA CARGAR PROYECTOS (4.3.2)
Procedure CargarPROY();
VAR A:RecProy; B:RecEMP; opc:char; opcb, contaux:integer;
    Begin
        Mostrar:=1;
        while (Mostrar = 1) DO
              begin
              Reset(Empresas);
                   IF filesize(Empresas) < 2 THEN
                      begin
                            textcolor(yellow);
                            TITULOPANTALLA('');
                            ENCOLUMNAR(7);
                            textcolor(white);
                            gotoxy(12, 3); write('Lo sentimos. La carga de proyectos estara disponible cuando haya por lo menos una empresa cargada.');
                            textcolor(yellow); gotoxy((columnas-length('Pulse cualquier tecla para volver atras...')) DIV 2, 5); write('Pulse cualquier tecla para volver atras...'); textcolor(white);
                            readkey;
                            Mostrar:=0;
                      end
                      else
                      begin
                           repeat
                                 ClrScr;
                                 TITULOPANTALLA(' CARGAR UN NUEVO PROYECTO ');
                                 ENCOLUMNAR(7);
                                 textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                 gotoxy(5, 5); write('Codigo de proyecto: ');
                                 readln(A.codproy);
                                 IF A.codproy = '0' THEN Mostrar:=0;
                                 long:= length(A.codproy);
                                 A.codproy:= upcase(A.codproy);
                                 IF long = 0 THEN
                                 begin
                                      CARTELERROR('Error. El codigo de proyecto no puede estar vacio.');readkey; ClrScr;
                                 end
                                 else
                                 begin
                                     IF (ValidarPROY(A.codproy, 1) = TRUE) AND (long > 0) AND (Mostrar <> 0) THEN
                                     begin
                                          CARTELERROR('Error. El codigo de proyecto ingresado ya existe.'); readkey; ClrScr;
                                     end;
                                 end;
                           until ((long > 0) AND (ValidarPROY(A.codproy, 1) = FALSE)) OR (Mostrar = 0);
                           IF Mostrar <> 0 THEN
                           {$I-}
                              repeat
                                 reset(empresas);
                                 Seek(Empresas, 1);
                                 ClrScr;
                                 TITULOPANTALLA(' LISTA DE EMPRESAS CARGADAS ');
                                 contaux:=0;
                                 textcolor(lightcyan); gotoxy(10, 5); write('NOMBRE'); gotoxy(32, 5); write('DIRECCION'); gotoxy(56, 5); write('MAIL'); gotoxy(85, 5); write('TELEFONO'); gotoxy(98, 5); write('CODIGO DE CIUDAD'); {gotoxy(119, 2); write('CONSULTAS');} textcolor(white);
                                 for i:=1 to filesize(Empresas)-1 DO
                                     begin
                                          Read(Empresas, B);
                                          gotoxy(5, i+5); textcolor(lightgreen); write('[',i,']'); textcolor(white); gotoxy(10, i+5); write(B.nomemp); gotoxy(32, i+5); write(B.direcemp); gotoxy(56, i+5); write(B.mailemp); gotoxy(85, i+5); write(B.telemp); gotoxy(98, i+5); write(B.codciu);
                                          contaux:=contaux+1;
                                     end;
                                 ENCOLUMNAR(CONTAUX+9);
                                 gotoxy(5, 3);textcolor(yellow);writeln('*Ingrese "0" en cualquier momento para cancelar la carga.');textcolor(white);
                                 gotoxy(5, contaux+7);textcolor(lightcyan); write('Seleccione el '); textcolor(lightgreen); write('[numero] '); textcolor(lightcyan); write('de la empresa a la que le corresponde el proyecto: '); textcolor(white); readln(opcb);
                                 IF opcb = 0 THEN Mostrar:=0;
                                 IF ioresult <> 0 THEN
                                    begin
                                         Mostrar:=1;
                                         CARTELERROR('Error. El caracter ingresado no es valido'); readkey;
                                    end;
                              until ((ioresult = 0) AND (opcb > 0) AND (opcb < filesize(empresas))) OR (Mostrar = 0);
                           {$I+}
                           IF Mostrar <> 0 THEN
                              begin//
                                  Seek(Empresas, opcb);
                                  Read(Empresas, B);
                                  A.codemp:= B.codemp;
                                  A.codciu:= B.codciu;
                                  repeat
                                        ClrScr;
                                        TITULOPANTALLA(' CARGAR UN NUEVO PROYECTO ');
                                        ENCOLUMNAR(9);
                                        textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                        gotoxy(5, 5);textcolor(yellow);writeln('| "P" - Preventa | "O" - Obra | "T" - Terminado |');textcolor(white);
                                        gotoxy(5, 7);write('Ingrese la letra correspondiente a la etapa en la que se encuentra el proyecto: ');
                                        A.Etapa:= readkey; writeln();
                                        IF A.Etapa = '0' THEN Mostrar:=0;
                                        A.Etapa:= upcase(A.Etapa);
                                        IF (A.Etapa <> 'P') AND (A.Etapa <> 'O') AND (A.Etapa <> 'T') AND (Mostrar <> 0) THEN
                                        begin
                                             CARTELERROR('Error. La letra ingresada no corresponde a ninguna etapa.');readkey; ClrScr;
                                        end;
                                  until (A.Etapa = 'P') OR (A.Etapa = 'O') OR (A.Etapa = 'T') OR (Mostrar = 0);
                              end;//
                           IF Mostrar <> 0 THEN
                              repeat
                                 ClrScr;
                                 TITULOPANTALLA(' CARGAR UN NUEVO PROYECTO ');
                                 ENCOLUMNAR(9);
                                 textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                 gotoxy(5, 5); textcolor(yellow);writeln('| "C" - Casa | "D" - Edificio departamento | "O" - Edificio oficina | "L" - Loteos |');textcolor(white);
                                 gotoxy(5, 7); write('Ingrese la letra correspondiente al tipo de proyecto: ');
                                 A.Tipo:= readkey;
                                 IF A.Tipo = '0' THEN Mostrar:=0;
                                 A.Tipo:= upcase(A.Tipo);
                                 IF (A.Tipo <> 'C') AND (A.Tipo <> 'D') AND (A.Tipo <> 'O') AND (A.Tipo <> 'L') AND (Mostrar <> 0) THEN
                                    begin
                                         CARTELERROR('Error. La letra ingresada no corresponde a ningun tipo valido.'); readkey; ClrScr;
                                    end;
                              until (A.Tipo = 'C') OR (A.Tipo = 'D') OR (A.Tipo = 'O') OR (A.Tipo = 'L') OR (Mostrar = 0);
                           IF Mostrar <> 0 THEN
                           begin//
                                  {$I-}
                                  repeat
                                        ClrScr;
                                        TITULOPANTALLA(' CARGAR UN NUEVO PROYECTO ');
                                        ENCOLUMNAR(7);
                                        textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                        gotoxy(5, 5);write('Cantidad de productos: ');
                                        readln(A.Cantidades[1]);
                                        IF ioresult <> 0 THEN
                                           begin
                                                Mostrar:=1;
                                                CARTELERROR('Error. La cantidad debe ser un valor entero.'); readkey; ClrScr;
                                           end;
                                        IF A.Cantidades[1] = 0 THEN Mostrar:=0 else Mostrar:=1;
                                        IF A.Cantidades[1] < 0 THEN
                                        begin
                                             CARTELERROR('Error. La cantidad debe ser mayor a 0.'); readkey; ClrScr;
                                        end;
                                  until ((A.Cantidades[1] > 0) OR (Mostrar = 0)) AND (ioresult = 0);
                                  {$I+}
                           end;//
                           IF Mostrar <> 0 THEN
                           begin//
                              A.Cantidades[4]:= A.Cantidades[1];
                              A.Cantidades[2]:=0;
                              A.Cantidades[3]:=0;
                              Reset(Proyectos);
                              Seek(Proyectos, filesize(Proyectos));
                              Write(Proyectos, A);
                              CARTELCORRECTO('Proyecto cargado con exito. Presione una tecla para continuar...'); readkey;
                              repeat
                                  ClrScr;
                                  mensaje:=#168+'DESEA CARGAR OTRO PROYECTO?';
                                  TITULOPANTALLA(mensaje);
                                  ENCOLUMNAR(8);
                                  gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Si');
                                  gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' No');
                                  gotoxy(5, 6);textcolor(lightcyan);write('Seleccione una opcion: ');textcolor(white);
                                  opc:=readkey();
                                  IF (opc <> '1') AND (opc <> '2') THEN begin CARTELERROR('Error. El caracter ingresado no corresponde a ninguna opcion valida.'); readkey; end;
                              until (opc = '1') OR (opc = '2');
                           IF (opc = '1') THEN
                              begin
                                   ClrScr;
                                   Mostrar:=1;
                              end
                              else
                              begin
                                  Mostrar:=0;
                              end;
                           end;//
                      end;
              End;
    End;

//PROCEDIMIENTO DEL MENU DE ALTA DE PROYECTOS (4.3)
Procedure AltaProyectos();
    Begin
         repeat
          ClrScr;
          TITULOPANTALLA(' ALTA DE PROYECTOS ');
          ENCOLUMNAR(9);
          gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Ver lista de proyectos cargados');
          gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Cargar nuevo proyecto');
          gotoxy(5, 5);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver');
          gotoxy(5, 7);textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al menu que desea ingresar: ');textcolor(white);
          ingreso:=readkey; writeln();
                IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                   begin
                        CARTELERROR('Error. El caracter o los caracteres ingresados no corresponden a ningun menu. Intentelo de nuevo: '); READKEY; ClrScr;
                   end;
        until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');

          case ingreso of
               '1':
                 Begin
                      banderaverproy:=1;
                      while banderaverproy = 1 DO
                            begin
                                 verPROY();
                            end;
                 End;
               '2':
                   Begin
                        ClrScr;
                        CargarPROY();
                   End;
               '0': banderaltaproy:=0;
          end;
    End;

//PROCEDIMIENTO PARA VER LISTA DE EMPRESAS CARGADAS (4.2.2)
Procedure VerEMP();
VAR i, contaux:integer;
    A:RecEMP;
    Begin
         reset(empresas);
         Seek(Empresas, 1);
         ClrScr;
         TITULOPANTALLA(' LISTA DE EMPRESAS CARGADAS ');
         contaux:=0;
         textcolor(lightcyan); gotoxy(5, 2); write('NOMBRE'); gotoxy(24, 2); write('COD.EMPRESA'); gotoxy(39, 2); write('DIRECCION'); gotoxy(56, 2); write('MAIL'); gotoxy(85, 2); write('TELEFONO'); gotoxy(98, 2); write('CODIGO DE CIUDAD'); {gotoxy(119, 2); write('CONSULTAS');} textcolor(white);
         for i:=1 to filesize(Empresas)-1 DO
             begin
                  Read(Empresas, A);
                  gotoxy(5, i+2); write(A.nomemp); gotoxy(24, i+2); write(A.codemp); gotoxy(39, i+2); write(A.direcemp); gotoxy(56, i+2); write(A.mailemp); gotoxy(85, i+2); write(A.telemp); gotoxy(98, i+2); write(A.codciu);
                  contaux:=contaux+1;
             end;
         ENCOLUMNAR(CONTAUX+6);
         gotoxy(5, contaux+5);textcolor(lightcyan); write('Presione cualquier tecla para volver atras...'); textcolor(white); readkey;
         banderaveremp:= 0;
    End;

//Procedimiento ver lista de ciudades cargadas (4.1.1)

Procedure CargarEMP();
VAR A:RecEMP; opc:char; POS, opcb:integer; B:RecCIU; contaux:integer;
    Begin
         Reset(Ciudades);
         Reset(Empresas);
         Mostrar:=1;
         While Mostrar <> 0 DO
               begin
                    IF filesize(Ciudades) <= 1 THEN
                       begin
                            textcolor(yellow);
                            TITULOPANTALLA('');
                            ENCOLUMNAR(7);
                            textcolor(white);
                            gotoxy(12, 3); write('Lo sentimos. La carga de empresas estara disponible cuando haya por lo menos una ciudad cargada.');
                            textcolor(yellow); gotoxy((columnas-length('Pulse cualquier tecla para volver atras...')) DIV 2, 5); write('Pulse cualquier tecla para volver atras...'); textcolor(white);
                            readkey;
                            Mostrar:=0;
                       end
                       else
                       begin
                             repeat
                                  ClrScr;
                                  TITULOPANTALLA(' CARGAR UNA NUEVA EMPRESA ');
                                  ENCOLUMNAR(7);
                                  textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                  gotoxy(5, 5); write('Nombre de la empresa que desea ingresar: ');
                                  readln(A.nomemp);
                                  IF (A.nomemp) = '0' THEN Mostrar:=0;
                                  A.nomemp:= upcase(A.nomemp);
                                  long:= length(A.nomemp);
                                  IF ((ValidarEMP(A.nomemp, 1) = TRUE) AND (long > 0)) AND (Mostrar <> 0) THEN
                                     begin
                                          CARTELERROR('Error. El nombre de la empresa ingresado ya existe.'); readkey; ClrScr;
                                     end;
                                  IF long = 0 THEN
                                  begin
                                       CARTELERROR('Error. El nombre de la empresa no puede estar vacio.'); textcolor(white); readkey; ClrScr;
                                   end;
                            until ((long > 0) AND (ValidarEMP(A.nomemp, 1) = FALSE)) OR (Mostrar=0);
                            IF Mostrar <> 0 THEN
                            repeat
                                  ClrScr;
                                  TITULOPANTALLA(' CARGAR UNA NUEVA EMPRESA ');
                                  ENCOLUMNAR(7);
                                  textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                  gotoxy(5, 5); write('Codigo de la empresa: ');
                                  readln(A.codemp);
                                  IF A.codemp = '0' THEN Mostrar:=0;
                                  A.codemp:= upcase(A.codemp);
                                  long:= length(A.codemp);
                                  IF (ValidarEMP(A.codemp, 2) = TRUE) AND (long > 0) AND (Mostrar <> 0)  THEN
                                     begin
                                          CARTELERROR('Error. El codigo de la empresa ingresado ya existe.');readkey; ClrScr;
                                     end;
                                  if long = 0 THEN
                                     begin
                                          CARTELERROR('Error. El codigo de la empresa no puede estar vacio.');readkey; ClrScr;
                                     end;
                            until ((long > 0) AND (ValidarEMP(A.codemp, 2) = FALSE)) OR (Mostrar = 0);
                            IF Mostrar <> 0 THEN
                            repeat
                                  ClrScr;
                                  TITULOPANTALLA(' CARGAR UNA NUEVA EMPRESA ');
                                  ENCOLUMNAR(7);
                                  textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                  gotoxy(5, 5); write('Direccion: ');
                                  readln(A.direcemp);
                                  IF A.direcemp = '0' THEN Mostrar:=0;
                                  A.direcemp:= upcase(A.direcemp);
                                  long:= length(A.direcemp);
                                  IF (ValidarEMP(A.direcemp, 3) = TRUE) AND (long > 0) AND (Mostrar <> 0) THEN
                                  begin
                                       CARTELERROR('Error. La direccion de la empresa ingresada ya existe.');readkey; ClrScr;
                                  end;
                                  if long = 0 THEN
                                  begin
                                       CARTELERROR('Error. La direccion de la empresa no puede estar vacia.');readkey; ClrScr;
                                  end;
                            until ((long > 0) AND (ValidarEMP(A.direcemp, 3) = FALSE)) OR (Mostrar = 0);
                            IF Mostrar <> 0 THEN
                            repeat
                                  ClrScr;
                                  TITULOPANTALLA(' CARGAR UNA NUEVA EMPRESA ');
                                  ENCOLUMNAR(7);
                                  textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                  gotoxy(5, 5); write('Correo electronico: ');
                                  readln(A.mailemp);
                                  IF A.mailemp = '0' THEN Mostrar:=0;
                                  A.mailemp:= lowercase(A.mailemp);
                                  long:= length(A.mailemp);
                                  IF (ValidarEMP(A.mailemp, 4) = TRUE) AND (long > 0) AND (Mostrar <> 0)  THEN
                                  begin
                                       CARTELERROR('Error. El correo electronico de la empresa ingresado ya existe.');readkey; ClrScr;
                                  end;
                                  if long = 0 THEN
                                  begin
                                       CARTELERROR('Error. El correo electronico no puede estar vacio.');readkey; ClrScr;
                                  end;
                            until ((long > 0) AND (ValidarEMP(A.mailemp, 4) = FALSE)) OR (Mostrar = 0);
                            IF Mostrar <> 0 THEN
                            repeat
                                  ClrScr;
                                  TITULOPANTALLA(' CARGAR UNA NUEVA EMPRESA ');
                                  ENCOLUMNAR(7);
                                  textcolor(yellow); gotoxy(5, 3); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                                  gotoxy(5, 5); write('Telefono: ');
                                  readln(A.telemp);
                                  IF A.telemp = '0' THEN Mostrar:=0;
                                  long:= length(A.telemp);
                                  IF (ValidarEMP(A.telemp, 5) = TRUE) AND (long > 0) AND (Mostrar <> 0)  THEN
                                  begin
                                       CARTELERROR('Error. El telefono de la empresa ingresado ya existe.');readkey; ClrScr;
                                  end;
                                  if long = 0 THEN
                                  begin
                                       CARTELERROR('Error. El telefono de la empresa no puede estar vacio.');textcolor(white); readkey; ClrScr;
                                  end;
                            until ((long > 0) AND (ValidarEMP(A.telemp, 5) = FALSE)) OR (Mostrar = 0);
                            IF Mostrar <> 0 THEN
                            {$I-}
                            repeat
                                  Reset(Ciudades);
                                  Seek(Ciudades, 1);
                                  ClrScr;
                                  TITULOPANTALLA(' LISTA DE CIUDADES CARGADAS ');
                                  contaux:=0;
                                  gotoxy(3, 5);textcolor(lightcyan);writeln('        CODIGO       NOMBRE'); textcolor(white);
                                  for i:=1 to filesize(Ciudades)-1 DO
                                      begin
                                           Read(Ciudades, B);
                                           gotoxy(5, i+5); textcolor(lightgreen); write('[',i,']'); textcolor(white); gotoxy(12, i+5); write(B.codciu); gotoxy(23, i+5); write(B.nomciu);
                                           contaux:=contaux+1;
                                      end;
                                  ENCOLUMNAR(contaux+9);
                                  gotoxy(5, 3); textcolor(yellow);writeln('*Ingrese "0" en cualquier momento para cancelar la carga.');textcolor(white);
                                  gotoxy(5, contaux+7);textcolor(lightcyan); write('Seleccione el '); textcolor(lightgreen); write('[numero] '); textcolor(lightcyan); write('correspondiete a la ciudad en que se encuentra la empresa: '); textcolor(white); readln(opcb);
                                  IF opcb = 0 THEN Mostrar:=0;
                                  IF ((opcb < 0) OR (opcb > filesize(Ciudades)-1)) AND (Mostrar <> 0) THEN
                                     begin
                                          CARTELERROR('Error. El numero ingresado no coincide con ninguna opcion valida.'); readkey; ClrScr;
                                     end;
                                  IF ioresult <> 0 THEN
                                     begin
                                          Mostrar:=1;
                                          CARTELERROR('Error. Caracter ingresado no valido.'); readkey; ClrScr;
                                     end;
                            until ((ioresult = 0) AND (opcb > 0) AND (opcb < filesize(Ciudades))) OR (Mostrar = 0);
                            {$i+}
                            IF Mostrar <> 0 THEN
                            begin//
                            A.consultas:=0;
                            Seek(Ciudades, opcb);
                            Read(Ciudades, B);
                            A.codciu:= B.codciu;
                            BuscarCIU(A.codciu, pos);
                            Seek(Ciudades, pos);
                            Read(Ciudades, B);
                            B.contciu:=B.contciu+1;
                            Seek(Ciudades, pos);
                            Write(Ciudades, B);
                            write(Empresas, A);
                            CARTELCORRECTO('Empresa cargada con exito. Presione una tecla para continuar...'); readkey;
                            repeat
                                  ClrScr;
                                  mensaje:=#168+'DESEA CARGAR OTRA EMPRESA?';
                                  TITULOPANTALLA(mensaje);
                                  ENCOLUMNAR(8);
                                  gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Si');
                                  gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' No');
                                  gotoxy(5, 6);textcolor(lightcyan);write('Seleccione una opcion: ');textcolor(white);
                                  opc:=readkey();
                                  IF (opc <> '1') AND (opc <> '2') THEN begin CARTELERROR('Error. El caracter ingresado no corresponde a ninguna opcion valida.'); readkey; end;
                            until (opc = '1') OR (opc = '2');
                            IF (opc = '1') THEN
                               begin
                                    ClrScr;
                                    Mostrar:=1;
                               end
                               else
                               begin
                                    Mostrar:=0;
                               end;
                           end;//
                       end;
              end;
    End;

//PROCEDIMIENTO DEL MENU DE ALTA DE EMPRESAS (4.2)
Procedure AltaEmpresas();
    Begin
         repeat
          ClrScr;
          TITULOPANTALLA(' ALTA DE EMPRESAS ');
          ENCOLUMNAR(9);
          gotoxy(5, 3); textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Ver lista de empresas cargadas');
          gotoxy(5, 4); textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Cargar una nueva empresa');
          gotoxy(5, 5); textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver');
          gotoxy(5, 7); textcolor(lightcyan);write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al menu que desea ingresar: ');textcolor(white);
          ingreso:=readkey; writeln();
                IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                   begin
                        CARTELERROR('Error. El caracter o los caracteres ingresados no corresponden a ningun menu. Intentelo de nuevo: '); READKEY; textcolor(white);
                   end;
        until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');

          case ingreso of
               '1':
                 Begin
                      banderaveremp:=1;
                      while banderaveremp = 1 DO
                            begin
                                 verEMP();
                            end;
                 End;
               '2':
                 Begin
                      ClrScr;
                      CargarEMP();
                 End;
               '0': banderaltaemp:=0;
          end;
    End;

//Procedimiento ver lista de ciudades cargadas (4.1.1)
Procedure VerCIU();
VAR A:RecCIU;
    contaux:integer;
    Begin
         ClrScr;
         Reset(Ciudades);
         Seek(Ciudades, 1);
         contaux:=0;
         TITULOPANTALLA(' LISTA DE CIUDADES CARGADAS (A-Z) ');
         gotoxy(3, 2);textcolor(lightcyan);writeln('    CANTIDAD DE EMPRESAS CARGADAS    CODIGO       NOMBRE'); textcolor(white);
         for i:=1 to filesize(Ciudades)-1 DO
             begin
                  Read(Ciudades, A);
                  gotoxy(21, i+2); write(A.contciu); gotoxy(41, i+2); write(A.codciu); gotoxy(52, i+2); write(A.nomciu);
                  contaux:=contaux+1;
             end;
         ENCOLUMNAR(contaux+5);
         gotoxy(5, contaux+4);textcolor(lightcyan); write('Presione cualquier tecla para volver atras...'); textcolor(white); readkey;
         banderaverciu:= 0;
    End;

//Procedimiento cargar nueva ciudad (4.1.2)
Procedure CargarCIU();
VAR A:RecCIU;
    opc:char;
    Begin
         Reset(Ciudades);
         Mostrar:=1;
         while Mostrar <> 0 DO
               begin
                    repeat
                          ClrScr;
                          TITULOPANTALLA(' CARGAR UNA NUEVA CIUDAD ');
                          ENCOLUMNAR(7);
                          gotoxy(5, 3); textcolor(yellow); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                          gotoxy(5, 5);
                            write('Nombre de la ciudad que desea ingresar: ');
                            readln(A.nomciu);
                            IF A.nomciu = '0' THEN Mostrar:=0;
                            A.nomciu:=upcase(A.nomciu);
                            long:=length(A.nomciu);
                            IF long = 0 THEN
                               begin
                                    CARTELERROR('Error. El nombre de la ciudad no puede estar vacio.'); readkey; ClrScr;
                               end
                               else
                               begin
                               IF (ValidarCIU(A.nomciu, 2) = TRUE) AND (Mostrar <> 0) THEN
                                  begin
                                       CARTELERROR('Error. El nombre de la ciudad ingresado ya existe.'); readkey; ClrScr;
                                  end;
                               end;
                   until ((ValidarCIU(A.nomciu, 2) = FALSE) AND (long > 0)) OR (Mostrar =0);
                   IF Mostrar <> 0 THEN
                   repeat
                          ClrScr;
                          TITULOPANTALLA(' CARGAR UNA NUEVA CIUDAD ');
                          ENCOLUMNAR(7);
                          gotoxy(5, 3); textcolor(yellow); writeln('*Ingrese "0" en cualquier momento para cancelar la carga.'); textcolor(white);
                          gotoxy(5, 5);
                           write('Codigo de la ciudad que desea cargar (3 caracteres): ');
                           readln(A.codciu);
                           IF A.codciu = '0' THEN Mostrar:=0;
                           A.codciu:= upcase(A.codciu);
                           long:= length(A.codciu);
                           IF (long <> 3) AND (Mostrar <> 0) THEN
                              begin
                                   CARTELERROR('Error. El codigo de la ciudad debe tener 3 caracteres.'); readkey; ClrScr;
                              end
                              else
                              begin
                              IF (ValidarCIU(A.codciu, 1) = TRUE) AND (Mostrar <> 0) THEN
                                 begin
                                      CARTELERROR('Error. El codigo de ciudad ingresado ya existe.'); readkey; ClrScr;
                                 end;
                              end;
                   until ((ValidarCIU(A.codciu, 1) = FALSE) AND (long = 3)) OR (Mostrar = 0);
                   IF Mostrar <> 0 THEN
                   begin//
                   A.contciu:=0;
                   A.consultas:=0;
                   Seek(Ciudades, filesize(Ciudades));
                   write(Ciudades, A);
                   OrdenarCIU();
                   CARTELCORRECTO('Ciudad cargada con exito. Presione una tecla para continuar...'); textcolor(white); readkey;
                   repeat
                         ClrScr;
                         mensaje:=#168+'DESEA CARGAR OTRA CIUDAD?';
                         TITULOPANTALLA(mensaje);
                         ENCOLUMNAR(8);
                         gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Si');
                         gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' No');
                         gotoxy(5, 6);textcolor(lightcyan);write('Seleccione una opcion: ');textcolor(white);
                         opc:=readkey();
                         IF (opc <> '1') AND (opc <> '2') THEN begin CARTELERROR('Error. El caracter ingresado no corresponde a ninguna opcion valida.'); readkey; end;
                   until (opc = '1') OR (opc = '2');
                   IF (opc = '1') THEN
                      begin
                           ClrScr;
                           Mostrar:=1;
                      end
                      else
                      begin
                           Mostrar:=0;
                      end;
                   end;//
               end;

    End;

//PROCEDIMIENTO DEL MENU DE ALTA DE CIUDADES (4.1)
Procedure AltaCiudades();
    Begin
         repeat
               ClrScr;
               TITULOPANTALLA(' ALTA DE CIUDADES ');
               ENCOLUMNAR(9);
               gotoxy(5,3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Ver lista de ciudades cargadas');
               gotoxy(5,4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Cargar una nueva ciudad');
               gotoxy(5,5);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver');
               gotoxy(5,7);textcolor(lightcyan);write('Seleccione el ');textcolor(lightgreen); write('[numero]');textcolor(lightcyan);write(' correspondiente al menu que desea ingresar: ');textcolor(white);
               ingreso:= readkey(); writeln();
                IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                   begin
                        CARTELERROR('Error. El caracter ingresado no correspondeen a ningun menu.');readkey; ClrScr;
                   end;
          until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');

          case ingreso of
               '1':
                 Begin
                      banderaverciu:=1;
                      while banderaverciu = 1 DO
                            begin
                                 verCIU();
                            end;
                 End;
               '2':
                 Begin
                      ClrScr;
                      CargarCIU();
                 End;
               '0': banderaltaciu:=0;
          end;
    End;

//PROCEDIMIENTO DEL MENU DE EMPRESAS (4)
Procedure MenuEmpresas();
VAR ingreso:char;
    Begin
                    repeat
                          ClrScr; textcolor(white);
                          TITULOPANTALLA(' MENU DE EMPRESAS DESARROLLADORAS ');
                          ENCOLUMNAR(12);
                          gotoxy(5, 3);textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Alta de CIUDADES');
                          gotoxy(5, 4);textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Alta de EMPRESAS');
                           gotoxy(5, 5);textcolor(lightgreen); write('[3]'); textcolor(white); writeln(' Alta de PROYECTOS');
                           gotoxy(5, 6);textcolor(lightgreen); write('[4]'); textcolor(white); writeln(' Alta de PRODUCTOS');
                           gotoxy(5, 7);textcolor(lightgreen); write('[5]'); textcolor(white); writeln(' ESTADISTICAS');
                           gotoxy(5, 8);textcolor(lightred); write('[0]'); textcolor(white); writeln(' Volver al MENU PRINCIPAL');
                           gotoxy(5, 10);textcolor(lightcyan);write('Seleccione el ');textcolor(lightgreen);write('[numero]');textcolor(lightcyan);write(' correspondiente al menu que desea ingresar: ');textcolor(white);
                          ingreso:= readkey; writeln();
                          IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') AND (ingreso <> '3') AND (ingreso <> '4') AND (ingreso <> '5') THEN
                             begin
                                  CARTELERROR('Error. El caracter ingresado no corresponde a ningun menu.'); readkey;
                             end;
                    until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2') OR (ingreso = '3') OR (ingreso = '4') OR (ingreso = '5');

                    case ingreso of
                         '0':
                             begin
                                  banderamenuempresas:= 0;
                                  ClrScr;
                             end;
                         '1':
                             begin
                                  banderaltaciu:=1;
                                  while banderaltaciu = 1 DO
                                        begin
                                             AltaCiudades;
                                        end;
                             end;
                         '2':
                             begin
                                  banderaltaemp:=1;
                                  while banderaltaemp = 1 DO
                                  begin
                                       AltaEmpresas();
                                  end;
                             end;
                         '3':
                             begin
                                  banderaltaproy:=1;
                                  while banderaltaproy = 1 DO
                                  begin
                                       AltaProyectos();
                                  end;
                             end;
                         '4': AltaProductos();
                         '5':
                             begin
                                  banderaestadisica:=1;
                                  while banderaestadisica = 1 DO
                                  begin
                                       Estadistica();
                                  end;
                             end;

                    end;
    End;

//VALIDAR SI LA CLAVE ES CORRECTA
Procedure ValidarClave(menuselected:integer);
TYPE arrayclave = Array[1..2] of string;
VAR intentos, pos, intentosrestantes:integer;
    pass, ch: string;
    error:string;
    Claves:arrayclave;
     Begin
          Claves[1]:='empresasutn';
          Claves[2]:='clientesutn';
          //VALIDAR CLAVE PARA MENU DE EMPRESAS
          IF menuselected = 2 THEN
             begin
                  gotoxy(5,5); write('Ingrese la clave para acceder al menu de empresas: ');
                  intentos:=1;
                  while intentos <= 3 DO
                        begin
                             pass:='';
                             pos := 56;
                             Gotoxy(pos, 5); ch := readkey;
                             while (ch <> #13) DO
                                   begin
                                        IF ch <> #8 THEN
                                           begin
                                                pass:=pass+ch;
                                                textcolor(lightcyan);
                                                gotoxy(pos,5); write ('*');
                                                pos:= pos+1;
                                           end
                                           else
                                           begin
                                                IF Pass <> '' THEN
                                                   begin
                                                        pos:=pos-1;
                                                        gotoxy(pos,5); write(' ');
                                                        delete(pass, length(Pass), 1);
                                                   end;
                                           end;
                                           gotoxy(pos,5);
                                           ch:=readkey;
                                  end;
                             IF (pass = Claves[1]) THEN
                                begin
                                     error:= 'Contrase'+#164+'a correcta. Pulse una tecla para continuar...';
                                     CARTELCORRECTO(error); readkey;
                                     banderamenuempresas:=1;
                                     while banderamenuempresas = 1 DO
                                           begin
                                                Menuempresas();
                                           end;
                                     break
                                end
                                ELSE
                                begin
                                     ClrScr; textcolor(white);
                                     TITULOPANTALLA(' INGRESO AL MENU DE EMPRESAS DESARROLLADORAS ');
                                     ENCOLUMNAR(7);
                                     gotoxy(5, 3); textcolor(yellow); writeln('Tenga en cuenta que solo dispondra de tres intentos disponibles.');
                                     textcolor(white); gotoxy(5,5); write('Ingrese la clave para acceder al menu de empresas: ');
                                     intentosrestantes:=3-intentos;
                                     error:='Error. Contrase'+#164+'a incorrecta. Intentos restantes: '+ IntToStr(intentosrestantes);
                                     CARTELERROR(error);
                                     intentos:=intentos+1;
                                     IF intentos = 4 THEN
                                        begin
                                             CARTELERROR('Cantidad de intentos agotada. Pulse una tecla para volver al menu principal...');
                                             readkey;
                                             ClrScr;
                                             textcolor(white); textbackground(black);
                                        end;
                                end;
                        end;
             end;
         //VALIDAR CLAVE PARA MENU DE CLIENTES
          IF menuselected = 3 THEN
             begin
                  gotoxy(5,5); write('Ingrese la clave para acceder al menu de clientes: ');
                  intentos:=1;
                  while intentos <= 3 DO
                        begin
                             pass:='';
                             pos := 56;
                             Gotoxy(pos, 5); ch := readkey;
                             while (ch <> #13) DO
                                   begin
                                        IF ch <> #8 THEN
                                           begin
                                                pass:=pass+ch;
                                                textcolor(lightcyan);
                                                gotoxy(pos,5); write ('*');
                                                pos:= pos+1;
                                           end
                                           else
                                           begin
                                                IF Pass <> '' THEN
                                                   begin
                                                        pos:=pos-1;
                                                        gotoxy(pos,5); write(' ');
                                                        delete(pass, length(Pass), 1);
                                                   end;
                                           end;
                                           gotoxy(pos,5);
                                           ch:=readkey;
                                           textcolor(white);
                                   end;
                             IF (pass = Claves[2]) THEN
                                begin
                                     error:= 'Contrase'+#164+'a correcta. Pulse una tecla para continuar...';
                                     CARTELCORRECTO(error);
                                     textcolor(white); readkey();
                                     banderamenuclientes:=1;
                                     while banderamenuclientes = 1 DO
                                           begin
                                                MenuClientes();
                                           end;
                                     break
                                end
                                ELSE
                                begin
                                     ClrScr; textcolor(white);
                                     TITULOPANTALLA(' INGRESO AL MENU DE CLIENTES ');
                                     ENCOLUMNAR(7);
                                     gotoxy(5, 3); textcolor(yellow); writeln('Tenga en cuenta que solo dispondra de tres intentos disponibles.');
                                     textcolor(white); gotoxy(5,5); write('Ingrese la clave para acceder al menu de clientes: ');
                                     intentosrestantes:=3-intentos;
                                     error:='Error. Contrase'+#164+'a incorrecta. Intentos restantes: '+ IntToStr(intentosrestantes);
                                     CARTELERROR(error);
                                     intentos:=intentos+1;
                                     IF intentos = 4 THEN
                                        begin
                                             CARTELERROR('Cantidad de intentos agotada. Pulse una tecla para volver al menu principal...');
                                             readkey;
                                             ClrScr;
                                             textcolor(white); textbackground(black);
                                        end;
                                end;
                        end;
             end;
     End;

//PROCEDIMIENTO DEL INGRESO AL MENU DE CLIENTES (3)
Procedure IngresoClientes();

     Begin
          ClrScr;
          TITULOPANTALLA(' INGRESO AL MENU DE CLIENTES ');
          ENCOLUMNAR(7);
          gotoxy(5, 3); textcolor(yellow); writeln('Tenga en cuenta que solo dispondra de tres intentos disponibles.');
          textcolor(white);
          ValidarClave(3);
     End;

//PROCEDIMIENTO DEL INGRESO AL MENU DE EMPRESAS (2)
Procedure IngresoEmpresas();

     Begin
          ClrScr;
          TITULOPANTALLA(' INGRESO AL MENU DE EMPRESAS DESARROLLADORAS ');
          ENCOLUMNAR(7);
          gotoxy(5, 3); textcolor(yellow); writeln('Tenga en cuenta que solo dispondra de tres intentos disponibles.');
          textcolor(white);
          ValidarClave(2);
     End;

//PROCEDIMIENTO DEL MENU PRINCIPAL (1)
Procedure MenuPrincipal();
     Begin
          // Muestra del menu.
          repeat
                TITULOPANTALLA(' MENU PRINCIPAL ');
                ENCOLUMNAR(9);
                gotoxy(5, 3); textcolor(lightgreen); write('[1]'); textcolor(white); writeln(' Menu de EMPRESAS DESARROLLADORAS');
                gotoxy(5, 4); textcolor(lightgreen); write('[2]'); textcolor(white); writeln(' Menu de CLIENTES');
                gotoxy(5, 5); textcolor(lightred); write('[0]'); textcolor(white); writeln(' Salir');
                gotoxy(5, 7); textcolor(lightcyan); write('Seleccione el '); textcolor(lightgreen); write('[numero]'); textcolor(lightcyan); write(' correspondiente al menu que desea ingresar: ');textcolor(white);
                ingreso:= readkey; writeln();
                IF (ingreso <> '0') AND (ingreso <> '1') AND (ingreso <> '2') THEN
                   begin
                        CARTELERROR('Error. El caracter ingresado no corresponde a ningun menu.'); readkey; ClrScr;
                   end;
          until (ingreso = '0') OR (ingreso = '1') OR (ingreso = '2');

          case ingreso of
               '1': IngresoEmpresas();
               '2': IngresoClientes();
               '0': Salir();
          end;

     End;

BEGIN
     OpenFileCiudades;
     OpenFileEmpresas;
     OpenFileProyectos();
     OpenFileProductos();
     OpenFileClientes();
     Ceros();
     textcolor(white);
     banderamenuprincipal:=1;
     while banderamenuprincipal = 1 DO
           begin
                MENUPRINCIPAL();
           end;
     readkey;
END.                                                                                                                                                                                                                                                write('puto el que lee'); textcolor(white); write(' puto el que lee'); textcolor(LightMagenta); write(' puto el que lee'); textcolor(white); writeln(' puto el que lee');
