{*
  Gra Symbole Chemiczne oryginalnie zamieszczona jako
  listing kodu ´r¢dàowego w podreczniku do nauki Chemii
  dla klas 7-8. Autorzy podr©cznika: Zofia Kluz,
  Krystyna Lopata. Wydawnictwo WSiP (1997).

  https://github.com/clash82/symbole-chemiczne
*}

PROGRAM Symbole;

USES Crt, Graph;

CONST

 ESC = #27;
 MAXPIERW = 28;
 ILOSC = 20;
 SZYBKOSC = 5;
 pierwiastek: array [1..MAXPIERW] of
                              record
                                symbol: string [2];
                                nazwa: string [10];
                              end =

            ((symbol: 'Na'; nazwa: 'S‡D'    ),
             (symbol: 'K' ; nazwa: 'POTAS'  ),
             (symbol: 'Ca'; nazwa: 'WAP„'   ),
             (symbol: 'Mg'; nazwa: 'MAGNEZ' ),
             (symbol: 'Al'; nazwa: 'GLIN'   ),
             (symbol: 'Fe'; nazwa: 'ΩELAZO' ),
             (symbol: 'Cu'; nazwa: 'MIEDç'  ),
             (symbol: 'Zn'; nazwa: 'CYNK'   ),
             (symbol: 'Pb'; nazwa: 'Où‡W'   ),
             (symbol: 'Cl'; nazwa: 'CHLOR'  ),
             (symbol: 'S';  nazwa: 'SIARKA' ),
             (symbol: 'O'; nazwa : 'TLEN'   ),
             (symbol: 'N'; nazwa : 'AZOT'   ),
             (symbol: 'C'; nazwa : 'W®GIEL' ),
             (symbol: 'H'; nazwa : 'WOD‡R'  ),
             (symbol: 'P'; nazwa : 'FOSFOR' ),
             (symbol: 'Si'; nazwa: 'KRZEM'  ),
             (symbol: 'Ag'; nazwa: 'SREBRO' ),
 {2 - level} (symbol: 'Au'; nazwa: 'ZùOTO'  ),
             (symbol: 'Pt'; nazwa: 'PLATYNA'),
             (symbol: 'Ra'; nazwa: 'RAD'    ),
             (symbol: 'Hg'; nazwa: 'RT®è'   ),
             (symbol: 'Sn'; nazwa: 'CYNA'   ),
             (symbol: 'Po'; nazwa: 'POLON'  ),
             (symbol: 'Br'; nazwa: 'BROM'   ),
             (symbol: 'J'; nazwa : 'JOD'    ),
             (symbol: 'He'; nazwa: 'HEL'    ),
             (symbol: 'Ar'; nazwa: 'ARGON'  ));

 VAR

  Maxx,Maxy: word;
  xcent,ycent: word;
  Skala: integer;
  Maxcolor: word;
  Height,Width: word;

  animindex: integer;

  wodax,gorax: integer;

  obrazki: array [1..14] of pointer;
  i,j,pozycja: integer;

  ch: char;
  symb: string [2];
  outstr: string [5];
  punkty: integer;
  czasreakcji: word;
  los: integer;
  level,licznik: integer;

  firstletter: boolean;
  ok,zderzenie: boolean;

  procedure init;
  var
       driver,mode: integer;
       errorcode: integer;
  begin
    driver := Detect;
    initGraph(driver,mode,'');
    errorcode := GraphResult;
    if errorcode <> grOk then
       begin
          case errorcode of
          -2: Writeln('Bù§D: Nie wykryto karty graficznej');
          -3: Writeln('Bù§D: Brak zbioru zawieraj•cego sterownik graficzny (*.BGI)');
          -4: Writeln('Bù§D: Niedobry sterownik graficzny (*.BGI)');
          -5: Writeln('Bù§D: Brak pami©ci do zaàadowania sterownika graficznego');
          end;
          Halt(1);
       end;
    randomize;
    cleardevice;
    Maxx := Getmaxx;
    Maxy := Getmaxy;
    xcent := maxx div 2;
    ycent := maxy div 2;
    Skala := Maxx div 319;
    Maxcolor := Getmaxcolor;
    Height := Textheight('M');
    Width := Textwidth('M');
 end;    { Init }

procedure welcome;
begin

    Cleardevice;
    Outtextxy(20,45,'                      …ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
    Outtextxy(20,50,'                      ∫                               ∫');
    Outtextxy(20,55,'                      ∫     - SYMBOLE CHEMICZNE -     ∫');
    Outtextxy(20,60,'                      ∫                               ∫');
    Outtextxy(20,65,'                      »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
    Outtextxy(50,160,' Instrukcja:');
    Outtextxy(70,180,' Statki o nazwach pierwiastk¢w chemicznych musisz');
    Outtextxy(60,190,' doprowadziÜ bezpiecznie do portu. Po drodze napotykaj•');
    Outtextxy(60,200,' one g¢ry lodowe. Aby statek nie rozbià si©, naleæy');
    Outtextxy(60,210,' poprawnie wpisaÜ symbol pierwiastka chemicznego, kt¢rego');
    Outtextxy(60,220,' nazw© nosi statek.');
    Outtextxy(50,240,' Wybierz jedn• z poniæszych opcji:');
    Outtextxy(70,260,' 1   - gra na podstawowym poziomie (18 pierwiastk¢w)');
    Outtextxy(70,270,' 2   - poziom bardziej zaawansowany');
    Outtextxy(70,280,' ESC - zako‰czenie programu');
end;   {welcome}

procedure brr(j:integer);
begin
   sound(j);
   delay(15);
   nosound;
end;

procedure learn;
var
   size: word;
   i: integer;

procedure rysstatek(x,y:word);
begin
   setcolor(Maxcolor);
   moveto(x,y);
   linerel(160,0);
   linerel(-12,0);
   linerel(2,-2);
   linerel(10,-18);
   linerel(-30,0);
   linerel(-5,5);
   linerel(-90,0);
   linerel(-1,-15);     { nadbud }
   linerel(3,0);
   linerel(-40,0);
   linerel(3,0);
   linerel(0,15);
   linerel(34,0);
   linerel(-45,0);      { ruf }
   linerel(1,9);
   linerel(1,3);
   linerel(2,2);
   linerel(3,1);
   linerel(4,0);

   line(x+70,y-16,x+70,y-40);   {dzwigi}
   line(x+70,y-25,x+60,y-37);
   line(x+110,y-16,x+110,y-40);
   line(x+110,y-25,x+100,y-37);

   line(x+40,y-16,x+67,y-16);
   line(x+40,y-17,x+67,y-17);
   line(x+75,y-16,x+107,y-16);
   line(x+75,y-17,x+107,y-17);

   circle(x+145,y-15,1);
   circle(x+16,y-25,2);
   circle(x+24,y-25,2);
end;    { rysunek }

begin

{---------------------------------------------------------------------------}
{                    Zapamietanie obrazkow do animacji                      }
{---------------------------------------------------------------------------}

{*******Statek******}

size := imagesize(4,140,190,180);
for i:=1 to 4 do getmem(obrazki[i],size);

rysstatek(30,180);

putpixel(13,179,Maxcolor);         { pierwszy image }
putpixel(16,179,Maxcolor);
putpixel(18,179,Maxcolor);
putpixel(19,179,Maxcolor);

for j:=0 to 14 do
    begin;
        putpixel(34+i*10,180,0);
        putpixel(34+i*10,179,Maxcolor);
    end;

getimage(4,140,190,180,obrazki[1]^);

setcolor(0);                       { drugi image }
line(10,179,20,179);
line(28,179,174,179);
setcolor(Maxcolor);
line(28,180,178,180);

putpixel(12,179,Maxcolor);
putpixel(15,179,Maxcolor);
putpixel(17,179,Maxcolor);
putpixel(18,179,Maxcolor);
putpixel(19,179,Maxcolor);

for i:=0 to 14 do
     begin;
        putpixel(31+1*10,180,0);
        putpixel(32+i*10,180,0);
        putpixel(33+i*10,180,0);
        putpixel(31+i*10,179,Maxcolor);
        putpixel(33+i*10,179,Maxcolor);
        putpixel(32+i*10,178,Maxcolor);
        putpixel(33+i*10,178,Maxcolor);
     end;

getimage(4,140,190,180,obrazki[2]^);

setcolor(0);                { trzeci image }
line(10,179,20,179);
line(28,179,174,179);
line(28,178,174,178);
setcolor(Maxcolor);
line(28,180,178,Maxcolor);
putpixel(11,179,Maxcolor);
putpixel(14,179,Maxcolor);
putpixel(16,179,Maxcolor);
putpixel(17,179,Maxcolor);
putpixel(18,179,Maxcolor);

for i:=0 to 14 do
     begin;

putpixel(29+i*10,180,0);
putpixel(30+i*10,180,0);
putpixel(31+i*10,180,0);
putpixel(29+i*10,179,Maxcolor);
putpixel(31+i*10,179,Maxcolor);
putpixel(29+i*10,178,Maxcolor);
putpixel(30+i*10,178,Maxcolor);
end;

getimage(4,140,190,180,obrazki[3]^);

setcolor(0);                 { czwarty image }
line(10,179,20,179);
line(28,179,174,179);
line(28,178,174,178);
setcolor(Maxcolor);
line(28,180,178,180);
putpixel(13,179,Maxcolor);
putpixel(15,179,Maxcolor);
putpixel(16,179,Maxcolor);
putpixel(19,179,Maxcolor);

for i:=1 to 14 do
     begin;
        putpixel(28+i*10,180,0);
        putpixel(28+i*10,179,Maxcolor);
     end;

getimage(4,140,190,180,obrazki[4]^);

{***********Gora lodawa**********}

size := imagesize(300,180,355,140);
for i:=5 to 6 do getmem(obrazki[i],size);

moveto(300,180);
linerel(15,-40);
linerel(30,10);
linerel(10,30);
getimage(300,180,355,140,obrazki[5]^);
setcolor(0);
moveto(300,180);
linerel(15,-40);
linerel(30,10);
linerel(10,30);

setcolor(Maxcolor);
moveto(302,180);
linerel(13,-40);
linerel(30,9);
linerel(11,31);
getimage(300,180,355,140,obrazki[6]^);

{************ Zatopienie ***********}

size := imagesize(410,120,590,160);
for i:=10 to 14 do getmem(obrazki[i],size);
setfillstyle(Solidfill,0);

for i:=1 to 5 do
begin
bar(410,120,590,200);
rysstatek(430,160+i*8);
bar(410,160,590,200);
getimage(410,120,590,160,obrazki[i+9]^);
end;

{************Woda************}

size :=imagesize(10,190,Maxx-2,192);
for i:=7 to 9 do getmem(obrazki[i],size);

setfillstyle(Solidfill,Maxcolor);
line(10,192,Maxx-5,192);
getimage(10,190,Maxx-2,192,obrazki[7]^);

for i:=0 to (Maxx div 10)-2 do
begin
putpixel(i*10+12,192,0);
putpixel(i*10+12,191,Maxcolor);
end;
getimage(10,190,Maxx-2,192,obrazki[8]^);

for i:=0 to (Maxx div 10)-2 do
begin

putpixel(i*10+11,192,0);
putpixel(i*10+12,192,0);
putpixel(i*10+13,192,0);
putpixel(i*10+11,191,Maxcolor);
putpixel(i*10+12,191,0);
putpixel(i*10+13,191,Maxcolor);
putpixel(i*10+12,190,Maxcolor);
end;
getimage(10,190,Maxx-2,192,obrazki[9]^);

end;      { learn }

procedure animstatprosto(x: integer);
begin
putimage(x,ycent,obrazki[1+(animindex div 3) mod 4]^,normalput);
end;

procedure animstattonie;
begin
putimage(pozycja,ycent,obrazki[10+(animindex div 6) mod 5]^,normalput);
end;

procedure animgora;
begin
putimage(gorax,ycent,obrazki[5+(animindex div 5) mod 2]^,normalput);
end;

procedure animwoda;
begin
putimage(wodax,ycent+38,obrazki[7+(animindex div 5) mod 3]^,normalput);
end;

procedure topsie;
begin
   setfillstyle(Solidfill,0);
   bar(xcent-50,ycent div 2,xcent+50,ycent div 2 + Height);
   setfillstyle(Solidfill,Maxcolor);
   outtextxy(xcent-50,ycent div 2,'çLE, ma byÜ '+symb);
   animindex:=1;
   repeat
      animstattonie;
      animgora;
      animwoda;
      brr(20);brr(20);brr(20);
      animindex:=(animindex+1) mod 60;
   until animindex>24;
   delay(1000);
   setfillstyle(Solidfill,0);
   bar(0,0,Maxx,Maxy);
   setfillstyle(Solidfill,Maxcolor);
end;    { topsie }

procedure jedzdokonca;
begin
punkty:=punkty+1;
czasreakcji:=czasreakcji+pozycja-10;
setfillstyle(Solidfill,0);
bar(0,ycent div 2 - 2*Height,Maxx,ycent div 2 + 2*Height);
setfillstyle(Solidfill,Maxcolor);

str(punkty:2,outstr);
outtextxy(xcent div 2,ycent div 2 - 2*Height,'Zdobyte punkty: '+outstr);
str(czasreakcji:5,outstr);
outtextxy(xcent,ycent div 2 - 2*Height,'Czas reakcji: '+outstr);
outtextxy(xcent-50,ycent div 2,'Dobra odpowied´!');

repeat
animgora;
animwoda;
animstatprosto(pozycja);
brr(20);
animindex:=(animindex+1) mod 60;
pozycja:=pozycja+3*SZYBKOSC;
until pozycja+180>Maxx-5;
setfillstyle(Solidfill,0);
bar(0,0,Maxx,Maxy);
setfillstyle(Solidfill,Maxcolor);

end;      { jedz do konca }

procedure ocena;
begin
setfillstyle(Solidfill,0);
bar(0,0,Maxx,Maxy);
setfillstyle(Solidfill,Maxcolor);

setfillstyle(Solidfill,0);
bar(0,ycent div 2 - 2*Height,Maxx,ycent div 2 + 2*Height);
setfillstyle(Solidfill,Maxcolor);

str(ILOSC:3,outstr);

outtextxy(xcent div 2,ycent div 2 - 2*Height,'IloòÜ pyta‰: '+outstr);
str(punkty:3,outstr);
outtextxy(xcent div 2,ycent div 2,'Zdobyte punkty: '+outstr);
str(czasreakcji:5,outstr);
outtextxy(xcent div 2,ycent div 2 + 2*Height,'Czas reakcji: '+outstr);
if punkty>0 then str (czasreakcji/punkty:4:2,outstr) else outstr:='---';
outtextxy(xcent div 2,ycent div 2 + 4*Height,'Czas òredni: '+outstr);
outtextxy(xcent div 2,ycent div 2 + 6*Height,'Naciònij dowolny klawisz...');
ch:=readkey;
end;

{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}

begin {Program symbole}

Init;
learn;

repeat
welcome;

repeat
ch:=upcase(readkey);
until (ch='1') or (ch='2') or (ch=ESC);
if ch=ESC then begin closegraph; Halt(0); end;

if ch='1' then level:=18 else level:=MAXPIERW;

clearviewport;
wodax:=10;
punkty:=0;
czasreakcji:=0;

for licznik :=1 to ILOSC do
begin;
los:=random(level)+1;

setfillstyle(Solidfill,0);
bar(0,ycent div 2,Maxx,ycent div 2 + Height);
setfillstyle(Solidfill,Maxcolor);

outtextxy(xcent-50,ycent div 2,pierwiastek[los].nazwa);

symb:=pierwiastek[los].symbol;
animindex:=1;
pozycja:=10;
gorax:=xcent;
if licznik<2*ILOSC div 3 then gorax:=xcent+xcent div 4;
if licznik<ILOSC div 3 then gorax:=Maxx*3 div 4;
ok:=FALSE;
firstletter:=TRUE;

repeat

animgora;
animwoda;

animstatprosto(pozycja);
brr(pozycja + 20);

zderzenie:=(pozycja+180>=gorax);

if keypressed then
begin
ch:=upcase(readkey);

if firstletter
then begin
if length(symb)=1
then begin
if symb[1]=ch then ok:=TRUE;
end
else begin
if symb[1]=ch then firstletter:=FALSE
end;
end
else begin
if upcase(symb[2])=ch
then begin ok:=TRUE; end
else begin
if symb[1]<>ch then
firstletter:=TRUE;
end;
end;
end; { if keypressed }

animindex:=(animindex+1) mod 60;
pozycja:=pozycja+SZYBKOSC;

until (ch=ESC) or zderzenie or ok;
if ok then jedzdokonca;
if zderzenie then topsie;
if ch=ESC then begin closegraph; halt(0); end;

end;   { for 0-ILOSC }

ocena;

until ch=ESC;

END. {Program Symbole}