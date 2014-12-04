package
{
	import flash.display.BitmapData;
	
	import org.flixel.*;
		
	public class NewButton extends FlxButton
	{
		[Embed(source="../assets/images/newButton.png")] protected var imgNewButton:Class;
		
		/**
		 * Internal, stores the entire source graphic (not the current displayed animation frame), used with Flash getter/setter.
		 */
		protected var _rawPixels:BitmapData;
		
		public function NewButton(X:Number, Y:Number, Width:Number, Height:Number, Label:String = null, OnClick:Function = null)
		{
			super(X, Y);
			
			if(Label != null)
			{
				label = new FlxText(0, 0, Width, Label);
				label.setFormat(null, 8, 0x333333, "center");
				labelOffset = new FlxPoint(-1, 3);
			}
			
			_bakedRotation = 0;
			_rawPixels = FlxG.addBitmap(imgNewButton);
			_flipped = 0;
			if(Width < 12)
				Width = 12;
			width = frameWidth = Width;
			if(Height < 12)
				Height = 12;
			height = frameHeight = Height;
			resetNewHelpers();
			
			onUp = OnClick;
			onDown = null;
			onOut = null;
			onOver = null;
			
			soundOver = null;
			soundOut = null;
			soundDown = null;
			soundUp = null;
			
			status = NORMAL;
			_onToggle = false;
			_pressed = false;
			_initialized = false;
		}
		
		override public function update():void
		{	
			super.update();
		}

		protected function resetNewHelpers():void
		{
			if((_pixels == null) || (_pixels.width != width) || (_pixels.height != 3 * height))
				_pixels = new BitmapData(width, 3 * height);
			
			var _w:int = Math.ceil(width / 4);
			var _h:int = Math.ceil(height / 4);
			var _sourceX:Number;
			var _sourceY:Number;
			var _destX:Number;
			var _destY:Number;
			for (var _y:int = 0; _y < _h; _y++)
			{
				for (var _x:int = 0; _x < _w; _x++)
				{
					if (_y == 0)
					{
						_sourceY = 0;
						_destY = 0;
					}
					else if (_y == _h - 1)
					{
						_sourceY = 8;
						_destY = height - 4;
					}
					else
					{
						_sourceY = 4;
						_destY = 4 * _y;
					}
					
					if (_x == 0)
					{
						_sourceX = 0;
						_destX = 0;
					}
					else if (_x == _w - 1)
					{
						_sourceX = 8;
						_destX = width - 4;
					}
					else
					{
						_sourceX = 4;
						_destX = 4 * _x;
					}
					
					_flashRect.setTo(_sourceX, _sourceY, 4, 4);
					_flashPoint.setTo(_destX, _destY);
					_pixels.copyPixels(_rawPixels, _flashRect, _flashPoint);
					
					_flashRect.x += 12;
					_flashPoint.y += height;
					_pixels.copyPixels(_rawPixels, _flashRect, _flashPoint);
					
					_flashRect.x += 12;
					_flashPoint.y += height;
					_pixels.copyPixels(_rawPixels, _flashRect, _flashPoint);
				}
			}
			resetHelpers();
		}
	}
}