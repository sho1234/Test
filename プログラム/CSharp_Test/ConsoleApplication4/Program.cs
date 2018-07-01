using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication4
{
    class Program
    {
        static void Main(string[] args)
        {
            SizeF imageSize = new SizeF(1000, 1000);
            PointF originPixel = new PointF(0, 0);
            PointF imageCenterMillimeter = new PointF(100, 100);
            float pixelPerMillimeter = 100F;
            float millimeterPerPixel = 0.01F;

            var coodinateConvertorFactory = new CoodinateConvertorFactory();
            //CoodinateConvertor coodinateConvertor = coodinateConvertorFactory.FromPixel(imageSize, originPixel, pixelPerMillimeter);
            CoodinateConvertor coodinateConvertor = coodinateConvertorFactory.FromImageCenterMillimeter(imageSize, imageCenterMillimeter, millimeterPerPixel);
            Console.WriteLine(coodinateConvertor.MillimeterToPixel(new PointF(0, 0)));
            Console.WriteLine(coodinateConvertor.MillimeterToPixel(new PointF(5, 5)));
            Console.WriteLine(coodinateConvertor.PixelToMillimeter(new PointF(0, 0)));
            Console.WriteLine(coodinateConvertor.PixelToMillimeter(new PointF(500, 500)));
            Console.ReadKey();
        }
    }
}
