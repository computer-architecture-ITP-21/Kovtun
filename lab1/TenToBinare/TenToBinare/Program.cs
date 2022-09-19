
Console.WriteLine("Введите число");
double Num = Convert.ToDouble(Console.ReadLine());
int[] DoubleNum = new int[20];
int i, n = 20, test; // n - точность
do
{
    int j = 0;
    for (i = 0; i < n; i++)
    {
        Num *= 2;
        if (Num >= 1)
        {
            Num--;
            DoubleNum[j] = 1;
        }
        else
        {
            DoubleNum[j] = 0;
        }
        j++;
    }


    Console.WriteLine("число в двоичной системе исчесления: ");
    Console.Write("0,");
    for (i = 0; i < DoubleNum.Length; i++)
    {
        Console.Write(DoubleNum[i]);
    }
    Console.WriteLine("\n1. Ввести еще 1 число");
    Console.WriteLine("2. Выйти");
    test = Convert.ToInt32(Console.ReadLine());
}
while (test != 2);