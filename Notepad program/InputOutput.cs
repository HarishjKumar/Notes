using System;
public class TestClass
{
	public static void Main()
	{
		string name = "Canarys";
		Console.WriteLine("Welcome "  + name + "!!");
		Console.WriteLine("Welcome {0} !!" ,name);
		int  first=10, second=20;
		Console.WriteLine(10 + " + " + 20 + " = " + (10+20));
		Console.WriteLine("{0} + {1} = {2} " ,first, second, (first + second));
		//CS7
		Console.WriteLine($"{first} + {second} + {first + second}");

		//input operation
		Console.Write("Enter Name: ");
		name = Console.ReadLine(); //returns string terminated by \n
		Console.WriteLine("You entered: {0}", name);

		int age=0;
		Console.WriteLine("Enter Age: ");
		age = Convert.ToInt32(Console.ReadLine());
		Console.WriteLine($"Age is {age}");

		Console.Write("Enter a letter: ");
		first = Console.Read(); 
		Console.WriteLine("ASCII value is: {0}", (first));

		//Console.WriteLine("Press a key to terminate.");
		//Console.ReadKey(); 
		
		
	}
}