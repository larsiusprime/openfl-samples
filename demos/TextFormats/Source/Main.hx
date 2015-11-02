package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.geom.Point;

class Main extends Sprite {
	
	private var demo:Int = 0;
	private static inline var MAX_DEMO:Int = 5;
	
	private var alpha_step:Float = 0.25;
	private var comparison:Bitmap;
	private var label:TextField;
	
	public function new () {
		
		super ();
		
		stage.color = 0xA0A0A0;
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
			if (e.keyCode == 39) {		//Right Arrow
				demo++;
				if (demo > MAX_DEMO) {
					demo = 0;
				}
				showDemo(demo);
			}
			else if (e.keyCode == 37) { //Left Arrow
				demo--;
				if (demo < 0) {
					demo = MAX_DEMO;
				}
				showDemo(demo);
			}
			else if (e.keyCode == 49) { // 1
				compare("flash");
			}
			else if (e.keyCode == 50) { // 2
				compare("legacy");
			}
			else if (e.keyCode == 51) { // 3
				compare("html5");
			}
			else if (e.keyCode == 38) { // Up
				changeAlpha(-1);
			}
			else if (e.keyCode == 40) { // Down
				changeAlpha(1);
			}
		});
		
		showDemo(demo);
	}
	
	function clear():Void
	{
		while (numChildren > 0)
		{
			removeChild(getChildAt(0));
		}
	}
	
	function getID():String
	{
		return
		#if flash
			"Flash";
		#elseif html5
			"HTML5";
		#elseif openfl_legacy
			"Legacy";
		#else
			"Next";
		#end
	}
	
	function identify():Void
	{
		var t:TextField = new TextField();
		t.text = getID();
		addChild(t);
		label = t;
	}
	
	function compare(str:String):Void
	{
		label.text = getID() + " vs " + str;
		
		if (comparison == null)
		{
			comparison = new Bitmap();
		}
		if (Assets.exists("assets/img/" + str + demo + ".png"))
		{
			comparison.bitmapData = Assets.getBitmapData("assets/img/" + str + demo + ".png");
			if (!contains(comparison))
			{
				addChildAt(comparison, 0);
			}
		}
	}
	
	function changeAlpha(i:Int):Void
	{
		if (comparison == null) return;
		var a = comparison.alpha + alpha_step * i;
		     if (a > 1.0) a = 0.0;
		else if (a < 0.0) a = 1.0;
		comparison.alpha = a;
	}
	
	function showDemo(i:Int):Void
	{
		clear();
		identify();
		
		switch(i) {
			case 0: demo0();
			case 1: demo1();
			case 2: demo2();
			case 3: demo3();
		}
		
		var t:TextField = new TextField();
		t.width = 800;
		t.y = 20;
		
		t.text = "Showing demo (" + i + "). Left/Right: Change demo; 1/2: Compare to Flash/Legacy; Up/Down: Change comparison alphas";
		addChild(t);
	}
	
	function font(str:String):String
	{
		var f = Assets.getFont("assets/"+str);
		if (f != null)
		{
			return f.fontName;
		}
		return str;
	}
	
	//Demos
	
	function demoShort(text:String):Void
	{
		var txt:String = text;
		
		var formats0 = [new TextFormat(null, null, 0xFF0000)];
		var formats1 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x00FF00)];
		var formats2 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF)];
		var formats3 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF)];
		
		var ranges = [new Point(0, 1),
					  new Point(1, 2),
					  new Point(3, 4),
					  new Point(6, 9),
					  ];
		
		makeText(50, 50, TextFormatAlign.LEFT,  24, null, false, txt, formats0, ranges);
		makeText(50, 175, TextFormatAlign.LEFT, 24, null, false, txt, formats1, ranges);
		makeText(50, 300, TextFormatAlign.LEFT, 24, null, false, txt, formats2, ranges);
		makeText(50, 425, TextFormatAlign.LEFT, 24, null, false, txt, formats3, ranges);
	}
	
	function demoMedium(text:String):Void
	{
		var txt:String = text;
		
		var formats0 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF)];
		var formats1 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF)];
		var formats2 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00)];
		var formats3 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00), new TextFormat(null, null, 0x00FFFF)];
		
		var ranges = [new Point(0, 1),
					  new Point(1, 2),
					  new Point(3, 4),
					  new Point(6, 9),
					  new Point(11, 13),
					  new Point(14, 15)  
					  ];
		
		makeText(50, 50, TextFormatAlign.LEFT,  24, null, false, txt, formats0, ranges);
		makeText(50, 175, TextFormatAlign.LEFT, 24, null, false, txt, formats1, ranges);
		makeText(50, 300, TextFormatAlign.LEFT, 24, null, false, txt, formats2, ranges);
		makeText(50, 425, TextFormatAlign.LEFT, 24, null, false, txt, formats3, ranges);
	}
	
	function demoLong(text:String, align=null):Void
	{
		var txt:String = text;
		if (align == null)
		{
			align = TextFormatAlign.LEFT;
		}
		
		var formats0 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00)];
		var formats1 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00), new TextFormat(null, null, 0x00FFFF)];
		var formats2 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00), new TextFormat(null, null, 0x00FFFF), new TextFormat(null, null, 0x80FF80)];
		var formats3 = [new TextFormat(null, null, 0xFF0000), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0x0000FF), new TextFormat(null, null, 0xFF00FF), new TextFormat(null, null, 0xFFFF00), new TextFormat(null, null, 0x00FFFF), new TextFormat(null, null, 0x80FF80), new TextFormat(null, null, 0xFF80FF)];
		
		var ranges = [new Point(0, 1),
					  new Point(1, 2),
					  new Point(3, 4),
					  new Point(6, 9),
					  new Point(10, 13),
					  new Point(14, 15),
					  new Point(60, 75),
					  new Point(82, 129)
					  ];
		
		makeText(50, 50, align,  24, null, false, txt, formats0, ranges);
		makeText(50, 175, align, 24, null, false, txt, formats1, ranges);
		makeText(50, 300, align, 24, null, false, txt, formats2, ranges);
		makeText(50, 425, align, 24, null, false, txt, formats3, ranges);
	}
	
	function demo0():Void
	{
		demoShort("Hello_World");
	}
	
	function demo1():Void
	{
		demoShort("Hello World");
	}
	
	function demo2():Void
	{
		demoMedium("Hello_World Hello World");
	}
	
	function demo3():Void
	{
		demoLong("Lorem_ipsum_dolor_sit_amet,_consectetur_adipiscing_elit,_sed_do_eiusmod_tempor_incididunt_ut_labore_et_dolore_magna_aliqua.");
	}
	
	@:access(openfl.text.TextField)
	function makeText(X:Float, Y:Float, align, size:Int, ?font:String, ?embed:Bool=false, text:String=null, formats:Array<TextFormat>=null, ranges:Array<Point>=null)
	{
		var textField = new TextField();
		textField.embedFonts = embed;
		textField.defaultTextFormat = new TextFormat(font, size, 0x000000, null, null, null, null, null, align, null, null, null, 20);
		
		textField.selectable = false;
		textField.border = true;
		textField.borderColor = 0x000000;
		
		textField.width = 700;
		textField.multiline = true;
		textField.wordWrap = true;
		
		textField.autoSize = TextFieldAutoSize.NONE;
		
		textField.x = X;
		textField.y = Y;
		
		if (text == null || text == "") {
			text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
		}
		
		textField.text = text;
		
		if(formats != null && ranges != null && formats.length <= ranges.length){
			for (i in 0...formats.length) {
				var start = Std.int(ranges[i].x);
				var end   = Std.int(ranges[i].y);
				if (start < textField.text.length) {
					if (end > textField.text.length) end = textField.text.length;
					textField.setTextFormat(formats[i], start, end);
				}
			}
		}
		
		addChild (textField);
		
		#if !flash
		#if !legacy
		trace("FORMATS:");
		for (tfr in textField.__textEngine.textFormatRanges) {
			trace("tfr : " + tfr.start + "," + tfr.end + " color:0x" + StringTools.hex(tfr.format.color, 6));
		}
		#end
		#end
	}
}