using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication2
{
    public interface IClass1
    {
        int Add { get; }
        void Sum();
    }

    public class Class1 : IClass1
    {
        private readonly int _x;
        public int _y;

        public Class1(int x, int y)
        {
            _x = x;
            _y = y;
        }

        public int Add => _x + _y;

        public void Sum()
        {
            var i = _x + _y;
        }
    }


}
