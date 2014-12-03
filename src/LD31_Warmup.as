package
{
	import org.flixel.FlxGame;
	
	[SWF(width="480", height="480", backgroundColor="#666666")]
	
	public class LD31_Warmup extends FlxGame
	{
		public function LD31_Warmup()
		{
			super(480, 480, ScreenState, 1.0, 60, 60, true);
			forceDebugger = true;
		}
	}
}