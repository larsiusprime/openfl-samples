package;


import openfl.display.Bitmap;
import openfl.display.BitmapData;
import flash.display.GradientType;
import flash.display.InterpolationMethod;
import flash.display.Shape;
import flash.display.SpreadMethod;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.Assets;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var gradient = createGradient(200, 200, [0xFFFF0000, 0xFF0000FF], 1, 90);
		addChild(gradient);
		
		/*var shape = new Shape();
		shape.graphics.beginFill(0xFF0000,0.5);
		shape.graphics.drawRect(0, 0, 100, 100);
		shape.graphics.endFill();
		addChild(shape);
		*/
		
		/*
		var shape = new Shape();
		shape.graphics.beginFill(0x0000FF, 0.5);
		shape.graphics.drawCircle(50, 50, 50);
		shape.graphics.endFill();
		addChild(shape);
		*/
	}
	
	public function createGradient(width:Int, height:Int, colors:Array<UInt>,
		chunkSize:UInt = 1, rotation:Int = 90, interpolate:Bool = true):Shape
	{
		//	Sanity checks
		if (width < 1)
		{
			width = 1;
		}
		
		if (height < 1)
		{
			height = 1;
		}
		
		var gradient:GradientMatrix = createGradientMatrix(width, height, colors, chunkSize, rotation);
		var shape = new Shape();
		var interpolationMethod = interpolate ? InterpolationMethod.RGB : InterpolationMethod.LINEAR_RGB;
		
		shape.graphics.beginGradientFill(GradientType.LINEAR, colors, gradient.alpha, gradient.ratio,
			gradient.matrix, SpreadMethod.PAD, interpolationMethod, 0);
		
		shape.graphics.drawRect(0, 0, width, height / chunkSize);
		
		shape.graphics.endFill();
		
		return shape;
	}
	
	public function rasterizeGradient(shape:Shape, width:Int, height:Int, chunkSize:Int):BitmapData
	{
		var data = new BitmapData(width, height, true, 0x00000000);
		
		if (chunkSize == 1)
		{
			data.draw(shape);
		}
		else
		{
			var tempBitmap = new Bitmap(new BitmapData(width, Std.int(height / chunkSize), true, 0x00000000));
			tempBitmap.bitmapData.draw(shape);
			tempBitmap.scaleY = chunkSize;
			
			var sM = new Matrix();
			sM.scale(tempBitmap.scaleX, tempBitmap.scaleY);
			
			data.draw(tempBitmap, sM);
		}
		
		return data;
	}
	
	private function toRadians(degrees:Float):Float
	{
		if (degrees < 0) { degrees += 360; }
		if (degrees > 360) { degrees -= 360; }
		return degrees * (180 / Math.PI);
	}
	
	private function alphaFloat(color:Int):Float
	{
		return ((color >> 24) & 0xFF) / 255;
	}
	
	public function createGradientMatrix(width:Int, height:Int, colors:Array<UInt>, chunkSize:Int = 1,
		rotation:Int = 90):GradientMatrix
	{
		var gradientMatrix = new Matrix();
		
		//	Rotation (in radians) that the gradient is rotated
		var rot:Float = toRadians(rotation);
		
		//	Last 2 values = horizontal and vertical shift (in pixels)
		gradientMatrix.createGradientBox(width, height / chunkSize, rot, 0, 0);
		
		//	Create the alpha and ratio arrays
		var alpha = new Array<Float>();
		
		for (ai in 0...colors.length)
		{
			alpha.push(alphaFloat(colors[ai]));
		}
		
		var ratio = new Array<Int>();
		
		if (colors.length == 2)
		{
			ratio[0] = 0;
			ratio[1] = 255;
		}
		else
		{
			//	Spread value
			var spread:Int = Std.int(255 / (colors.length - 1));
			
			ratio.push(0);
			
			for (ri in 1...(colors.length - 1))
			{
				ratio.push(ri * spread);
			}
			
			ratio.push(255);
		}
		
		return { matrix: gradientMatrix, alpha: alpha, ratio: ratio };
	}
}

typedef GradientMatrix =
{
	matrix:Matrix,
	alpha:Array<Float>,
	ratio:Array<Int>
}