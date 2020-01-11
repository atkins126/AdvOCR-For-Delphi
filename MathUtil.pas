unit MathUtil;

interface

uses
  Forms, Classes, SysUtils, ShlObj;


  Function HexToInt(Hex :String):Int64;
  procedure AddSlPro(Sl : TStringList; str : String);
  function IndexOfPro(Sl : TStringList; Str : String): Integer;
  procedure UpDateSlItem(Sl : TStringList; idx : Integer);
  function GetTail(Str: String): Integer;
  function GetHead(Str: String): String;
  Procedure SortPro(SL :TStringList; iLo,iHi: Integer);
  procedure InvertSl(SL : TStringList);
  procedure SelectionSort(var a: array of integer);
  function CountSub(Sub : String; Str : String): Byte;
  function GetSpecialFolderDir(const folderid: integer): string;
  procedure RmEnter(var Str : String);
  procedure RmC(var Str : String; C : Char);

implementation

uses
  define;

Function HexToInt(Hex :String):Int64;
Var
    Sum : Int64;
    I,L : Integer;
Begin
  L := Length(Hex);
  Sum := 0;
  For I := 1 to L Do
   Begin
   Sum := Sum * 16;
   If ( Ord(Hex[I]) >= Ord('0')) and (Ord(Hex[I]) <= Ord('9')) then
      Sum := Sum + Ord(Hex[I]) - Ord('0')
   else If ( Ord(Hex[I]) >= Ord('A') ) and (Ord(Hex[I]) <= Ord('F')) then
      Sum := Sum + Ord(Hex[I]) - Ord('A') + 10
   else If ( Ord(Hex[I]) >= Ord('a') ) and ( Ord(Hex[I]) <= Ord('f')) then
      Sum := Sum + Ord(Hex[I]) - Ord('a') + 10
   else
      Begin
      Sum := -1;
      break;
      End;
   End;
  Result := Sum;
End;

procedure AddSlPro(Sl : TStringList; str : String);
var
  idx : Integer;
begin
  idx := IndexOfPro(Sl,str);
  if idx=-1 then
    Sl.Add(str+Sp+'1')
  else
    UpDateSlItem(Sl,idx);
end;

function IndexOfPro(Sl : TStringList; Str : String): Integer;
var
  TpSl : TStringList;
  i : Integer;
begin
  TpSl := TStringList.Create;
  for i:=0 to Sl.Count-1 do
  TpSl.Add(GetHead(Sl[i]));
  Result := TpSl.IndexOf(Str);
  TpSl.Free;
end;

procedure UpDateSlItem(Sl : TStringList; idx : Integer);
var
  Temp : String;
  tp : Integer;
begin
  tp := GetTail(Sl[idx]);
  Temp := GetHead(Sl[idx])+Sp+IntToStr(tp+1);
  Sl[idx] := Temp;
end;

function GetTail(Str: String): Integer;
var
  iPos : Integer;
  Temp : String;
begin
  Temp := Str;
  iPos := Pos(Sp,Str);
  if iPos>0 then
  Delete(Temp,1,iPos+Length(Sp)-1);
  result := StrToInt(Temp);
end;


function GetHead(Str: String) : String;
var
  iPos : Integer;
begin
  iPos := Pos(Sp,Str);
  if iPos>0 then
  result := copy(str,1,iPos-1);
end;

Procedure SortPro(SL :TStringList; iLo,iHi: Integer);
var
  Lo, Hi, Mid : Integer;
  T : String;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := GetTail(SL[(Lo + Hi) div 2]);
  repeat
    while GetTail(SL[Lo]) < Mid do Inc(Lo);
    while GetTail(SL[Hi]) > Mid do Dec(Hi);
    if Lo <= Hi then
    begin
      T := SL[Lo];
      SL[Lo] := SL[Hi];
      SL[Hi] := T;
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then SortPro(SL, iLo, Hi);
  if Lo < iHi then SortPro(SL, Lo, iHi);
end;

procedure InvertSl(SL : TStringList);
var
  i,Ct : Integer;
  tp : String;
begin
  Ct := Sl.Count;
  for i:=0 to Ct-1 do
  begin
    tp := SL[0];
    SL.Delete(0);
    SL.Insert(Ct-1-i,tp);
  end;
end;

procedure SelectionSort(var a: array of integer);
var
  i, j, t: integer;
begin
  for i := low(a) to high(a) - 1 do
    for j := high(a) downto i + 1 do
      if a[i] > a[j] then
      begin
        //����ֵ(a[i], a[j], i, j);
        t := a[i];
        a[i] := a[j];
        a[j] := t;
      end;
end;


function CountSub(Sub : String; Str : String): Byte;
var
  iPos : Byte;
begin
  Result := 0;
  repeat
    iPos := Pos(Sub,Str);
    if iPos > 0 then
    begin
      Inc(Result);
      Delete(Str,1,iPos+Length(Sub)-1);
    end;
  Until iPos=0;
end;


procedure RmEnter(var Str : String);
var
  i : integer;
  DelOne : boolean;
begin
  Repeat
    DelOne := false;
    for i:=1 to Length(Str)-1 do
    if (Ord(Str[i]) = $0d) and (Ord(Str[i+1]) = $0a) then
    begin
      Delete(Str,i,2);
      DelOne := true;
      break;
    end;
  Until not DelOne;
end;

procedure RmC(var Str : String; C : Char);
var
  i : Integer;
  DelOne : boolean;
begin
  Repeat
    DelOne := false;
    for i:=1 to Length(Str)-1 do
    if Str[i]= C then
    begin
      Delete(Str,i,1);
      DelOne := true;
      break;
    end;
  Until not DelOne;
end;


function GetSpecialFolderDir(const folderid: integer): string;
var
  pidl: pItemIDList;
  buffer: array[0..255] of char;
begin
  {
  AddListItem('����', GetSpecialFolderDir(0));
  AddListItem('�����û�����', GetSpecialFolderDir(25));
  AddListItem('��ʼ�˵�����', GetSpecialFolderDir(2));
  AddListItem('�����û���ʼ�˵�����', GetSpecialFolderDir(23));
  AddListItem('�ĵ�', GetSpecialFolderDir(5));
  AddListItem('�ղؼ�', GetSpecialFolderDir(6));
  AddListItem('�����û��ղؼ�', GetSpecialFolderDir(31));
  AddListItem('�����ļ���', GetSpecialFolderDir(7));
  AddListItem('�����û������ļ���', GetSpecialFolderDir(24));
  AddListItem('Recent�ļ���', GetSpecialFolderDir(8));
  AddListItem('���͵�', GetSpecialFolderDir(9));
  AddListItem('��½�û���ʼ�˵�', GetSpecialFolderDir(11));
  AddListItem('�����û���ʼ�˵�', GetSpecialFolderDir(22));
  AddListItem('�����ھ�', GetSpecialFolderDir(19));
  AddListItem('�����ļ���', GetSpecialFolderDir(20));
  AddListItem('Template�ļ���', GetSpecialFolderDir(21));
  AddListItem('�����û�Template�ļ���', GetSpecialFolderDir(45));
  AddListItem('ApplicaionData �ļ���', GetSpecialFolderDir(26));
  AddListItem('��ӡ�ļ���', GetSpecialFolderDir(27));
  AddListItem('��ǰ�û�����Ӧ�ó��������ļ���', GetSpecialFolderDir(28));
  AddListItem('Internet��ʱ�ļ���', GetSpecialFolderDir(32));
  AddListItem('Internet�����ļ���', GetSpecialFolderDir(33));
  AddListItem('��ǰ�û���ʷ�ļ���', GetSpecialFolderDir(34));
  AddListItem('�����û�Ӧ�ó��������ļ���', GetSpecialFolderDir(35));
  AddListItem('WindowsϵͳĿ¼', GetSpecialFolderDir(36));
  AddListItem('�����ļ���', GetSpecialFolderDir(38));
  AddListItem('System32ϵͳĿ¼', GetSpecialFolderDir(37));
  AddListItem('��ǰ�û�ͼƬ�ղؼ�', GetSpecialFolderDir(39));
  AddListItem('��ǰ�û��ļ���', GetSpecialFolderDir(40));
  AddListItem('�����ļ���', GetSpecialFolderDir(43));
  AddListItem('������', GetSpecialFolderDir(47));
  AddListItem('��½�û�������', GetSpecialFolderDir(48));
  AddListItem('�����û�ͼƬ�ղؼ�', GetSpecialFolderDir(54));
  AddListItem('�����û���Ƶ�ղؼ�', GetSpecialFolderDir(55));
  AddListItem('������Դ�ļ���', GetSpecialFolderDir(56));
  AddListItem('CD Burning', GetSpecialFolderDir(59));
  }
  //ȡָ�����ļ�����Ŀ��
  SHGetSpecialFolderLocation(Application.Handle, folderid, pidl);
  SHGetPathFromIDList(pidl, buffer); //ת�����ļ�ϵͳ��·��
  Result := strpas(buffer);
end;



end.
