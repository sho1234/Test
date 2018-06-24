using System.Drawing;

namespace ConsoleApplication4
{
    public class CoodinateConvertorFactory
    {
        public CoodinateConvertor FromPixel(SizeF imageSize, PointF originPixel, float pixelPerMillimeter)
        {
            return new CoodinateConvertor(imageSize, originPixel, pixelPerMillimeter);
        }

        public CoodinateConvertor FromMillimeter(SizeF imageSize, PointF originMillimeter, float millimeterPerPixel)
        {
            var originPixel = new PointF
            {
                X = originMillimeter.X / millimeterPerPixel,
                Y = originMillimeter.Y / millimeterPerPixel
            };
            var pixelPerMillimeter = 1 / millimeterPerPixel;
            return new CoodinateConvertor(imageSize, originPixel, pixelPerMillimeter);
        }

        public CoodinateConvertor FromImageCenterMillimeter(SizeF imageSize, PointF imageCenterMillimeter, float millimeterPerPixel)
        {
            var originPixel = new PointF
            {
                X = imageSize.Width * 0.5F + imageCenterMillimeter.X / millimeterPerPixel,
                Y = imageSize.Height * 0.5F + imageCenterMillimeter.Y / millimeterPerPixel
            };
            var pixelPerMillimeter = 1 / millimeterPerPixel;
            return new CoodinateConvertor(imageSize, originPixel, pixelPerMillimeter);
        }

    }
}