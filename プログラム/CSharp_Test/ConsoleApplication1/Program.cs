using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            const string filePath = "../../test.csv";
            var csvUtility = new CSVUtility(filePath);
            csvUtility.ShowCSV();
            csvUtility.WriteCSV("../../test_.csv");
            Console.ReadKey();
        }
    }
}
