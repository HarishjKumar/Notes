using System;

public class TestClass
{
public static void Main()
{
string byVal = "SwapByValue", byRef="SwapByRef";
string before="Before", after = "After";
string format="{0} calling {1}, a={2},b={3}";
int a=20;
int b=50;
string line = "".PadLeft(45, '=');
Console.WriteLine(format,before,byVal, a,b);
SwapByValue(a,b);
Console.WriteLine(format,after,byVal, a,b);
Console.WriteLine(line);

Console.WriteLine(format,before,byRef, a,b);
SwapByRef(ref a, ref b);
Console.WriteLine(format,after,byRef, a,b);
Console.WriteLine(line);

int sq,cube,result,num=2;
result=Power(num,out sq,out cube);
Console.WriteLine($"Num: {num}, Square: {sq}, Cube: {cube}, result: {result}");
Console.WriteLine(line);

Params("Zero");
Params("one",10);
Params("Zero",10,20,30);
Params("Zero",10,2,3,4,5,6,7,8,12,13,15);

Optional(12345,"Canarys",100);
Optional(name:"With age only",age:99);
Optional(age:77,num:8999,name:"Name");
Optional();
Console.WriteLine(line);

/*
var d= 10.0M; //decimal type
var f= 10.0F; //Floating point
var l= 10.0L; //Long type
var num2; // Error
var num=true; //Infer the type from the value assigned
*/
}

static void Optional(int num=0,string name="N.A",int age=18)
{
Console.WriteLine($"Number: {num}, Name: {name}, Age: {age}");
}

static void Params(string name, params int[] args)
{
Console.WriteLine("Name: {0}",name);
Console.WriteLine("args.Length: {0}", args.Length);
}
static int Power(int num,out int square,out int cube)
{
square = num * num;
cube = square * num;
return cube * num;
}
static void SwapByValue(int a, int b)
{
a=a+b;
b=a-b;
a=a-b;
}
static void SwapByRef(ref int a, ref int b)
{
a=a+b;
b=a-b;
a=a-b;
}
}