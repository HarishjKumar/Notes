using System;

public class Testclass
{
public static void Main(string[] args)
{
if(args.Length==0)
{
Console.WriteLine("Usage:\n arrays 55\n" + 
"where number is an integer between 1 and 100.");
return;
}
int number = Convert.ToInt32(args[0]);
Console.WriteLine("Args[0] = {0}" , number);
//number = 100;
int[] arr = new int[number];
Random r = new Random();
for(int i=0;i<arr.Length;i++)
{
arr[i] = r.Next(500,1000);
}
Console.WriteLine("Array declared, initialized. Printing now...");
foreach(int num in arr)
{
Console.Write("{0}\t",num);
}
Console.WriteLine("\n Printing Done. Sorting the array now...");

Array.Sort(arr);
Console.WriteLine("Sorting done. Printig the array now..");
foreach(int num in arr)
{
Console.Write("{0}\t",num);
}
Console.WriteLine("\n Printing Done. Searching for elements...");

Console.Write("Enter value Search: ");
int searchFor = Convert.ToInt32(Console.ReadLine());
int foundAt = Array.BinarySearch(arr, searchFor);
//Binary search returns a +ve number if found,else -ve number
Console.WriteLine("Value {0} is {1}", searchFor,(foundAt >-1)?
							string.Format("found at {0}.", foundAt) :
							"not found."
		);

//Multi-Dimensions
int[,] twoD = new int[5,5];
for(int i=0;i<twoD.GetLength(0); i++)
	for(int j=0;j<twoD.GetLength(1);j++)
		twoD[i,j]=i*j;
Console.WriteLine("Two dimension array created and initialized.");
Console.WriteLine("Printing the elements of the array ");
for(int i=0;i<twoD.GetLength(0); i++)
{
	for(int j=0;j<twoD.GetLength(1);j++)
	{
		Console.Write(twoD[i,j] + "\t");
	}
	Console.WriteLine();
}


int[,,] threeD = {{{10,20,30},{20,30,40}},{{30,40,50},{40,50,60}}};
for(int i=0;i<threeD.GetLength(0); i++)
{
	Console.WriteLine("Dimension {0}, Element: {1}", 0, i);
	for(int j=0;j<threeD.GetLength(1);j++)
	{
	Console.WriteLine("\nDimension {0}, Element: {1}", 0, i);
		for(int k=0;k<threeD.GetLength(2);k++)
		{
			Console.Write(threeD[i,j,k] + "\t");
		}
	}
	Console.WriteLine();
}
Console.WriteLine();
}
}