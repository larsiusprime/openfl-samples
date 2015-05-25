package;


import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var text = new TextField();
		
		var font = Assets.getFont("assets/LIBERATIONSERIF-REGULAR.TTF").fontName;
		
		var tf = new TextFormat(font, 36, 0x00000000, null, null, null, null, null, TextFormatAlign.LEFT, null, null, null, 0);
		
		text.border = true;
		text.borderColor = 0xFF000000;
		
		text.defaultTextFormat = tf;
		text.autoSize = TextFieldAutoSize.LEFT;
		text.type = TextFieldType.INPUT;
		
		text.x = 5;
		text.y = 5;
		
		text.text = "Hello, World!";
		addChild(text);
		
	}
	
	
}