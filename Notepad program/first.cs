//using System;

namespace Canarys
{
	public class Console
	{
		public void Show()
		{
			System.Console.WriteLine("Canarys.Console.Show()");
		}
	}
	namespace Dotnet
	{
		public class Console
		{
			public void Show()
			{
				System.Console.WriteLine("Canarys.Dotnet.Console.Show()");
			}
		}
	}
}
public class TestClass
{
	public static void Main()
	{
		Canarys.Console cc = new Canarys.Console();
		cc.Show();
		Canarys.Dotnet.Console cdc = new Canarys.Dotnet.Console();
		cdc.Show();
	}
}