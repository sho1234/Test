using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication4
{
    public class CoodinateConvertor
    {
        private readonly SizeF _imageSize;
        private readonly PointF _originPixel;
        private readonly float _pixelPerMillimeter;

        public CoodinateConvertor(SizeF imageSize, PointF originPixel, float pixelPerMillimeter)
        {
            _imageSize = imageSize;
            _originPixel = originPixel;
            _pixelPerMillimeter = pixelPerMillimeter;
        }

        public float PixelToMillimeter(float pixel)
        {
            return pixel / _pixelPerMillimeter;
        }

        public PointF PixelToMillimeter(PointF pixel)
        {
            PointF millimeter = new PointF
            {
                X = PixelToMillimeter(_originPixel.X + pixel.X),
                Y = PixelToMillimeter(_originPixel.Y + pixel.Y)
            };
            return millimeter;
        }

        public float MillimeterToPixel(float millimeter)
        {
            return millimeter * _pixelPerMillimeter;
        }

        public PointF MillimeterToPixel(PointF millimeter)
        {
            PointF pixel = new PointF
            {
                X = _originPixel.X + MillimeterToPixel(millimeter.X),
                Y = _originPixel.Y + MillimeterToPixel(millimeter.Y)
            };
            return pixel;
        }
    }
}
